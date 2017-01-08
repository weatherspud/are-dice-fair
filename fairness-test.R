df05 = read.delim('~/Local/src/weatherspud/are-dice-fair/power.05.tsv')
df01 = read.delim('~/Local/src/weatherspud/are-dice-fair/power.01.tsv')

plot(df05$probability.loaded.face, df05$trials.100, type='line',
col='blue',
xlab='probability of most likely face',
  ylab='test power',
  main='d6 fairness test: .05 significance')
lines(df05$probability.loaded.face, df05$trials.200, type='line', col='red')
lines(df05$probability.loaded.face, df05$trials.500, type='line', col='green')
lines(df05$probability.loaded.face, df05$trials.1000, type='line', col='orange')
legend('bottomright', c('100 trials', '200 trials', '500 trials', '1000 trials'),
  lty=c(1,1), lwd=c(2.5, 2.5),
  col=c('blue', 'red', 'green', 'orange'))

plot(df01$probability.loaded.face, df01$trials.100, type='line',
col='blue',
xlab='probability of most likely face',
  ylab='test power',
  main='d6 fairness test: .01 significance')
lines(df01$probability.loaded.face, df01$trials.200, type='line', col='red')
lines(df01$probability.loaded.face, df01$trials.500, type='line', col='green')
lines(df01$probability.loaded.face, df01$trials.1000, type='line', col='orange')
legend('bottomright', c('100 trials', '200 trials', '500 trials', '1000 trials'),
  lty=c(1,1), lwd=c(2.5, 2.5),
  col=c('blue', 'red', 'green', 'orange'))