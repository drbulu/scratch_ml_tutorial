# This is a simple version of the simple linear regression model implementation
# a) The "scratch.slm.02" list object contains all of the functionality required
# construct a fitted model. 
# b) The scratch.slm.02$fit() function is used to construct the actual model fit
# which is returned as a simple model list object
# c) The predict function here is model$predict() as the scratch.slm.02 simply
# spawns new model objects from input data. Therefore, it doesn't make sense
# to have the in scratch.slm.02.

# this simplified logic makes it easier to prove that the two different
# methods of implementing "beta1" are equivalent

scratch.slm.02 = list(

    # variance: divide by n-1. Tested against R function var()
    varCalc = function(x){
        x = na.omit(x)
        variance = sum( (x - mean(x))^2 ) / (length(x) - 1)
        return(variance)
    },
    
    # covariance: divide by n-1. Tested against R function cov()
    covCalc = function(x, y){
        x = na.omit(x)
        y = na.omit(y)
        if(length(x)!=length(y)) stop('"x" and "y" must be the same length!')
        # since x and y are equal length we can divide by length of x or y
        covariance = sum( (x - mean(x)) * (y - mean(y)) ) / (length(x) - 1)
        return(covariance)
    },
    
    # standard deviation:
    # Note: obviously I'm not insane enough to try to make sqrt() from scratch!
    stdevCalc = function(x) return(sqrt(scratch.slm.02$varCalc(x))),
    
    # pearson correlation coefficient
    # Note: we are using the formulation that doesn't rely on 
    # direct calculation of the standard deviations of x and y
    corCalc = function(x, y){
        corNumerator = sum( (x - mean(x)) * (y - mean(y)) )
        corDenominator = sum( (x - mean(x))^2 ) * sum((y - mean(y))^2 )
        correlation = corNumerator / sqrt(corDenominator)
        return(correlation)
    },
    
    # First option a): implementation of the slm coefficients
    beta1a = function(x, y){
        return( scratch.slm.02$covCalc(y,x) / scratch.slm.02$varCalc(x) )
    },

    # Second option b): implementation of the slm coefficients
    beta1b = function(x, y){
        sdRatio = scratch.slm.02$stdevCalc(y) / scratch.slm.02$stdevCalc(x)
        return( scratch.slm.02$corCalc(y,x) * sdRatio)
    },
    
    # y-intercept calc: added gradient parameter for simplicity
    beta0 = function(x, y, gradient) return( mean(y) - (gradient * mean(x)) ),
    
    # function for fitting simple linear models 
    # returns fitted model object from training data
    fit = function(x, y, method = c("a", "b")){
        # input validation: compared with scratch_slm_02.R
        # the realisation is that input validation is only
        # needed when model created using fit()
        x = na.omit(x)
        y = na.omit(y)
        # selector for functions to calcualte slm coefficients
        method = match.arg(method, choices = c("a", "b"))
        # use "method" choice to select calculation option
        # use do.call to select
        gradCalc = ifelse(method == "a", 
            scratch.slm.02$beta1a, 
            scratch.slm.02$beta1b)
        
        # model list object that stores fitted model
        fittedModel = list()
        fittedModel$type = paste0("scratch.slm.02: ", 
            "simple linear regression model maker.", 
            "\n", "Method: ", method, ".")
        fittedModel$gradient = do.call(gradCalc, args=list(x=x, y=y))
        fittedModel$intercept = scratch.slm.02$beta0(x, y, fittedModel$gradient)
        
        fittedModel$errorMsg = paste0("Error! Gradient or intercept is null. ", 
            "Have you fitted a valid model?\n")
        
        # function to predict y from new values of x
        fittedModel$predict = function(x){
            # input validation
            if(is.null(fittedModel$gradient) | is.null(fittedModel$intercept)) 
                cat(fittedModel$errorMsg)
            # return predicted value of y
            return( (fittedModel$gradient * x) + fittedModel$intercept)
        }
        # return final fitted model
        return(fittedModel)
    }

)