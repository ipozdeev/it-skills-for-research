import pandas as pd
import numpy as np
import os
import pyarrow.feather as feather

# create data ---------------------------------------------------------------
# dataframe w/random numbers
df = pd.DataFrame(np.random.normal(size=(1000000, 3)),
                  columns=["alpha", "bravo", "charlie"],
                  dtype=np.float32)
df

# write out -----------------------------------------------------------------
# to csv
%time df.to_csv("src/abc.csv")
%time df.to_csv("src/abc.zip", compression="zip")
f"file size (Mb): {os.path.getsize('src/abc.csv') / 1e06}"
f"file size (Mb): {os.path.getsize('src/abc.zip') / 1e06}"

# to pickle
%time df.to_pickle("src/abc.pkl")
f"file size (Mb): {os.path.getsize('src/abc.pkl') / 1e06}"

# to hdf
%time df.to_hdf("src/abc.h5", key="fx/spot")
f"file size (Mb): {os.path.getsize('src/abc.h5') / 1e06}"

# to feather
%time feather.write_feather(df, "src/abc.arrow")
f"file size (Mb): {os.path.getsize('src/abc.arrow') / 1e06}"

# read in -------------------------------------------------------------------
%time df_csv = pd.read_csv("src/abc.zip", compression="zip")
%time df_pkl = pd.read_pickle("src/abc.pkl")
%time df_h5 = pd.read_hdf("src/abc.h5")
%time df_ftr = pd.read_feather("src/abc.arrow")
