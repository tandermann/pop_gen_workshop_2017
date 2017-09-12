#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 12 01:26:53 2017

@author: tobias
"""

import matplotlib.pyplot as plt
import random
import os


def get_expected_value_from_list(max_option,upper,output_dir):
    options = list(range(1,max_option+1))
    e = sum(options)/len(options)
    results = []
    average = []
    for i in range(1,upper+1):
        throw = random.choice(options)
        results.append(throw)
        average.append(sum(results)/len(results))
    f=plt.figure()
    plt.plot(range(1,len(average)+1), average,label="average across all throws")
    plt.axis([-upper/100, upper, 0.5, len(options)+len(options)/10])
    plt.plot((-upper/100, upper),(e, e), 'r-', linewidth=0.5)
    f.savefig(os.path.join(output_dir,"average_after_%s_throws_1_to_%s.pdf"%(upper,max_option)), bbox_inches='tight')
    return average

# Settings
repetitions = 100000
output_dir = '/Users/tobias/Desktop/abc_modeling_course_tjarno_2017/own_plots'
max_option = 6 #the function will create a list with integers from 1 to this value

average = get_expected_value_from_list(max_option,repetitions,output_dir)

print(average)
