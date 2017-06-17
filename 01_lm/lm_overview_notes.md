# Linear Models: Overview

## Background


## Implementation notes

https://cdn.rawgit.com/mathjax/MathJax/2.7.1/test/sample-tex.html
https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference
https://en.wikibooks.org/wiki/LaTeX

### Simple linear regression: OLS

Can use Ordinary Least squares to estimate coefficients. Can use other methods like maximum likelihood... but will possibly explore those at a later stage.

#### Overall equation

$$y = \beta_0 + \beta_1x + \epsilon$$

#### Equation components

* Gradient: $\beta_1$

$$\beta_1 = { cov(y, x) \over var(x) } = {\sum^n_{i=1}(y_i - \bar y)(x_i - \bar x) \over \sum^n_{i=1} (x_i - \bar x)^2}$$

* Y-intercept: $\beta_0$

$$\beta_0 = \bar y - \beta_1 \bar x$$

* Error component $\epsilon$:

Typically assumed to be zero, and estimated as the difference between the fitted model and the actual data.

### Multivariate linear regression: OLS

## Appendix

Supporting information

* $\beta_1$ form equivalence:

$$\beta_1 = { cov(y, x) \over var(x) } = cor(y, x){sd(y) \over sd(x) }$$

The second form is simply the correlation of x and y times the ratio of their standard deviations.

However, the first form is more useful for calculating $\beta_1$ from "scratch", as there are fewer "moving parts" (entities to substitute in) compared to the second form, making it simpler and possibly more efficient:

$$ { cov(y, x) \over var(x) } = {\sum^n_{i=1}(y_i - \bar y)(x_i - \bar x) \over n } \frac n{ \sum^n_{i=1} (x_i - \bar x)^2} = {\sum^n_{i=1}(y_i - \bar y)(x_i - \bar x) \over \sum^n_{i=1} (x_i - \bar x)^2}$$

* [Variance](https://en.wikipedia.org/wiki/Variance#Discrete_random_variable): 
Note: divide by **n - 1** to calculate sample quantity.

$$var(x) = \frac 1n \sum^n_{i=1} (x_i - \bar x)^2$$

* [Covariance](https://en.wikipedia.org/wiki/Covariance#Definition):
Note: divide by **n - 1** to calculate sample quantity.

$$cov(y, x) = {\sum^n_{i=1}(y_i - \bar y)(x_i - \bar x) \over n }$$

* [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation#Discrete_random_variable):

$$\sigma_x = \sqrt{ var(x) } = \sqrt{\frac 1n \sum^n_{i=1} (x_i - \bar x)^2}$$

* [correlation](https://en.wikipedia.org/wiki/Correlation_and_dependence#Pearson.27s_product-moment_coefficient) coefficient (sample quantity uses **n - 1**):

$$cor(x,y) = r_{xy} =  {\sum^n_{i=1}(x_i - \bar x)(y_i - \bar y) \over (n - 1) \sigma_x \sigma_y}$$

$$ = {\sum^n_{i=1}(y_i - \bar y)(x_i - \bar x) \over \sqrt{ \sum^n_{i=1} (x_i - \bar x)^2 \sum^n_{i=1} (y_i - \bar y)^2} } $$