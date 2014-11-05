# β分布 β(a, b) に従う変確率数をロジット変換した値は
# 正規分布で近似される
# μ: log((a-1/2)/(b-1/2))
# σ^2: 1/a + 1/b

# サンプリング回数
n <- 100000

# β分布のパラメータ
a <- 23
b <- 20

x <- rbeta(n, a, b) # サンプリング
y <- log(x/(1-x))   # ロジット変換

# 図示
hist(y, freq=F)
lines(x=seq(min(y), max(y), 0.01),
      y=dnorm(x=seq(min(y), max(y), 0.01), log((a-1/2)/(b-1/2)), sqrt(1/a + 1/b)),
      col="red")