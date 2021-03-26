import pandas as pd
import numpy as np

def run_py_script(df):
  df = df[[".ci", ".ri", ".y"]]
  df.groupby([".ci", ".ri"]).aggregate(np.median)
  return df
