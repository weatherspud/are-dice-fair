# Overview

An example of how to test dice for fairness using the Chi-squared test and R.

# Procedure

First I tested a set of Koplow dice.

I rolled the dice a large number of times and kept a tally of how often
each face came up.  In this example I rolled each die 100 times.

<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/koplow.jpg">&nbsp;<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/koplow2.jpg">

In RStudio, I defined a variable containing the vector of
results for each die:

    > d4_koplow = c(27, 25, 28, 20)
    > d6_koplow = c(23, 12, 18, 23, 6, 18)
    > d8_koplow = c(8, 9, 14, 12, 14, 12, 14, 17)
    > d12_koplow = c(4, 8, 7, 8, 11, 9, 6, 10, 13, 6, 5, 13)
    > d20_koplow = c(5, 1, 5, 4, 9, 2, 7, 4, 7, 5, 5, 3, 5, 5, 9, 2, 6, 6, 7, 3)
    
I used `length` to check that the length of the vector is the same as the
number of sides the die has:

    > length(d4_koplow)
    [1] 4
    
    
I used `sum` to check that the sum of the components of the vector
is the number of times the die was rolled:
    
    > sum(d4_koplow)
    [1] 100
    
I defined a function which takes the vector for each die and
returns a `p` value using the Chi-squared test:
    
    > compute_p = function(x) {
    +   compute_chi = function(x) {
    +     sum((x - sum(x) / length(x))^2) / (sum(x) / length(x))
    +   }
    +  
    +   1 - pchisq(compute_chi(x), length(x) - 1)
    + }

I computed the `p` value for each die:

    > pp_koplow = c(compute_p(d4_koplow), compute_p(d6_koplow), compute_p(d8_koplow), compute_p(d12_koplow), compute_p(d20_koplow))
    > pp_koplow
    [1] 0.67766209 0.02192465 0.68435494 0.39444792 0.52243827

The `p` value for the six-sided die was pretty low.  However, after
applying the Bonferroni correction to account for the fact that I
performed multiple null hypothesis tests, the result is not
significant even at a significance level of 0.05:
    
    > p.adjust(pp_koplow, "bonferroni")
    [1] 1.0000000 0.1096233 1.0000000 1.0000000 1.0000000

Looks like my dice are fair!

I did the same procedure for a set of Chessex dice. Here are the results:

<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/chessex.jpg">&nbsp;<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/chessex2.jpg">

    > p.adjust(pp_chessex, "bonferroni")
    [1] 0.9674319 1.0000000 1.0000000 1.0000000 0.9807618

Looks like the Chessex dice are also fair!

# What About Unfair Dice

Let's apply the test to some dice which we know are unfair:

<img height="500px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/loaded.jpg">&nbsp;<img height="500px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/loaded2.jpg">

The raw data will convince most people that these dice are unfair, but
let's go ahead and compute the test stastitics and p-values:

    > pp_loaded = c(compute_p(d6_loaded1),
    +   compute_p(d6_loaded2))
    > p.adjust(pp_loaded, "bonferroni")
    [1] 0 0

Even after applying the Bonferroni correction, the p-values are
zero. The dice are certainly unfair!

Of course there is no way we can be certain. The actual p-values must
be positive. They are just too small to be calculated given the
precision my machine is using.
