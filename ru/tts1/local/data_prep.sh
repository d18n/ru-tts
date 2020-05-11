#!/bin/bash

db=$1
data_dir=$2

# check directory existence
[ ! -e ${data_dir} ] && mkdir -p ${data_dir}

# set filenames
scp=${data_dir}/wav.scp
utt2spk=${data_dir}/utt2spk
spk2utt=${data_dir}/spk2utt
rawtext=${data_dir}/rawtext
text=${data_dir}/text

# delete files if already exist
[ -e ${scp} ] && rm ${scp}
[ -e ${utt2spk} ] && rm ${utt2spk}
[ -e ${rawtext} ] && rm ${rawtext}

# make scp, utt2spk, and spk2utt
find -L ${db} -name "*.wav" | sort | while read -r filename; do
    #this sed command gets the base filename and strips it of it's file extension
    id=$(basename ${filename} | sed -e "s/\.[^\.]*$//g")

    # stream <id> <filename> into the scp file
    echo "${id} ${filename}" >> ${scp}
    
    # just using dummy speaker id of RS as this is a single speaker dataset
    echo "${id} RS" >> ${utt2spk}
done
utils/utt2spk_to_spk2utt.pl ${utt2spk} > ${spk2utt}
echo "Finished making wav.scp, utt2spk, spk2utt."

# make text
find -L ${db} -name "transcript.txt" | sort | while read -r filename; do
    # for now, we're just going to dump the contents of the transcript into the new file to be cleaned/formatted
    cat ${filename} >> ${rawtext}
done
python local/clean_text.py ${rawtext} ${text}
rm ${rawtext}
echo "Finished making text."