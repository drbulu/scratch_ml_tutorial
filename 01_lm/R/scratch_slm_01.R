# This is a simple version of the simple linear regression model implementation
# a) The "scratch.slm.01" list object contains all of the functionality required
# construct a fitted model. 
# b) The scratch.slm.01$fit() function is used to construct the actual model fit
# which is returned as a simple model list object
# c) The predict function here is model$predict() as the scratch.slm.01 simply
# spawns new model objects from input data. Therefore, it doesn't make sense
# to have the in scratch.slm.01.

scratch.slm.01 = list(

    # implementation of the gradient (beta1) coefficient
    beta1 = function(x, y){
        x = na.omit(x)
        y = na.omit(y)
        beta_1 = sum( (y - mean(y)) * (x - mean(x)) ) / sum( (x - mean(x))^2 )
        return(beta_1)
    },
    
    # implementation of the y-intercept coefficient
    beta0 = function(x, y){
        x = na.omit(x)
        y = na.omit(y)
        beta_0 = mean(y) - ( scratch.slm.01$beta1(x, y) * mean(x) )
        return(beta_0)
    },
    
    # function for fitting simple linear models 
    # returns fitted model object
    fit = function(x, y){
        model = list()
        model$type = "scratch.slm.01 generated simple linear regression model."
        model$gradient = scratch.slm.01$beta1(x, y)
        model$intercept = scratch.slm.01$beta0(x, y) 
        model$errorMsg = paste0("Error! Gradient or intercept is null. ", 
            "Have you fitted a valid model?\n")
        model$predict = function(x){
            # input validation
            isBeta1Null = is.null(model$gradient)
            isBeta0Null = is.null(model$intercept)
            if(isBeta1Null | isBeta0Null) cat(scratch.slm.01$predictError)
            # return predicted value of y
            return( (model$gradient * x) + model$intercept)
        }
        return(model)
    }

)