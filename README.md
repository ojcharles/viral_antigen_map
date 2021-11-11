# viral_antigen_map

This is a repo that takes Immune Epitope Database and Analysis Resource "IEDB" data for a set of viruses, and maps it to their reference strain nucleotide position.

### Requirements
the blast cli's in your path
base R


### Usage
go to https://www.iedb.org/
Download some data for your favourite virus (or anything I guess) , name it | species |.csv 
Pop the genome fasta of the reference genome in ./ref/| species |.fasta
Run Rscript main.R | species |

a iedb database with reference start and reference end nucleotide positions will appear

todo optional
- make getting data automatic