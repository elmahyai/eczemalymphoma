svmRadial_original<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                y_train_factor = y_train_factor,
                                                model_method = "svmRadial",
                                                fitControl = fitControl,
                                                     sampling_method = "original",
                                                preProcess = c("center", "scale"),
                                                tuneLength = 8,
                                                classProbs=TRUE)

svmRadial_down_sampling<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                     y_train_factor = y_train_factor,
                                                     model_method = "svmRadial",
                                                     fitControl = fitControl,
                                                     sampling_method = "down",
                                                     preProcess = c("center", "scale"),
                                                     tuneLength = 8)

svmRadial_up_sampling<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                   y_train_factor = y_train_factor,
                                                   model_method = "svmRadial",
                                                   fitControl = fitControl,
                                                   sampling_method = "up",
                                                   preProcess = c("center", "scale"),
                                                   tuneLength = 8)

svmRadial_smote_sampling<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                   y_train_factor = y_train_factor,
                                                   model_method = "svmRadial",
                                                   fitControl = fitControl,
                                                   sampling_method = "smote",
                                                   preProcess = c("center", "scale"),
                                                   tuneLength = 8)

svmRadial_weighted_sampling<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                   y_train_factor = y_train_factor,
                                                   model_method = "svmRadial",
                                                   fitControl = fitControl,
                                                   sampling_method = "weights",
                                                   preProcess = c("center", "scale"),
                                                   tuneLength = 8)



model_list = list("svmRadial_original" = svmRadial_original,
                  "svmRadial_up_sampling" = svmRadial_up_sampling,
                  "svmRadial_down_sampling" = svmRadial_down_sampling,
                  "svmRadial_weighted_sampling" = svmRadial_weighted_sampling,
                  "svmRadial_smote_sampling" = svmRadial_smote_sampling)
plot_multipe_rocs(model_list,
                  use_test_data = FALSE,
                  y_test_factor = y_test_factor,
                  d_with_class_test = d_with_class_test,
                  variable_of_interest = "ecz")
compare_sampling_approaches_on_test_data(model_list,d_with_class_test)
