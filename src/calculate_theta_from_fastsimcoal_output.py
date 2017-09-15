#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 14 20:14:42 2017

@author: tobias
"""

import sys
sys.path
sys.path.append("./")
from estimate_pop_parameters import *

import os
import re
import csv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
from Bio.Align import MultipleSeqAlignment
from Bio import AlignIO


def convert_simcoal_output_to_fasta(file):
    folder = '/'.join(file.split('/')[:-1])
    len_locus = 0
    mutation_rate = 0
    n_alleles = 0
    par_file = '%s.par' %file.split('/')[-1].split('_1')[0]
    folder = '/'.join(file.split('/')[:-1])
    par_path = os.path.join(folder,par_file)
    with open(par_path) as f:
        reader = csv.reader(f, delimiter=' ')
        reader = list(reader)
        non_empty_lines = []
        for line in reader:
            if line == []:
                pass
            else:
                non_empty_lines.append(line)
        len_locus = int(non_empty_lines[-1][1])
        mutation_rate = float(non_empty_lines[-1][3])
        n_alleles = int(non_empty_lines[3][0])
    if len_locus == 0:
        sys.exit('no valid .par file provided (length of locus needs to be stated in 2nd column of last row)')
    sequence_list = []
    with open(file) as f:
        reader = csv.reader(f, delimiter='\t')
        reader = list(reader)
        for row in reader:
            if len(row) > 0 and re.search('^\d+_\d+',row[0]):
                sequence_list.append(row)
    
    pre_alignment = []
    id = 0
    length = ''
    for element in sequence_list:
        id += 1
        sequence = element[2]
        record = SeqRecord(Seq(sequence,IUPAC.ambiguous_dna),id="sample%i" %id, name="sample%i" %id, description = '')
        pre_alignment.append(record)
        length = len(sequence)
        
    new_alignment = MultipleSeqAlignment(pre_alignment)
    AlignIO.write(new_alignment, "%s/sim_coal_snp_alignment.fasta" %folder, "fasta")
    return "%s/sim_coal_snp_alignment.fasta" %folder, id, folder, length, len_locus, mutation_rate, n_alleles

'''
simcoal_out = '/Users/tobias/GitHub/abc_modeling_course_tjarno_2017/data/constsize_obs_1_1.arp'
alignment, num_seqs , input_dir, snp_length, alignment_length, mutation_rate, n_alleles = convert_simcoal_output_to_fasta(simcoal_out)
possible_combos = get_possible_combinations_for_n_sequences(num_seqs)
aln_format = 'fasta'
min_num_seqs = num_seqs
outgroup = ''
name = alignment.split('/')[-1]

snp_columns = {}
snp_positions = list(range(0,snp_length))
snp_columns.setdefault(name,snp_positions)

valid_columns = {}
all_positions = list(range(0,alignment_length))
valid_columns.setdefault(name,all_positions)

locus_tajima_dict,locus_snp_count_dict = tajimas_estimator_per_locus(input_dir,aln_format,snp_columns,valid_columns,min_num_seqs,outgroup,possible_combos)
tajima = locus_tajima_dict[name]
print(math.log10(tajima))

plot_expected_heterozyosity(locus_tajima_dict,input_dir)
'''