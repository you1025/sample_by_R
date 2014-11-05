# 『入門ベイズ統計』P.2-4
# 結果を見ると正規分布しているように見えるので理論で検証したい。

N <- 1000     # ラウンド数
n <- 1000000  # 1ラウンド内で扱うサンプル数

p_a_c   <- 0.95   # P(A|C)
p_na_nc <- 0.95   # P(!A|!C)
p_c     <- 0.005  # P(C)

v.p_c_a <- NULL
for(i in 1:N) {
  arr_ppl    <- runif(n, 0, 1) # 全サンプル(n)
  arr_ppl_c  <- arr_ppl < p_c  # ガン患者フラグ
  arr_ppl_nc <- !arr_ppl_c     # 非ガン患者フラグ

  arr_a_c   <- arr_ppl_c  & (runif(n, 0, 1) < p_a_c)   # ガン患者でテスト陽性(正常)
  arr_na_nc <- arr_ppl_nc & (runif(n, 0, 1) < p_na_nc) # 非ガン患者でテスト陰性(正常)

  # P(C|A)
  v.p_c_a <- c(v.p_c_a, sum(arr_a_c) / (sum(arr_a_c) + (sum(arr_ppl_nc) - sum(arr_na_nc))))
}

# P(C|A) の理論値
p_c_a <- p_a_c * p_c / (p_c*p_a_c + (1-p_c)*(1-p_na_nc))