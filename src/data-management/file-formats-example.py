import pandas as pd
import numpy as np
import os

# create data ---------------------------------------------------------------
# dataframe w/random numbers
df = pd.DataFrame(np.random.normal(size=(1000000, 5)),
                  columns=["a", "b", "c", "d", "e"],
                  dtype=np.float32)
df.loc[:, "f"] = 1.0000000001

# write out -----------------------------------------------------------------
# to csv
%time df.to_csv("temp/abc.csv")
%time df.to_csv("temp/abc.zip", compression="zip")
f"file size (Mb): {os.path.getsize('temp/abc.csv') / 1e06}"
f"file size (Mb): {os.path.getsize('temp/abc.zip') / 1e06}"

# to pickle
%time df.to_pickle("temp/abc.pkl")
f"file size (Mb): {os.path.getsize('temp/abc.pkl') / 1e06}"

# to hdf
%time df.to_hdf("temp/abc.h5", key="fx/spot")
f"file size (Mb): {os.path.getsize('temp/abc.h5') / 1e06}"

# to feather
%time df.to_feather("temp/abc.arrow")
f"file size (Mb): {os.path.getsize('temp/abc.arrow') / 1e06}"

# read in -------------------------------------------------------------------
%time df_csv = pd.read_csv("temp/abc.zip", compression="zip")
%time df_pkl = pd.read_pickle("temp/abc.pkl")
%time df_h5 = pd.read_hdf("temp/abc.h5")
%time df_ftr = pd.read_feather("temp/abc.arrow")
