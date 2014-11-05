# 検証:
# [0-1] の一様分布に従う p+q-1 個の確率変数を大きさの順で並び替えると
# 小さい方から p 番目の値は β(p, q) に従う

# サンプリング回数
n <- 100000

# β分布のパラメータ
p <- 9
q <- 2

m.values <- matrix(NA, nrow=n, ncol=p+q-1)
for(i in 1:n) {
  m.values[i,] <- sort(runif(p+q-1, 0, 1), decreasing=F)
}

# 結果の図示
hist(m.values[, p], breaks=seq(0, 1, 0.01), freq=F)
lines(x=seq(0, 1, 0.01), y=dbeta(x=seq(0, 1, 0.01), p, q), col="red")