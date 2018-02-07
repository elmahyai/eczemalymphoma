set.seed(85)
# load additional functions
# global variable
# split into train, test
# train_test = TRUE
# # if test_now then all functions will run on the test part only
# test_now = FALSE
# # nrow of test data
# n_test_lym = 3
# n_test_ecz = 3

# degs selection parameters
# padj_max_ecz = .01
# padj_max_lym = .01
# lfc_min_ecz = 3
# lfc_min_lym = 3

source("R/subproblem1_degs/DESeq_processing_functions.R")
source("R/subproblem1_degs/load.R")
source("R/subproblem1_degs/read_lymphoma_data.R")
source("R/subproblem1_degs/read_eczema_data.R")
use_top_fifty = FALSE
source("R/subproblem1_degs/merge_eczema_lymphoma_data.R")

#register multicore parallel
#library(TSA)
#library(doMC)
#registerDoMC(2)

#prepare the data
# remove X from gene names
#colnames(new.data)<- sub("X", "", colnames(new.data))  # I guess didn't work
# because variables as only numbers doesn't fit in formulas
#-------------------------------------------------------------------------------
# step 0 tidy the data
# two datasets with only numbers

# binarize the class variable
new.data$class <- ifelse(new.data$class == "lym",1,0)  # models will predict lymphoma

#-------------------------------------------------------------------------------
# split the data into train and test to compare different models
train= sample(dim(new.data)[1],25)
# for models that require class to be part of the dataset
d_with_class_train <- new.data[train,]
d_with_class_test <- new.data[-train,]

# for models that require class to be a separate variable
# and for models that require the class to be factor
d_train <- d_with_class_train
y_train <- d_train$class
y_train_factor <- as.factor(ifelse(y_train == 0, "ecz","lym"))
d_train$class <- NULL

d_test <- d_with_class_test
y_test <- d_test$class
y_test_factor <- as.factor(ifelse(y_test == 0, "ecz","lym"))

d_test$class <- NULL



#-------------------------------------------------------------------------------
# configure caret
# parameter tuning
# modify the methods used by Caret for CV
# fitControl(list)
fitControl <- trainControl(method = "LOOCV", sampling = "up",
                           classProbs = T, summaryFunction = twoClassSummary,
                           verboseIter = TRUE)

#fitControl <- trainControl(method = "none",classProbs = TRUE,summaryFunction = twoClassSummary,
 #                          verboseIter = TRUE)

#fitControl <- trainControl(method = "LOOCV", sampling = "up", classProbs = T, summaryFunction = twoClassSummary)