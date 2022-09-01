paste <(zcat fastq/TJ/2D5_S137_R1_001.fastq.gz) <(zcat fastq/TJ/2D5_S137_R2_001.fastq.gz) |
awk '
/CAAATCCGC/{a[substr($1,1,6) substr($2,1,6), substr($2,76,38)]++}

END {
    for (i in a) {
        print i "  " a[i]
    }
}

' > test.txt
