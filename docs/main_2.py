import pandas as pd
import numpy as np

def run_py_script(df):
  df = df[[".ci", ".ri", ".y"]]
  df.groupby([".ci", ".ri"]).aggregate(np.median)
  return df
  
def run_py_script(data):
  tf.reset_default_graph()
  saucie = SAUCIE.SAUCIE(data.shape[1])
  loadtrain = SAUCIE.Loader(data, shuffle=True)
  saucie.train(loadtrain, steps=1000)
  loadeval = SAUCIE.Loader(data, shuffle=False)
  embedding = saucie.get_embedding(loadeval)
  number_of_clusters, clusters = saucie.get_clusters(loadeval)
  df_out = pd.DataFrame(data=embedding, columns=["SAUCIE1", "SAUCIE2"])
  df_out["clusters"] = clusters
  #reconstruction = saucie.get_reconstruction(loadeval)
  return df_out
