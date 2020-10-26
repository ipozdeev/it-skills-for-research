import pandas as pd
import numpy as np
import os
import pyarrow.feather as feather

# create data ---------------------------------------------------------------
# dataframe w/random numbers
df = pd.DataFrame(np.random.normal(size=(10000, 3)),
                  columns=["alpha", "bravo", "charlie"],
                  dtype=np.float32)
df

# write out -----------------------------------------------------------------
# to csv
%time df.to_csv("src/abc.csv")

# to feather
%time feather.write_feather(df, "src/abc.arrow")

# to pickle
df.to_pickle("src/abc.pkl")

# compare the sizes ---------------------------------------------------------
os.path.getsize("src/abc.csv")
os.path.getsize("src/abc.arrow")
os.path.getsize("src/abc.pkl")

# read in -------------------------------------------------------------------
df_csv = pd.read_csv("src/abc.csv", index_col=0)
df_arrow = pd.read_feather("src/abc.arrow")
