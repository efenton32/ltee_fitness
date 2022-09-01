paste <(zcat fastq/TJ/$1_R1_001.fastq.gz) <(zcat fastq/TJ/$1_R2_001.fastq.gz) |
awk '
/......TGTGGG/ && /[ATGC].....AGTAGG/ && /TAGGAGG/ && /CCACGGC/{
    a[substr($1,1,6) substr($2,1,6) substr($2,index($2,"TAGGAGG")+7,26)]++
}

END {
    for (i in a) {b[substr(i,15,26)]++}
    for (i in b) {
        if (b[i] > 1000) {print i " " b[i]}
    }
}
' > count_files/$1.txt

