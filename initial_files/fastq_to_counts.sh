awk '
function all_SNPs(sequence){
    regex = sequence
    for (i=1; i<=length(sequence); i++)
        regex = regex "|" substr(sequence,1,i-1) "." substr(sequence,i+1)
    return regex

}

(NR==FNR) {bcs[$2] = all_SNPs($2)}

/......TGTGGG/ && /[ATGC].....AGTAGG/ && /TAGGAGG/ && /CCACGGC/(NR>FNR){
    a[substr($1,1,6) substr($2,1,6) substr($2,index($2,"TAGGAGG")+7,26)]++
}

END {
    for (i in a) {b[substr(i,13,26)]++}
    for (i in b) {
        for (j in bcs) {
            if (i ~ bcs[j]) {counts[j]+=b[i]}
        }
    }
    for (i in counts) {print i " " counts[i]}
}


' barcodes.txt <(paste <(zcat fastq/TJ/$1_R1_001.fastq.gz) <(zcat fastq/TJ/$1_R2_001.fastq.gz)) > count_files/$1.txt

