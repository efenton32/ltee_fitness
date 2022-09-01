paste <(zcat fastq/TJ/1H6_S90_R1_001.fastq.gz) <(zcat fastq/TJ/1H6_S90_R2_001.fastq.gz) |
awk -F"TAGGAGG" '
/......TGTGGG/ && /[ATGC].....AGTAGG/ && /TAGGAGG/ && /CCACGGC/{a[substr($1,1,6) substr($1,28,6) substr($2,1,26)]++ }

END {
    for (i in a) {
        print i " " a[i]
    }
}

' > .holder.txt

cat .holder.txt |
awk '
{a[substr($1,15,26)]++}

END {
    for (i in a) {
        if (a[i] > 1000) {
            print i " " a[i]
        }
    }
}
' > test.txt

rm .holder.txt

