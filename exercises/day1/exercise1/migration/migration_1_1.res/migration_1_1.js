
USETEXTLINKS = 1
STARTALLOPEN = 0
WRAPTEXT = 1
PRESERVESTATE = 0
HIGHLIGHT = 1
ICONPATH = 'file:////home/tobias/abc_course_exercise/exercise1/'    //change if the gif's folder is a subfolder, for example: 'images/'

foldersTree = gFld("<i>ARLEQUIN RESULTS (migration_1_1.arp)</i>", "")
insDoc(foldersTree, gLnk("R", "Arlequin log file", "Arlequin_log.txt"))
	aux1 = insFld(foldersTree, gFld("Run of 11/09/17 at 17:11:43", "migration_1_1.xml#11_09_17at17_11_43"))
	insDoc(aux1, gLnk("R", "Settings", "migration_1_1.xml#11_09_17at17_11_43_run_information"))
		aux2 = insFld(aux1, gFld("Shared haplotypes", "migration_1_1.xml#11_09_17at17_11_43_shared%20haplotypes"))
		insDoc(aux2, gLnk("R", "Sample 1", "migration_1_1.xml#11_09_17at17_11_43_gr_shared0"))
		insDoc(aux2, gLnk("R", "Sample 2", "migration_1_1.xml#11_09_17at17_11_43_gr_shared1"))
		aux2 = insFld(aux1, gFld("Samples", ""))
		insDoc(aux2, gLnk("R", "Sample 1", "migration_1_1.xml#11_09_17at17_11_43_group0"))
		insDoc(aux2, gLnk("R", "Sample 2", "migration_1_1.xml#11_09_17at17_11_43_group1"))
		aux2 = insFld(aux1, gFld("Within-samples summary", ""))
		insDoc(aux2, gLnk("R", "Basic indices", "migration_1_1.xml#11_09_17at17_11_43_comp_sum_Basic"))
		insDoc(aux2, gLnk("R", "Heterozygosity", "migration_1_1.xml#11_09_17at17_11_43_comp_sum_het"))
		insDoc(aux2, gLnk("R", "No. of alleles", "migration_1_1.xml#11_09_17at17_11_43_comp_sum_numAll"))
		insDoc(aux2, gLnk("R", "Molecular diversity", "migration_1_1.xml#11_09_17at17_11_43_comp_sum_moldiv"))
		insDoc(aux2, gLnk("R", "Neutrality tests", "migration_1_1.xml#11_09_17at17_11_43_comp_sum_neutests"))
		aux2 = insFld(aux1, gFld("Genetic structure (samp=pop)", "migration_1_1.xml#11_09_17at17_11_43_pop_gen_struct"))
		insDoc(aux2, gLnk("R", "Pairwise distances", "migration_1_1.xml#11_09_17at17_11_43_pop_pairw_diff"))
		insDoc(aux2, gLnk("R", "Locus by locus AMOVA", "migration_1_1.xml#11_09_17at17_11_43pop_Loc_by_Loc_AMOVA"))
