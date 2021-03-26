library(tercen)
library(dplyr)
library(reticulate)

options("tercen.workflowId" = "968e828a2d8eb509f7ccd060700068fe")
options("tercen.stepId"     = "bd9c55dd-d533-42ff-af36-9c6f10d837db")

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
