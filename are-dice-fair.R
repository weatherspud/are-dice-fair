d4_koplow = c(27, 25, 28, 20)
d6_koplow = c(23, 12, 18, 23, 6, 18)
d8_koplow = c(8, 9, 14, 12, 14, 12, 14, 17)
d12_koplow = c(4, 8, 7, 8, 11, 9, 6, 10, 13, 6, 5, 13)
d20_koplow = c(5, 1, 5, 4, 9, 2, 7, 4, 7, 5, 5, 3, 5, 5, 9, 2, 6, 6, 7, 3)

d4_chessex = c(17, 23, 30, 30)
d6_chessex = c(20, 19, 18, 17, 15, 11)
d8_chessex = c(14, 15, 10, 14, 6, 10, 19, 12)
d12_chessex = c(10, 6, 6, 14, 5, 9, 9, 6, 9, 7, 12, 7)
d20_chessex = c(10, 2, 6, 7, 4, 10, 4, 3, 6, 4, 3, 5, 4, 4, 2, 5, 6, 9, 1, 5)

d6_loaded1 = c(77, 4, 2, 8, 6, 3)
d6_loaded2 = c(1, 3, 6, 3, 5, 82)

compute_p = function(x) {
   compute_chi = function(x) {
      sum((x - sum(x) / length(x))^2) / (sum(x) / length(x))
  }
  
  1 - pchisq(compute_chi(x), length(x) - 1)
}

pp_koplow = c(compute_p(d4_koplow),
  compute_p(d6_koplow),
  compute_p(d8_koplow),
  compute_p(d12_koplow),
  compute_p(d20_koplow))
p.adjust(pp_koplow, "bonferroni")

pp_chessex = c(compute_p(d4_chessex),
  compute_p(d6_chessex),
  compute_p(d8_chessex),
  compute_p(d12_chessex),
  compute_p(d20_chessex))
p.adjust(pp_chessex, "bonferroni")

pp_loaded = c(compute_p(d6_loaded1),
  compute_p(d6_loaded2))
p.adjust(pp_loaded, "bonferroni")