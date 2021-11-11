#!/usr/bin/env Rscript
# input: name of virus i.e. hhv5

args = commandArgs(trailingOnly=TRUE)

print(paste0("###############################   ", args[1], "   ###############################" ))

# the iedb file
file = paste0("data/",args[1], ".csv")
df = read.csv(file , skip = 1)
df = df[df$Object.Type == "Linear peptide",] # data is pretty poorfly formatted, lets just deal with linear for now
df$ref_start_pos = 0
df$ref_end_pos = 0

# for peptide in peptides
for(i in 1:length(df$Description)){
    peptide = df$Description[i]
    # write a temporary fasta file
    text = paste0(">query\n",peptide)
    writeLines(text, "del.fasta")
    print(text)

    # pass to tblastn
    command = paste0("tblastn -db blastdb/hhv5 -query del.fasta -outfmt 6")
    blast = system(command, intern = T)

    # handle output
    if(length(blast) != 0){ # if = 0 then no match
        blastdf = read.table(text = blast)
        start = min(blastdf[1,9:10])
        end = max(blastdf[1,9:10])
    }else{
        start = NA
        end = NA
    }

    # add to df
    df$ref_start_pos[i] = start
    df$ref_end_pos[i] = end
}
outfile = paste0("data/",args[1], "_ref.csv")
write.csv(df,
    outfile,
    row.names = F)