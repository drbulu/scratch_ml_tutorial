# This is a simple version of the simple linear regression model implementation

# there is a strong argument for NOT reinventing the wheel here...
# this is basically a version of scratch_slm_02.R that takes advantage
# of R's inbuilt basic/fundamental statistical functionality.
# The argument extends from the observation that it is pointless to 
# reimplement sqrt(), (or mean()) for that matter, which are important
# and broadly useful function. This serves to make the creation of our
# simple linear model implementation more seamless and error free.

# also results in a demonstrably more compact simple linear model implementation.

scratch.slm.03 = list(

    # gradient calculation options:
    # note: sd(y) MUST me the numerator!
    beta1a = function(x,y) return( cov(y,x)/var(x) ),
    beta1b = function(x,y) return( cor(x,y) * (sd(y)/sd(x)) ),
    # y-intercept: general calculation
    beta0 = function(x, y, gradient) mean(y) - (gradient * mean(x)),
    
    # function for fitting simple linear models 
    # returns fitted model object from training data
    fit = function(x, y, method = c("a", "b")){
        # input validation:
        x = na.omit(x)
        y = na.omit(y)
        # selector for functions to calcualte slm coefficients
        method = match.arg(method, choices = c("a", "b"))
        # use "method" choice to select calculation option
        # use do.call to select
        gradCalc = ifelse(method == "a", 
            scratch.slm.03$beta1a, 
            scratch.slm.03$beta1b)
        
        # model list object that stores fitted model
        fittedModel = list()
        fittedModel$type = paste0("scratch.slm.03: ", 
            "simple linear regression model maker.", 
            "\n", "Method: ", method, ".")
        fittedModel$gradient = do.call(gradCalc, args=list(x=x, y=y))
        fittedModel$intercept = scratch.slm.03$beta0(x, y, fittedModel$gradient)
        
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