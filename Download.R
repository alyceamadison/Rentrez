#DOWNLOADING THE RENTREZ PACKAGE

library(rentrez)
library(dplyr)

#LOADING IN THE LINES OF CODE PROVIDED:

#This first line is simply making a new object called "ncbi_ids" that is a string of three different - 
# - characters
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#This next line will bring in data files from the NCBI database, where db is the name of the database - 
#from NCBI you want to bring in the data files from, id is the unique ID records that are found in your -
#chosen database that you want to use/access, and rettype describes the kind of format you want to get -
#for your chosen records

Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#LOOKING AT THE "Bburg" OBJECT:

head(Bburg)
print(Bburg)

#SPLITTING THE "Bburg" OBJECT INTO THREE ELEMENTS:

Sequences = strsplit(Bburg,"\n\n")

#CONVERTING "Sequences" INTO A DATAFRAME:

Sequences = unlist(Sequences)

#USING REGULAR EXPRESSIONS TO SEPARATE THE SEQUENCES FROM THE HEADERS:

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

# REMOVING THE NEW LINE CHARACTERS USING GSUB AND AS.MATRIX:
Sequences = gsub("(\n)+","",as.matrix(Sequences))

print(Sequences)

#OUTPUTTING THIS CODE AS A .CSV FILE:

write.csv(Sequences,"~/Desktop/BIOL 432/Lecture Stuff/Rentrez/Data/Sequences.csv")

