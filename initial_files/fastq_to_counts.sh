paste <(zcat fastq/TJ/1G6_S78_R1_001.fastq.gz) <(zcat fastq/TJ/1G6_S78_R2_001.fastq.gz) |
awk '
/......TGTGGG/ && /[ATGC].....AGTAGG/ && /TAGGAGG/ && /CCACGGC/{
    a[substr($1,1,6) substr($2,1,6) substr($2,index($2,"TAGGAGG")+7,26)]++
}

END {
    for (i in a) {print i " " a[i]}
}

' > .holder.txt

cat .holder.txt |
awk '
{a[substr($1,15,26)]++}

END {
    for (i in a) {
        if (a[i] > 1000) {print i " " a[i]}
    }
}
' > test.txt

rm .holder.txt

