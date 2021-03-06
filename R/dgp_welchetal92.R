# d <- dgp.welchetal92(NULL, 10000)
# summary(d[[2]])

welchetal92 <- function(xx)
{
  ##########################################################################
  #
  # WELCH ET AL. (1992) FUNCTION
  #
  # Authors: Sonja Surjanovic, Simon Fraser University
  #          Derek Bingham, Simon Fraser University
  # Questions/Comments: Please email Derek Bingham at dbingham@stat.sfu.ca.
  #
  # Copyright 2013. Derek Bingham, Simon Fraser University.
  #
  # THERE IS NO WARRANTY, EXPRESS OR IMPLIED. WE DO NOT ASSUME ANY LIABILITY
  # FOR THE USE OF THIS SOFTWARE.  If software is modified to produce
  # derivative works, such modified software should be clearly marked.
  # Additionally, this program is free software; you can redistribute it
  # and/or modify it under the terms of the GNU General Public License as
  # published by the Free Software Foundation; version 2.0 of the License.
  # Accordingly, this program is distributed in the hope that it will be
  # useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  # General Public License for more details.
  #
  # For function details and reference information, see:
  # http://www.sfu.ca/~ssurjano/
  #
  ##########################################################################
  #
  # INPUT:
  #
  # xx = c(x1, x2, ..., 20)
  #
  ##########################################################################

  x1  <- xx[1]
  x2  <- xx[2]
  x3  <- xx[3]
  x4  <- xx[4]
  x5  <- xx[5]
  x6  <- xx[6]
  x7  <- xx[7]
  x8  <- xx[8]
  x9  <- xx[9]
  x10 <- xx[10]
  x11 <- xx[11]
  x12 <- xx[12]
  x13 <- xx[13]
  x14 <- xx[14]
  x15 <- xx[15]
  x16 <- xx[16]
  x17 <- xx[17]
  x18 <- xx[18]
  x19 <- xx[19]
  x20 <- xx[20]

  term1 <- 5*x12 / (1+x1)
  term2 <- 5 * (x4-x20)^2
  term3 <- x5 + 40*x19^3 - 5*x19
  term4 <- 0.05*x2 + 0.08*x3 - 0.03*x6
  term5 <- 0.03*x7 - 0.09*x9 - 0.01*x10
  term6 <- -0.07*x11 + 0.25*x13^2 - 0.04*x14
  term7 <- 0.06*x15 - 0.01*x17 - 0.03*x18

  y <- term1 + term2 + term3 + term4 + term5 + term6 + term7
  return(y)
}


dgp.welchetal92 <- function(box, n.points, distr = "laths", nval = 5, pts = 0, use.pts = FALSE, thr = 0){

  dim <- 20
  if(is.null(box)){
    box <- matrix(c(rep(0, dim), rep(1, dim)), nrow = 2, byrow = TRUE)
  }

  if(use.pts){
    if(ncol(pts) != dim) stop(paste0("pts should have ", dim, " dimensions"))
    d <- pts
  } else {
    if(ncol(box) != dim) stop(paste0("box should have ", dim, " dimensions"))
    d <- get.data(box, n.points, distr, nval)
  }

  low <- rep(-0.5, dim)
  up <- rep(0.5, dim)

  y <- apply(d.scale(d, low, up), 1, welchetal92)
  y <- ifelse(y < thr, 1, 0)

  return(list(d, y))
}
