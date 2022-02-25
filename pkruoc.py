import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import printutil as pt

from scipy import stats

def generate_octane_plots():
    names = ["base", "alloc", "mpk"]

    data = {}

    for n in names:
        fname = "data/octane_" + n + ".json"
        with open(fname, "r") as f:
            data[n] = json.load(f)
            for k, v in data[n].items():
                data[n][k] = float(v)
    
    df = pd.DataFrame(data)

    # Plot raw values
    plt.figure()
    df.plot.bar(figsize=(19,10))
    ax = plt.subplot(111)
    ax.legend(loc='upper center', bbox_to_anchor=(0.5,1.15), fancybox=True, shadow=True, ncol=5)
    plt.savefig('graphs/octane_raw_scores.pdf', bbox_inches='tight', dpi=1000)

    # Normalize on base
    norm_df = df.divide(df['base'], axis=0)
    norm_df.plot.bar(figsize=(6,2), ylim=(0.6,1.2), width=0.85)
    ax = plt.subplot(111)

    # octane benchmark
    bars = ax.patches
    patterns =('..','///','-', '+', 'x','/','//','O','o','\\','\\\\')
    hatches = [p for p in patterns for i in range(len(norm_df))]
    for bar, hatch in zip(bars, hatches):
        bar.set_hatch(hatch)
    leg =ax.legend(loc='lower right',
            fancybox=True, shadow=True,fontsize=12)
    for patch in leg.get_patches():
        patch.set_height(15)
        patch.set_y(-6)
    plt.axhline(y=1.0, color = 'black', linestyle = '--')
    plt.savefig('graphs/octane_overhead.pdf', bbox_inches='tight', dpi=1000)

    pt.print_table("Octane Overhead Normalized", norm_df)

if __name__ == "__main__":
    # pkrukr executed as script
    generate_octane_plots()