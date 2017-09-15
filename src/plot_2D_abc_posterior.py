# plotting posterior distribution of density (between u and N)
import sys
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np


in_file = sys.argv[1]
if len(sys.argv)>2:
	outfile = sys.argv[2]
else:
	outfile = '2D_posterior_plot.pdf'
file = pd.read_csv(in_file,sep='\t')
#file = pd.read_csv("/home/tobias/abc_course_exercise/day4/abc_toolbox/ABC_estimation_constsize_model0_jointPosterior_1_2_Obs0.txt",sep='\t')
n_now = np.array(sorted(list(set(file['LOG10_N_NOW']))))
rate = np.array(sorted(list(set(file['LOG10_MUTATION_RATE']))))
density = list(file.density)



# we need to transform the density values into a matrix
def split(arr, size):                     
	arrs = []
	while len(arr) > size:
	    pice = arr[:size]
	    arrs.append(pice)
	    arr   = arr[size:]
	arrs.append(arr)
	return arrs

formatted_dens = split(density,len(n_now))
matrix_dens = np.array(formatted_dens)

f=plt.figure()                                                
CS = plt.contour(n_now, rate, matrix_dens)
plt.clabel(CS, inline=1, fontsize=10, fmt='%1.f')
plt.plot(4, -7, 'rX',label="true parameters")
plt.annotate('true parameters', xy=(4.05, -6.95), xytext=(4.5, -6.5), arrowprops=dict(facecolor='red',width=1.5, headwidth=8))
#plt.show()
f.savefig(outfile, bbox_inches='tight')
