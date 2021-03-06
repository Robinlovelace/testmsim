#' @title Weights Distance
#'
#' @description
#' Computes the distance between sample design weights and estimated new
#' weights.
#' \deqn{D_i = \sum_j^m |w_j - d_j|}
#'
#' @param design_weights weights of the survey
#' @param simulated_weights simulated weights
#' @return distance_weights distance between weights
#' @examples
#' x <- 1:5
#' y <- x^2
#' getDist(x, y)
getDist <- function(design_weights, simulated_weights){
  abs(simulated_weights - design_weights)
}
#' @title Total Chi-squared distance
#'
#' @description
#' Computes the Chi-squared distance between sample design weights and
#' estimated new weights.
#' \deqn{
#'      Chi_i = \sum_j^m \frac{\left( w_j \times d_j\right)^2 }{2d_j}
#'      }
#' @source Rahman, A. (2009). Small Area Estimation Through Spatial Microsimulation Models. In 2nd International Microsimulation Association Conference. Ottawa and Canada. \url{http://www.natsem.canberra.edu.au/publications/?publication=small-area-estimation-through-spatial-microsimulation-models-some-methodolgical-issues}
#'
#' @inheritParams getDist
#' @return chi-squared distance
#' @examples
#' getChi(10, 20)
#' getChi(30, 40)
getChi <- function(design_weights, simulated_weights){
  sum((design_weights * simulated_weights)^2 /
        (2 * design_weights))
}

#' @title Mean Chi-squared distance
#'
#' @description
#' Computes the mean Chi-squared distance between sample design weights and
#' estimated new weights.
#' \deqn{
#'      \theta Chi_i = \sum_j^m \frac{\left(w_j \times d_j\right)^2 }{2d_j} \div m
#'      }
#'
#' @inheritParams getDist
#' @return mean chi-squared distance
#' @examples
#' getMChi(10, 20, 5)
#' getMChi(30, 40, 5)
getMChi <- function(design_weights, simulated_weights, population_size){
    total_distance_chi2 <- sum(1/2 * (design_weights * simulated_weights)^2 / design_weights)/population_size}

#' @title Total absolute distance (TAD)
#'
#' @description
#' Computes the total absolute distance between sample design weights and
#' estimated new weights.
#' \deqn{
#'      TAD = \sum_i^n \left|\sum_j^m w_{i,j} - pop_i\right|
#'      }
#'
#' @inheritParams getDist
#' @return total absolute distance
#' @examples
#' getTAD(10, 20)
#' getTAD(30, 40)
getTAD <- function(design_weights, simulated_weights){
    TAD <- sum(abs(simulated_weights-design_weights))}

#' @title Error in Margin (EM)
#'
#' @description
#' Computes the ration between estimated and known number of individuals or
#' households.
#' \deqn{
#'      EM_i = \frac{\sum w_j - pop_i}{pop_i}
#'      }
#'
#' @param population_size known population size
#' @param simulated_weights simulated weights
#' @return error in margins
#' @examples
#' getEM(10, 20)
#' getEM(30, 40)
getEM <- function(population_size, simulated_weights){
    EM <- (sum(simulated_weights) - population_size) / population_size}

#' @title Error in Distribution (ED)
#'
#' @description
#' Computes the ration between absolute sum of residuals (estimated - known)
#' and the actual population size.
#' \deqn{
#'      ED_i = \frac{|\sum w_j - pop_i|}{pop_i}
#'      }
#'
#' @inheritParams getEM
#' @return error in distribution
#' @examples
#' getED(10, 20)
#' getED(30, 40)
getED <- function(population_size, simulated_weights){
    ED <- abs(sum(simulated_weights) - population_size) / population_size}

#' @title Total absolute error (TAE)
#'
#' @description
#' Computes the total absolute error as the sum of the absolute difference
#' between observed marginal sums and simulated marginal sums.
#' \deqn{
#'      TAE = \sum_i^n |Tx - \hat{t}x|
#'      }
#'
#' @param observed observed marginal sums
#' @param simulated simulated marginal sums
#' @return total absolute error
#' @examples
#' getTAE(10, 20)
#' getTAE(30, 40)
getTAE <- function(observed, simulated){
    obs <- as.numeric(observed)
    sim <- as.numeric(simulated)
    TAE <- sum(abs(obs-sim))}

#' @title Standardized absolute error (SAE)
#'
#' @description
#' Divides the \code{\link{getTAE}} by the know population size.
#' \deqn{
#'      SAE = \sum_i^n |Tx - \hat{t}x| \div pop_i
#'      }
#'
#' @inheritParams getTAE
#' @param population_size known population size
#' @return standardized absolute error
#' @examples
#' getSAE(10, 20, 5)
#' getSAE(30, 40, 5)
getSAE <- function(observed, simulated, population_size){
    obs <- as.numeric(observed)
    sim <- as.numeric(simulated)
    SAE <- abs(observed-simulated) / population_size}

#' @title Percentage error (PSAE)
#'
#' @description
#' Divides the \code{\link{getSAE}} by the known population size.
#' \deqn{
#'      PAE = \sum_i^n |Tx - \hat{t}x| \div pop_i \times 100
#'      }
#'
#' @inheritParams getSAE
#' @return percentage error
#' @examples
#' getPSAE(10, 20, 5)
#' getPSAE(30, 40, 5)
getPSAE <- function(observed, simulated, population_size){
    obs <- as.numeric(observed)
    sim <- as.numeric(simulated)
    abs(observed-simulated) / population_size * 100}

#' @title Z-statistic
#'
#' @description
#' The Z-statistic aims to describe the performance of the individual
#' characteristics of the population used as constrains in the simulation.
#' \deqn{
#'    r = \frac{\hat{t}x}{\sum Tx}
#'    p = \frac{Tx}{\sum Tx}
#'    Z = \frac{r-p}{\sqrt{p\times\left(1-p\right)\div\sum Tx}}
#'      }
#'
#' @inheritParams getTAE
#' @return Z-statistic
#' @examples
#' getZ(10, 20)
#' getZ(30, 40)
getZ <- function(observed, simulated){
    obs <- as.numeric(observed)
    sim <- as.numeric(simulated)
    r = simulated/sum(observed)
    p = observed/sum(observed)
    Z <- (r-p)/sqrt(p*(1-p)/sum(observed))}

#' @title Correlation Coefficient (Pearson Correlation)
#'
#' @description
#' test for correlations between simulated and expected marginal totals. This
#' functions implements the \code{\link[stats]{cor}} function for the
#' estimation of the Pearson correlation coefficient.
#' \deqn{
#'      pearson <- cor(cbind(Tx, hTx), use="complete.obs", method="pearson")
#'      }
#'
#' @inheritParams getTAE
#' @return Pearson correlation
getPearson <- function(observed, simulated){
    pearson <- cor(cbind(observed, simulated), use="complete.obs", method="pearson")}

#' @title Independent samples t-Test
#'
#' @description
#' performs a t-test to compare expected proportions between simulated and
#' observed marginal totals. This function implements the
#' \code{\link[stats]{t.test}} function.
#'
#' @inheritParams getTAE
#' @return t-test
getTTest <- function(observed, simulated){
    ttest <- t.test(observed, simulated)$p.value}

#' @title Coefficient of determination
#'
#' @description
#' Compute the r-squared coefficient of determination between simulated and
#' observed marginal totals. This function implements the
#' \code{\link[stats]{lm}} function to estimate the r-squared coefficient.
#'
#' @inheritParams getTAE
getR <- function(observed, simulated){
    lm.X <- lm(observed ~ simulated)
    r2 <- summary(lm.X)$r.squared}
