import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sns
import statsmodels.api as sm

import textables as tex

sns.set_style("whitegrid")

sns.set_palette("colorblind")
mpl.rcParams['figure.figsize'] = (5.04, 3.78)
mpl.rcParams['font.size'] = 8
mpl.rcParams['font.family'] = "serif"


def get_findings():
    """Calculate betas."""
    """Figure to show superiority of heatmap over tables."""
    data = pd.read_csv("../data/return_data.csv", index_col=0,
                       parse_dates=True)

    y = data.drop("SPY", axis=1)
    x = data[["SPY"]];
    x.loc[:, "const"] = 1.0

    b = dict()
    se = dict()

    for freq in ("B", "M", "Y"):

        x_, y_ = x.resample(freq).mean(), y.resample(freq).mean()

        for c, v in y_.iteritems():
            mfit = sm.OLS(endog=v, exog=x_, missing="drop").fit()
            b[(freq, c)] = mfit.params["SPY"]
            se[(freq, c)] = mfit.bse["SPY"]

    b = pd.Series(b).unstack() \
        .rename(index={"B": "daily", "M": "monthly", "Y": "annually"})
    se = pd.Series(se).unstack() \
        .rename(index={"B": "daily", "M": "monthly", "Y": "annually"})

    return b, se


def fig_table_heatmap():
    """Figure to show superiority of heatmap over tables."""
    b, se = get_findings()

    tbl_ant = b.applymap("{:.2f}\n".format) + se.applymap("({:.2f})".format)
    fig, ax = plt.subplots(figsize=(5.04, 3.78 / 2))
    ax = sns.heatmap(b, cbar=False, cmap="coolwarm", linewidths=0.25, ax=ax,
                     annot=tbl_ant, fmt="s", center=1.0)
    ax.set_yticklabels(ax.get_yticklabels(), rotation=0)
    ax.xaxis.tick_top()
    fig.tight_layout()
    fig.savefig("../visualization/tex_examples/betas-hmap.pdf",
                transparent=False)

def table_table():
    """Table."""
    b, se = get_findings()

    tbl_b = tex.TexTable(b, fmt="{:.2f}")
    tbl_se = tex.TexTable(se, fmt="({:.2f})")

    tbl = tbl_b.intertwine(tbl_se)

    tbl.with_dcolumn()\
        .to_tabularx(textwidth=0.8,
                     buf="../visualization/tex_examples/betas-table.tex")


if __name__ == '__main__':
    # fig_table_heatmap()
    table_table()
