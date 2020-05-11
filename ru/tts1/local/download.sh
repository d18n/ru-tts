#!/bin/bash

db=$1

cwd=`pwd`

if [ ! -e ${db}/ru ]; then
    mkdir -p ${db}
    cd ${db}
    gdown -O russian-single-speaker-speech-dataset.zip 'https://drive.google.com/uc?id=1VUEvIjZlWpEZeAHWkMjS62nStdnlzTXY'
    unzip -o ./*.zip
    rm ./*.zip
    cd $cwd
fi