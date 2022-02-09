# R module to interact with Enrichr,
# Author: Morteza Chalabi Hajkarim mor.chalabi@gmail.com

library(reticulate)

# set options here: ####

# gene set to query:
gene_set = 'gene_set.txt'

# library to query against (listed here: https://maayanlab.cloud/Enrichr/#libraries):
lib_     = 'Jensen_TISSUES'

# DO NOT TOUCH #############################################################################################################

source_python(file = 'API.py')
ens_ = Enrichr(gene_set, lib_)
ens_ = lapply(X = ens_[[1]], FUN = function(en_){ dt_ = data.frame( Rank = en_[[1]],
                                                                    Term_name = en_[[2]],
                                                                    P_value = en_[[3]],
                                                                    Adjusted_p_value = en_[[7]],
                                                                    Z_score = en_[[4]],
                                                                    Combined_score = en_[[5]],
                                                                    Overlapping_genes = paste0(en_[[6]], collapse = ',')) })
ens_ = do.call(ens_, what = rbind)

############################################################################################################################

# DO SOMETHING WITH ens_ ####

View(ens_)