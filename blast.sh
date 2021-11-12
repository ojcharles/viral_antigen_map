# for each reference generate the blastdb
files=`ls ./ref/*.fasta`
for file in $files
do
    basefile=`basename $file`
    basefile=${basefile%.*}
    echo $basefile

    makeblastdb -in ./ref/${basefile}.fasta -dbtype nucl -out ./blastdb/${basefile}

done