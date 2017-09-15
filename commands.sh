mkdir data/processed/
mkdir data/processed/simulated_observed_data
cat data/raw/constsize_obs.par | vagrant ssh 7bf5e8f -c 'tee ~/constsize_obs.par'
vagrant ssh 7bf5e8f -c 'bin/fsc25221 -i constsize_obs.par -n 1'
vagrant ssh 7bf5e8f -c "cat constsize_obs/constsize_obs_1_1.arp" > ./data/processed/simulated_observed_data/constsize_obs_1_1.arp
cat data/raw/arl_run.ars | vagrant ssh 7bf5e8f -c 'tee ~/arl_run.ars'
cat data/raw/ssdefs.txt | vagrant ssh 7bf5e8f -c 'tee ~/ssdefs.txt'
cat data/raw/constsize.est | vagrant ssh 7bf5e8f -c 'tee ~/constsize.est'
cat data/raw/constsize.par | vagrant ssh 7bf5e8f -c 'tee ~/constsize.par'
vagrant ssh 7bf5e8f -c 'bin/arlsumstat3522_64bit constsize_obs/constsize_obs_1_1.arp constsize.obs 0 1'
vagrant ssh 7bf5e8f -c "cat constsize.obs" > ./data/processed/simulated_observed_data/constsize.obs
cat data/raw/constsize.input | vagrant ssh 7bf5e8f -c 'tee ~/constsize.input'
vagrant ssh 7bf5e8f -c 'bin/ABCtoolbox constsize.input'
mkdir data/processed/abc_sims
vagrant ssh 7bf5e8f -c "cat sims_constsize_sampling1.txt" > ./data/processed/abc_sims/sims_constsize_sampling1.txt
cat data/raw/estimate.input | vagrant ssh 7bf5e8f -c 'tee ~/estimate.input'
vagrant ssh 7bf5e8f -c 'ABCtoolbox estimate.input'
mkdir data/processed/posterior
vagrant ssh 7bf5e8f -c "cat ABC_estimation_constsize_model0_jointPosterior_1_2_Obs0.txt" > data/processed/posterior/ABC_estimation_constsize_model0_jointPosterior_1_2_Obs0.txt
vagrant ssh 7bf5e8f -c "cat ABC_estimation_constsize_model0_MarginalPosteriorDensities_Obs0.txt" > data/processed/posterior/ABC_estimation_constsize_model0_MarginalPosteriorDensities_Obs0.txt
python src/plot_2D_abc_posterior.py data/processed/posterior/ABC_estimation_constsize_model0_jointPosterior_1_2_Obs0.txt results/plots/2D_joint_posterior_n_u.pdf