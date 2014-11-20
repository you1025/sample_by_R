# レムニスケート
n <- 1000 # 区間の分割数
a <- 1

t <- c(seq(-pi/4, pi/4, (pi/2)/n), seq(3*pi/4, 5*pi/4, (pi/2)/n))
r.sqr <- 2 * (a^2) * cos(2*t)
r.sqr <- ifelse(r.sqr<0, 0, r.sqr)  # cos(1.5π) が 0 でなく負になってしまう事への対処
r <- sqrt(r.sqr)
x <- r * cos(t)
y <- r * sin(t)

plot(x, y, type="l", col="red", asp=1)
abline(h=0, v=0)