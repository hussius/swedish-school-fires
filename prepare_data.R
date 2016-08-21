library("readxl")
library("dplyr")

data_path <- "xlsx_data"

# (1) Prepare a table with one municipality/year combination per row.
# This looks something like:

# Municipality Cases Population  Year
#<chr> <dbl>      <dbl> <dbl>
#  1          Ale     0      25292  1998
#  2     Alingsås     0      34930  1998
#  3      Alvesta     0      19171  1998

df <- read_excel(paste(data_path, "bib1998.xlsx", sep="/"))
df <- dplyr::select(df, -3) # Remove the "cases per 1000 inhabitants" column
df$Year <- 1998
colnames(df) <- c("Municipality","Cases","Population","Year")
for(yr in 1999:2014){
  new <- read_excel(paste0(data_path, "/bib",yr,".xlsx"))
  new <- dplyr::select(new, -3)
  new$Year <- yr
  colnames(new) <- c("Municipality","Cases","Population","Year")
  df <- rbind(df, new)
}
df.nototals <- filter(df, Municipality!="Totaler")
write.table(df.nototals, file="school_fire_cases_1998_2014.csv",sep=",",row.names=FALSE)

# (2) Prepare as a numerical matrix where each row is a municipality,
# and each column is either the number of cases for a certain year, 
# the number of cases per thousand inhabitants for a certain year,
# or the population for a certain year
old <- read_excel(paste(data_path, "bib1998.xlsx", sep="/"))
cols <- c("Municipality","Cases1998","CasesPerThousand1998","Population1998")
for(yr in 1999:2014){
new <- read_excel(paste0(data_path, "/bib",yr,".xlsx"))
old <- suppressWarnings(merge(new, old, by.x=1, by.y=1, all=TRUE))
newcols <- paste0(c("Cases","CasesPerThousand","Population"), yr)
cols <- c(cols, newcols)
}

mx <- old[,2:ncol(old)]
rownames(mx) <- old[,1]
colnames(mx) <- cols[2:ncol(old)]
mx <- mx[!rownames(mx)=="Totaler",]
write.table(mx, "school_fire_cases_1998_2014_matrix.csv", quote=FALSE, sep=",")

