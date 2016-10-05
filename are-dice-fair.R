d4 = c(27, 25, 28, 20)
d6 = c(23, 12, 18, 23, 6, 18)
d8 = c(8, 9, 14, 12, 14, 12, 14, 17)
d12 = c(4, 8, 7, 8, 11, 9, 6, 10, 13, 6, 5, 13)
d20 = c(5, 1, 5, 4, 9, 2, 7, 4, 7, 5, 5, 3, 5, 5, 9, 2, 6, 6, 7, 3)

compute_p = function(x) {
   compute_chi = function(x) {
      sum((x - sum(x) / length(x))^2) / (sum(x) / length(x))
  }
  
  1 - pchisq(compute_chi(x), length(x) - 1)
}

pp = c(compute_p(d4), compute_p(d6), compute_p(d8), compute_p(d12), compute_p(d20))

p.adjust(pp, "bonferroni")
