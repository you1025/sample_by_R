# 同期加算の検証
N <- 100  # ラウンド数
n <- 1000 # サンプリング数

# 曲線の指定
t <- seq(0, 2*pi, 2*pi/n)
#y <- sin(50*t) + 5*sin(10*t) + 2*sin(3*t+pi/3)
y <- c(rep(1, 300), rep(0, 200), rep(2, 100), rep(1, 400), 0)

# 観測データ(誤差あり)の生成
lst.datas <- list()
for(i in 1:N) {
  # 誤差を加算
  lst.datas[[i]] <- y + 3*rnorm(n+1, 0, 1)
}

# 同期加算処理の実施
y.sync_add <- rep(0, length(t))
for(i in 1:N) {
  y.sync_add <- y.sync_add + lst.datas[[i]]
}
y.sync_add <- y.sync_add / N

# 描画
plot(x=t, y=lst.datas[[1]], cex=0.25)           # 観測データのサンプルとして１セットだけ表示
lines(x=t, y=y.sync_add, type="l", col="blue")  # 同期加算による推定値
lines(x=t, y=y, col="red", lwd=3)               # 真の値