import pandas as pd
import numpy as np
from tercen import getContext

ctx = getContext()
df = ctx.select([".ci", ".ri", ".y"])

df.groupby([".ci", ".ri"]).aggregate(np.median)

df = ctx.addNamespace(df)
ctx.save(df)
