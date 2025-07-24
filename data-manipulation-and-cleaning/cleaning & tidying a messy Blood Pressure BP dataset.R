#I found this dataset while looking for messy datasets to practice cleaning, Dr. higgins website (https://higgi13425.github.io/medicaldata/) thx for sharing it doc!

library(openxlsx)
url <- "https://github.com/higgi13425/medicaldata/raw/master/data-raw/messy_data/messy_bp.xlsx"
# replace the filename "messy_infarct.xlsx" at the end of this long url path with the filename that you want to load. 
# Or just copy the whole path from the URL column below.

bp_messy <- openxlsx::read.xlsx(url)
head(bp_messy)

bp_messy_date_Joined <- bp_messy %>%
  unite(DoB, X4, X2, X3, sep = "/")

bp_messy_dateANDbp_joined <- bp_messy_date_Joined %>%
  unite(BP, X8, X10, X12, sep = ", ")

bp_messy_dateANDbpANDhr_joined <- bp_messy_dateANDbp_joined %>%
  unite(HR, X9, X11, X13, sep = ", ")

colnames_NEW <- bp_messy_dateANDbpANDhr_joined[2,]

colnames_NEW <- c("pat_id", "DoB", "Race", "Sex", "Hispanic/not", "BP", "HR")

colnames(bp_messy_dateANDbpANDhr_joined) <- colnames_NEW

bp_messy_dateANDbpANDhr_joined_LAST_join <- bp_messy_dateANDbpANDhr_joined[-(1:2),]

bp_messy_dateANDbpANDhr_joined_LAST_join$DoB <- as.Date(bp_messy_dateANDbpANDhr_joined_LAST_join$DoB, format = "%Y/%m/%d")

bp_messy_cleanJoin <- bp_messy_dateANDbpANDhr_joined_LAST_join

bp_messy_cleanJoin_LOWER <- bp_messy_cleanJoin %>%
  mutate(Race = str_to_lower(Race))

bp_messy_cleanJoin_LOWER_sepBP <- bp_messy_cleanJoin_LOWER %>%
  separate_rows(BP, HR, sep = ", ")

bp_DONEcleaning <- bp_messy_cleanJoin_LOWER_sepBP
