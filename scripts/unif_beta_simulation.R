n <- 100000
p <- 9
q <- 2

m.values <- matrix(NA, nrow=n, ncol=p+q-1)
for(i in 1:n) {
  m.values[i,] <- sort(runif(p+q-1, 0, 1), decreasing=F)
}

hist(m.values[, p], breaks=seq(0, 1, 0.01), freq=F)
lines(x=seq(0, 1, 0.01), y=dbeta(x=seq(0, 1, 0.01), p, q), col="red")