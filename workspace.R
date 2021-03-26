library(tercen)
library(dplyr)
library(reticulate)

options("tercen.workflowId" = "686a2e2bba117e0c118bcb715300b5d3")
options("tercen.stepId"     = "52110340-a9c9-49fd-ba1e-a9b0cc4639b4")

getOption("tercen.workflowId")
getOption("tercen.stepId")

# reticulate::py_install(c("tensorflow==1.14"))
# , "numpy", "pandas", "scikit-learn", "matplotlib"))
# # "fcsparser", "fcswrite" missing
# py_install("pandas")
# py_install("tensorflow==1.4.0")
# py_install("scikit-learn")
# py_install("numpy==1.13.3", method = "conda")

# import("SAUCIE")
renv::init()
renv::use_python()
reticulate:::py_install_method_detect()
reticulate::py_install("pandas")
reticulate::py_install("sklearn")
reticulate::py_install("tensorflow==1.4.0")
renv::snapshot()

reticulate::source_python("main.py")

df <- (ctx <- tercenCtx()) %>%
  as.matrix() %>% t %>% run_py_script()

df %>% as_tibble %>%
  mutate(.ci = seq_len(nrow(df)) - 1) %>%
  ctx$addNamespace() %>%
  ctx$save()
