#!/usr/bin/env python

from __future__ import division

import collections
import random
import sys
import scipy.stats as stats


def loaded_roll(num_faces, prob_loaded_face):
    if random.random() < prob_loaded_face:
        return num_faces
    else:
        return random.randint(1, num_faces - 1)


def loaded_trials(num_faces, prob_loaded_face, num_trials):
    counts = collections.defaultdict(int)
    for _ in range(0, num_trials):
        counts[loaded_roll(num_faces, prob_loaded_face)] += 1

    return counts


def compute_p(count_values):
    def compute_chi(count_values):
        num_trials = sum(count_values)
        num_faces = len(count_values)

        return sum((cnt_val - num_trials / num_faces) ** 2 for cnt_val in count_values) / (num_trials / num_faces)

    return 1 - stats.chi2.cdf(compute_chi(count_values), len(count_values) - 1)


def test_compute_p():
    d4_koplow = [27, 25, 28, 20]
    d6_koplow = [23, 12, 18, 23, 6, 18]
    d8_koplow = [8, 9, 14, 12, 14, 12, 14, 17]
    d12_koplow = [4, 8, 7, 8, 11, 9, 6, 10, 13, 6, 5, 13]
    d20_koplow = [5, 1, 5, 4, 9, 2, 7, 4, 7, 5, 5, 3, 5, 5, 9, 2, 6, 6, 7, 3]

    print("d4: {}".format(compute_p(d4_koplow)))
    print("d6: {}".format(compute_p(d6_koplow)))
    print("d8: {}".format(compute_p(d8_koplow)))
    print("d12: {}".format(compute_p(d12_koplow)))
    print("d20: {}".format(compute_p(d20_koplow)))


def test_loaded_roll():
    num_faces = 6
    prob_loaded_face = .3
    num_trials = 1000000
    counts = loaded_trials(num_faces, prob_loaded_face, num_trials)
    for face in range(1, num_faces + 1):
        print("{}: {}: {}".format(face, counts[face], 100.0 * counts[face] / num_trials))

# test_compute_p()
# test_loaded_roll()


def is_fair(num_faces, prob_loaded_face, num_trials, significance):
    counts = loaded_trials(num_faces, prob_loaded_face, num_trials)
    p = compute_p(counts.values())

    return p > significance


def power(num_faces, prob_loaded_face, num_trials, significance):
    num_meta_trials = 10000
    fair_cnt = 0
    for _ in range(0, num_meta_trials):
        if is_fair(num_faces, prob_loaded_face, num_trials, significance):
            fair_cnt += 1
    
    return 1 - fair_cnt / num_meta_trials


def power_function(num_faces, num_trials_list, significance):
    header = ['probability.loaded.face']
    header.extend('trials.' + str(num_trials) for num_trials in num_trials_list)
    print('\t'.join(header))
    for i in range(1, 50):
        pct = i / 100
        powers = []
        if pct > 1 / num_faces:
            for num_trials in num_trials_list:
                powers.append(power(num_faces, pct, num_trials, significance))
            row = [pct]
            row.extend(powers)
            print('\t'.join(str(cell) for cell in row))

num_trials_list = [int(num_trials) for num_trials in sys.argv[1:]]
power_function(6, num_trials_list, .01)

