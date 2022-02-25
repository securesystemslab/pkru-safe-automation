import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import printutil as pt

from scipy import stats

def generate_dromaeo_plots():
    names = ["base", "alloc", "mpk"]
    data = {}

    for n in names:
        fname = "data/dromaeo_" + n + ".json"
        with open(fname, "r") as f:
            data[n] = json.load(f)
            for k,v in data[n].items():
                data[n][k] =float(v)
    
    # Construct Dromaeo dataframe
    df = pd.DataFrame(data)

    # Plot raw values
    df.plot.bar(figsize=(19,10))
    plt.savefig('graphs/dromaeo_raw_scores.pdf', bbox_inches='tight', dpi=1000)

    # Grab only the aggregate scores
    dom = df.loc[["dom", "v8" , "dromaeo", "sunspider","jslib"]]

    # Normalize on base
    norm_dom = dom.divide(dom['base'], axis='index')
    ax = norm_dom.plot.bar(rot=0)
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=5)
    plt.savefig('graphs/dromaeo_normalized_aggregate.pdf', bbox_inches='tight', dpi=1000)

    pt.print_table("Dromaeo Overhead Normalized", norm_dom)

if __name__ == "__main__":
    # pkrudr executed as script
    generate_dromaeo_plots()