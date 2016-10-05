# Overview

An example of how to test dice for fairness using the Chi-squared test and R.

# Procedure

We roll the dice a large number of times and keep a tally of how often
each face comes up.  In our example we rolled each die 100 times.

<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/die_results.jpg">&nbsp;<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/die_results2.jpg">

In RStudio, we define a variable containing the vector of
results for each die:

    > d4 = c(27, 25, 28, 20)
    > d6 = c(23, 12, 18, 23, 6, 18)
    > d8 = c(8, 9, 14, 12, 14, 12, 14, 17)
    > d12 = c(4, 8, 7, 8, 11, 9, 6, 10, 13, 6, 5, 13)
    > d20 = c(5, 1, 5, 4, 9, 2, 7, 4, 7, 5, 5, 3, 5, 5, 9, 2, 6, 6, 7, 3)
    
We use `length` to check that length of the vector is the same as the
number of sides the die has:

    > length(d4)
    [1] 4
    
    
We use `sum` to check that the sum of the components of the vector
is the number of times the die was rolled:
    
    > sum(d4)
    [1] 100
    
Now we define a function which takes the vector for each die and
returns a `p` value using the Chi-squared test:
    
    > compute_p = function(x) {
    +   compute_chi = function(x) {
    +     sum((x - sum(x) / length(x))^2) / (sum(x) / length(x))
    +   }
    +  
    +   1 - pchisq(compute_chi(x), length(x) - 1)
    + }

We compute the `p` value for each of the dice:

    > pp = c(compute_p(d4), compute_p(d6), compute_p(d8), compute_p(d12), compute_p(d20))
    > pp
    [1] 0.67766209 0.02192465 0.68435494 0.39444792 0.52243827

The `p` value for the six-sided die was pretty low.  However, if we
apply the Bonferroni correction to account for the fact that we
performed multiple null hypothesis tests, the result is not
significant even at a significance level of 0.05:
    
    > p.adjust(pp, "bonferroni")
    [1] 1.0000000 0.1096233 1.0000000 1.0000000 1.0000000

Looks like our dice are fair!
