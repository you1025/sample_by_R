# 標準の重みベクトルは c(1, 1, ...) の方が良い気がするのだけど...要考察
# とりあえず動かない版なので仕様も含めて見直しが必要だね

# 重み付きの移動平均
# 通常の移動平均(同一の重み)は引数 "wts" に c(1, 1, ...) を指定
wma <- function(x, n) {
  # x <- c(2, 3, 4, 8, 3, 10, 5, 12)
  # wma.odd(x, 5): 2.666667 3.625 4.333333 5.666667 6 7.333333 7.75 9.333333
  wma.odd <- function(x, n, wts=NULL) {
    # 重みが未指定の場合は中央を最も重視するように指定
    if(is.null(wts)) {
      w <- c(1:((n-1)/2+1), ((n-1)/2):1) 
    } else {
      w <- wts
    }
    index.mid <- (n-1)/2 + 1  # 平均に使用するデータ範囲の中心を参照

    v.head <- NULL
    v.tail <- NULL
    for(i in 1:(index.mid-1)) {
      tmp.w <- w[(index.mid-(i-1)):n]
      v.head <- c(v.head, sum(tmp.w * x[1:length(tmp.w)]) / sum(tmp.w))

      tmp.w <- tmp.w[length(tmp.w):1]
      v.tail <- c(sum(tmp.w * x[(length(x)-(length(tmp.w)-1)):length(x)]) / sum(tmp.w), v.tail)
    }

    v.middle <- WMA(x, n, wts=w)
    v.middle <- v.middle[!is.na(v.middle)]

    return(c(v.head, v.middle, v.tail))
  }

  # x <- c(2, 3, 4, 8, 3, 10, 5, 12)
  # wma.even(x, 4): 2.625 3.454545 4.5 5.5 6.25 7 8.090909 9.125
  wma.even <- function(x, n) {
    w <- c(seq(0.5, n/2-0.5, 1), n/2, seq(n/2-0.5, 0.5, -1))
    return(wma.odd(x, n+1, w))
  }

  if(n %% 2 == 0) {
    return(wma.even(x, n))
  } else {
    return(wma.odd(x, n))
  }
}