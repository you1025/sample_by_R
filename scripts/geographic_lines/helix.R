# 螺旋
n <- 1000 # 区間の分割数
rot <- 4

t <- seq(0, rot*pi, rot*pi/n)
x <- t * cos(t)
y <- t * sin(t)

plot(x, y, type="l", col="red")
abline(h=0, v=0)