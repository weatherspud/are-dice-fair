# Overview

An example of how to test dice for fairness using the Chi-squared test and R.

# Procedure

Roll the dice a large number of times and keep a tally of how often
each face comes up.  In our example we rolled each die 100 times.

<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/die_results.jpg">&nbsp;<img width="400px" src="https://raw.githubusercontent.com/weatherspud/are-dice-fair/master/die_results2.jpg">

Copy the code for `compute_p` into RStudio.  `compute_p` takes a
vector of the number of times each side came up, and returns a `p`
value.  If the `p` value is less than 0.05, that is evidence the die
is not fair, and less than 0.01 is strong evidence.

If you apply the above procedure to a lot of fair dice, then you would
expect that some of them would have a `p` value less than 0.05 5% of
the time, even though none of them are loaded.  The Bonferroni correction
is a way to tell if there are any unfair dice in the batch.  
