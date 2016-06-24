# 試行回数
N <- 10000

results <- NULL
for(i in 1:N) {
  # 初期設定: car:車のある場所 / choice:参加者の選択 / monty:モンティのオープン
  car    <- sample(1:3, 1)
  choice <- sample(1:3, 1)
  monty  <- ifelse(car==choice, sample(setdiff(1:3, choice), 1), setdiff(1:3, c(car, choice)))

  # 選択を変更した場合の結果判定
  result <- ifelse(car==setdiff(1:3, c(choice, monty)), 1, 0)
  results <- c(results, result)
#  results <- c(results, ifelse(car==choice, 1, 0))
}

# 結果の表示
print(sum(results)/length(results))