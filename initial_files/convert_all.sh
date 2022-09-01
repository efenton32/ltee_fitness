
for i in $(ls fastq/TJ/ | awk '/fastq.gz/ {print substr($1,1,index($1,"_R")-1) }')
do
    source fastq_to_counts.sh $i
done
