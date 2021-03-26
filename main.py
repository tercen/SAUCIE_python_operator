import numpy as np
import tensorflow as tf
import sys

sys.path.append("SAUCIE")
import SAUCIE

filename = sys.argv[0]
out_filename = sys.argv[1]
tf.reset_default_graph()

# get input file as np array
data = np.loadtxt(filename)

saucie = SAUCIE.SAUCIE(data.shape[1])
loadtrain = SAUCIE.Loader(data, shuffle=True)
saucie.train(loadtrain, steps=1000)

loadeval = SAUCIE.Loader(data, shuffle=False)
embedding = saucie.get_embedding(loadeval)
number_of_clusters, clusters = saucie.get_clusters(loadeval)
#reconstruction = saucie.get_reconstruction(loadeval)

df_out = pd.DataFrame(embedding)
df_out["clusters"] = clusters

#write df_out to file
np.savetxt(out_filename, df_out)
