#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 11 19:01:42 2017

@author: tobias
"""

# this program estimates some basic population genetic parameters from allele alignments




#______________________________DEPENDENCIES____________________________________
import os
import itertools
import numpy as np
import random
import math
import matplotlib.pyplot as plt
from Bio import AlignIO
from Bio.Align import MultipleSeqAlignment




#______________________________FUNCTIONS_______________________________________
def read_aln_in_folder(input_dir, aln_format):
    file_list = []
    for file in os.listdir(input_dir):
        if file.endswith(".%s" %aln_format):
            file_list.append(os.path.join(input_dir, file))
    return file_list


def drop_sequence_from_alignment_containing_string_in_header(alignment,outgroup):
    if outgroup == '':
        new_alignment = alignment
        dropped_counter = 0
    else:        
        index_counter = 0
        dropped_counter = 0
        sequence_list = []
        for seq in alignment:
            if not outgroup in seq.id:
                sequence_list.append(alignment[index_counter])
            elif outgroup in seq.id:
                dropped_counter += 1
            index_counter += 1
        new_alignment = MultipleSeqAlignment(sequence_list)
    return new_alignment, dropped_counter


def get_variable_positions(aln_list,aln_format, min_num_seqs, outgroup):
    # this dict will only contain the valid columns withut ambiguities
    valid_columns_dict = {}
    # this dict will contains all variable positions
    variable_columns_dict = {}  
    for file in aln_list:
        alignment = AlignIO.read(open(file), aln_format)
        alignment, dropped_seqs = drop_sequence_from_alignment_containing_string_in_header(alignment,outgroup)
        if len(alignment) < min_num_seqs-dropped_seqs:
            pass
        else:
            # get the name of the alignment
            name = file.split('/')[-1]
            # iterate through columns of each alignment
            for r in range(0,alignment.get_alignment_length()):
                not_real = False
                column = alignment[:,r]
                states = set(column)
                if not 'N' in states:
                    valid_columns_dict.setdefault(name,[])
                    valid_columns_dict[name].append(r)
                    valid_states = []
                    for i in range(0,len(states)):
                        state = list(states)[i]
                        # only these states count as true bases
                        if state in ['A','C','T','G']:
                            valid_states.append(state)
                        elif state == '-':
                            valid_states.append(state)
                            if '-' in alignment[:,r-1]:
                                not_real = True
                    if len(valid_states) > 1:
                        variable_columns_dict.setdefault(name,[])
                        if not_real:
                            pass
                        else:
                            variable_columns_dict[name].append(r)
    return valid_columns_dict,variable_columns_dict,dropped_seqs
                

def get_possible_combinations_for_n_sequences(n):
    combo_list = []
    for subset in itertools.combinations(range(0,n), 2):
        if subset not in combo_list:
            combo_list.append(subset)
    return combo_list


def tajimas_estimator_per_locus(input_dir,aln_format,snp_columns,valid_columns,min_num_seqs,outgroup,possible_combos):
    locus_tajima_dict = {}
    locus_snp_count_dict = {}
    for locus in snp_columns: #iterating over all loci
        alignment = AlignIO.read(open(os.path.join(input_dir,locus)), aln_format)
        alignment, dropped_seqs = drop_sequence_from_alignment_containing_string_in_header(alignment,outgroup)        
        d_count = 0    
        # iterate through columns
        snp_pos_freq_dict = {}
        for position in snp_columns[locus]:
            column = alignment[:,position]
            snp_pos_freq_dict.setdefault(position,[[x,column.count(x)] for x in set(column)])
            if len([[x,column.count(x)] for x in set(column)]) <= 2:
                # p = occurrence of one of the two alleles, doesn't matter which one, since it's always simmetrical
                p = [[x,column.count(x)] for x in set(column)][0][1]
                n =  min_num_seqs
                # this formula calculates the pairwise differences between all possible pairs (formula derived by myself by seeing what fits the actually counted pairwise differnces for different n's and p's)
                delta = n*p-p**2
                d_count += delta
            # deal with positions with more than 2 variants by counting 'manually'
            else:
                for pair in possible_combos:
                    if alignment[pair[0],position] != alignment[pair[1],position]:
                        d_count += 1
        locus_snp_count_dict.setdefault(locus,[])
        locus_snp_count_dict[locus].append(snp_pos_freq_dict)
        tajimas_estimator = d_count/len(possible_combos)
        locus_len = len(valid_columns[locus])
        corrected_tajimas_estimator = tajimas_estimator/locus_len
        locus_tajima_dict.setdefault(locus,corrected_tajimas_estimator)
    return locus_tajima_dict,locus_snp_count_dict


def plot_expected_heterozyosity(locus_tajima_dict,output_dir):
    theta_estimates = np.array(list(locus_tajima_dict.values()))
    def expected_heterozygosity(theta):
        y = theta/(theta+1)
        return y
    # create a series of numbers in order to plot the function
    if len(locus_tajima_dict) > 1:
        alpha_value = min(1,1/math.log10(len(locus_tajima_dict)))
    else:
        alpha_value = 1
    t = np.arange(0.0001, 1000.0, 0.001)
    f=plt.figure()
    plt.plot(theta_estimates, expected_heterozygosity(theta_estimates), 'ro',label="calculated tajimas-theta-estimator",alpha=alpha_value)
    plt.axis([0.00009, 1005.0, -0.1, 1.1])
    plt.xscale('log')
    plt.plot(t, expected_heterozygosity(t), label="expected heterozygosity function")
    plt.legend(loc='upper left')
    plt.xlabel('theta')
    plt.ylabel('expected heterozygosity')
    plt.title('Expected heterozygosity for UCE loci of Topaza (n = %s)'%len(theta_estimates))
    plt.show()
    f.savefig(os.path.join(output_dir,"expected_heterozygosity_uces.pdf"), bbox_inches='tight')


def get_fsf_stats(input_dir,aln_format,outgroup,locus_snp_count_dict):
    # get the site frequency spectrum stats:
    # determine the ancestral state at each polymorphism:
        # 1. if outgroup allele also present in ingroup, take it as ancestral state
        # 2. if outgroup allele not present in ingroup, choose the most common ingroup allele as ancestral
        # 3. if all allele copies are equally common, choose one at random as ancestral
    # for all derived mutations, count by how many sequences those are shared
    locus_allele_counts_dict = {}
    for locus in locus_snp_count_dict:
        locus_allele_counts_dict.setdefault(locus,[])
        alignment = AlignIO.read(open(os.path.join(input_dir,locus)), aln_format)
        for position in locus_snp_count_dict[locus]:
            position_list = position.keys()
            # iterate through the target columns of the alignment (containing SNPs)
            for pos in position_list:
                ancestral = ''
                outgroup_pos = []
                ingroup_pos = []
                for sequence in alignment:
                    # make sure to catch the outgroup state to estimate the ancestral state
                    if outgroup in sequence.id:
                        if sequence.seq[int(pos)] != '-':
                            outgroup_pos.append(sequence.seq[int(pos)])
                    else:
                        ingroup_pos.append(sequence.seq[int(pos)])
                if len(set(outgroup_pos))>1:
                    secure_random = random.SystemRandom()
                    ancestral_proposal = secure_random.choice(outgroup_pos) 
                elif len(set(outgroup_pos))==1:
                    ancestral_proposal = outgroup_pos[0]
                else:
                    ancestral_proposal = ''
                # if the outgroup allele is present in the ingroup, set it as ancestral state
                if ancestral_proposal in ingroup_pos:
                    ancestral = ancestral_proposal
                # if it's not in the ingroup, set the most frequenct state from ingroup as ancestral
                else:
                    count = [[x,ingroup_pos.count(x)] for x in set(ingroup_pos)]
                    # sort the count list by the number of occurrences
                    count.sort(key=lambda x: x[1])
                    # get the most frequent occurrence
                    ancestral = count[-1][0]
                base_count_dict = {}
                [base_count_dict.setdefault(x,ingroup_pos.count(x)) for x in set(ingroup_pos)]
                for base in set(ingroup_pos):
                    if base != ancestral:
                        locus_allele_counts_dict[locus].append(base_count_dict[base])
    return locus_allele_counts_dict


def join_and_plot_sfs_data(locus_derived_allele_counts_dict,output_dir):
    # join all sfs data points into one list for plotting
    sfs_data_list = []
    for locus in locus_derived_allele_counts_dict:
        for element in locus_derived_allele_counts_dict[locus]:
            sfs_data_list.append(element)
    f=plt.figure()
    plt.hist(sfs_data_list, bins=len(set(sfs_data_list)))
    plt.ylabel('total count')
    plt.xlabel('occurrence of allele among all sequences')
    plt.title('site frequency spectrum for UCE loci of Topaza (n = %s)'%len(locus_derived_allele_counts_dict))
    plt.show()
    f.savefig(os.path.join(output_dir,"site_frequency_spectrum_uces.pdf"), bbox_inches='tight')



'''
#______________________________SETTINGS________________________________________
input_dir = './data/topaza-uce-allele-alignments'
aln_format = 'fasta'
min_num_seqs = 20
output_dir = './results/plots'
outgroup = 'Florisuga'
'''


'''
#______________________________WORKFLOW________________________________________
alignment_list = read_aln_in_folder(input_dir,aln_format)
valid_columns, snp_columns, removed_seqs = get_variable_positions(alignment_list,aln_format,min_num_seqs,outgroup)
possible_combos = get_possible_combinations_for_n_sequences(int(min_num_seqs)-int(removed_seqs))
locus_tajima_dict,locus_snp_count_dict = tajimas_estimator_per_locus(input_dir,aln_format,snp_columns,valid_columns,min_num_seqs,outgroup,possible_combos)
plot_expected_heterozyosity(locus_tajima_dict,output_dir)
locus_derived_allele_counts_dict = get_fsf_stats(input_dir,aln_format,outgroup,locus_snp_count_dict)
join_and_plot_sfs_data(locus_derived_allele_counts_dict,output_dir)
'''



#______________________________NOTES___________________________________________

# calculate Tajima's D from the SFS results
# find good way to partition data by population
# what to do with columns containing N's?? (we are excluding them for now)



