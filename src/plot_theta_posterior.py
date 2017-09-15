# plot theta posterior distribution
import sys
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np


input_file = sys.argv[1]
if len(sys.argv)>2:
	outfile = sys.argv[2]
else:
	outfile = 'theta_posterior_plot.pdf'


#input_file = 'ABC_estimation_constsize_theta_model0_MarginalPosteriorDensities_Obs0.txt'
file = pd.read_csv(input_file,sep='\t')
theta = np.array(list(file.LOG10_THETA))
theta_dens = np.array(list(file['LOG10_THETA.density']))

f=plt.figure()
plt.plot(theta, theta_dens, 'ro')
f.savefig(outfile, bbox_inches='tight')
plt.show()
