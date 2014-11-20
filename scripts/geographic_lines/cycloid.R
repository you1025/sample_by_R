# サイクロイド
n <- 1000 # 区間の分割数
a <- 1

t <- seq(0, 2*pi, 2*pi/n)
x <- a * (t - sin(t))
y <- a * (1 - cos(t))

plot(x, y, type="l", col="red", asp=1)
abline(h=0, v=0)
