# 母集団から抽出した標本に対する母平均の推定(Z, T)

# 基本設定
m <- 1000 # 全体のセット回数
n <- 100  # 標本抽出試行回数
p <- 0.95 # xxx
size <- c(3, 5, 10, 20, 30, 40, 50, 100)

# 母集団の構成
N <- 1000
mu <- 215.92
sd <- 15.17
x <- rnorm(n=N, mean=mu, sd=sd)


# 検証
data.lst <- list()
for(i in 1:m) {
  lst.zt <- list()
  for(sz in size) {
    data <- NULL
    
    for(j in 1:n) {
      # 標本の抽出
      s <- sample(x, size=sz, replace=F)
      
      # 正規分布
      zlower <- mean(s) - qnorm((1+p)/2, 0, 1) * sd(s) / sqrt(sz)
      zupper <- mean(s) + qnorm((1+p)/2, 0, 1) * sd(s) / sqrt(sz)
      zin_range <- ifelse(zlower < mu && mu < zupper, 1, 0)
      
      # t 分布
      tlower <- mean(s) - qt((1+p)/2, sz-1) * sd(s) / sqrt(sz)
      tupper <- mean(s) + qt((1+p)/2, sz-1) * sd(s) / sqrt(sz)
      tin_range <- ifelse(tlower < mu && mu < tupper, 1, 0)
      
      data <- rbind(data,
                    data.frame(mu=mean(s), sd=sd(s),
                               zlower=zlower, zupper=zupper, zin_range=zin_range,
                               tlower=tlower, tupper=tupper, tin_range=tin_range))
    }
    lst.zt[[paste("size_", sz, sep="")]] <- data
  }
  data.lst[[i]] <- lst.zt
}


# 結果の集計
z.fault <- NULL
t.fault <- NULL
for(sz in size) {
  z.fault <- c(z.fault, mean(n - sapply(data.lst, function(l) { sum(l[[paste("size_", sz, sep="")]]$zin_range) })))
  t.fault <- c(t.fault, mean(n - sapply(data.lst, function(l) { sum(l[[paste("size_", sz, sep="")]]$tin_range) })))
}

# 描画
plot(x=size, y=z.fault, type="o", ylim=c(0, 25))
lines(x=size, y=t.fault, type="o")
abline(h=5, col="red")
