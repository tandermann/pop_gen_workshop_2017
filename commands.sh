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
