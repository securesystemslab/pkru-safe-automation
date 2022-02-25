import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import printutil as pt

from scipy import stats

def generate_jetstream_plots():
    names = ["base", "alloc", "mpk"]
    fscores = {}
    fscores = {}
    wsldata = {}
    frames = {}
    jsscoredata = {}

    for name in names:
        fname = 'data/jetstream_' + name + '.json'
        fscores[name] = {}
        data = {}
        jsscore = {}
        jsdata = {}

        # Filter out all other printed information from JetStream.json
        with open(fname, "r") as f:
            score_line_next = False
            for line in f:
                if score_line_next:
                    fscores[name]['Scores'] = float(line)
                    score_line_next = False

                if line.startswith("Total Score:"):
                    score_line_next = True

                if line.startswith('{\"JetStream2.0'):
                    data = json.loads(line)        
                    break

        # Iterate through json data
        tests = data["JetStream2.0"]["tests"]
        for k, v in tests.items():
            jsscore[k] = v["metrics"]['Score']['current'][0]

            vals = {}
            for ty, s in v["tests"].items():
                vals[ty] = s['metrics']['Time']['current'][0]
            if k == "WSL":
                wsldata[name] = vals
                continue
            jsdata[k] = vals

        frames[name] = pd.DataFrame.from_dict(jsdata)
        x = pd.DataFrame.from_dict(jsscore, orient='index')
        x.columns = ["Score"]
        jsscoredata[name] = x
    
    # Construct dataframe with scores
    score_df = pd.DataFrame()
    for k, v in jsscoredata.items():
        v.rename(columns={'Score':k}, inplace=True)
        if score_df.empty:
            score_df = v
        else:
            score_df = score_df.join(v)
    
    # Generate raw scores plot
    plt.figure()
    score_df.plot.bar(figsize=(9,2))
    ax = plt.subplot(111)
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, 1.1),
              fancybox=True, shadow=True, ncol=5)
    plt.axhline(y=1.0, color='black', linestyle='--')

    # Save plot
    plt.savefig('graphs/jetstream_raw_scores.pdf', bbox_inches='tight', dpi=1000)

    # Scale plot to base
    jsplot = score_df.divide(score_df['base'], axis='index')
    norm_jsplot = jsplot.apply(lambda x: 1.0 + (1.0-x))

    # Plot scaled graph
    plt.figure()
    norm_jsplot.plot.bar(figsize=(18,2), ylim=(0.6,1.2), width=0.85)
    ax = plt.subplot(111)

    bars = ax.patches
    patterns = ('....','/////','-', '+', 'x','/','//','O','o','\\','\\\\')
    hatches = [p for p in patterns for i in range(len(norm_jsplot))]
    for bar, hatch in zip(bars, hatches):
        bar.set_hatch(hatch)
    leg = ax.legend(loc='lower right', fancybox=True, shadow=True, fontsize=12)
    for patch in leg.get_patches():
        patch.set_height(15)
        patch.set_y(-6)
    
    plt.axhline(y=1.0, color='black', linestyle="--")
    plt.savefig('graphs/jetstream_overhead.pdf', bbox_inches='tight', dpi=1000)

    #fpd = pd.DataFrame.from_dict(fscores, orient='index')
    fpd = pd.DataFrame(fscores)
    pt.print_table("JetStream2.0 Total", fpd)
    pt.print_table("JetStream2.0 Overhead Normalized", norm_jsplot)

if __name__ == "__main__":
    # pkrujs executed as script
    generate_jetstream_plots()