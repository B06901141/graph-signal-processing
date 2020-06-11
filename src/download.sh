#!/bin/bash

mkdir -p ../data

task=train_data
if [ ! -f ../data/$task ]; then
    filename=train-images-idx3-ubyte
    wget http://yann.lecun.com/exdb/mnist/$filename.gz -O ../data/$filename.gz
    yes n | gunzip ../data/$filename.gz
    mv ../data/$filename ../data/$task
fi

task=train_label
if [ ! -f ../data/$task ]; then
    filename=train-labels-idx1-ubyte
    wget http://yann.lecun.com/exdb/mnist/$filename.gz -O ../data/$filename.gz
    yes n | gunzip ../data/$filename.gz
    mv ../data/$filename ../data/$task
fi

task=test_data
if [ ! -f ../data/$task ]; then
    filename=t10k-images-idx3-ubyte
    wget http://yann.lecun.com/exdb/mnist/$filename.gz -O ../data/$filename.gz
    yes n | gunzip ../data/$filename.gz
    mv ../data/$filename ../data/$task
fi

task=test_label
if [ ! -f ../data/$task ]; then
    filename=t10k-labels-idx1-ubyte
    wget http://yann.lecun.com/exdb/mnist/$filename.gz -O ../data/$filename.gz
    yes n | gunzip ../data/$filename.gz
    mv ../data/$filename ../data/$task
fi

rm -rf ../data/*ubyte*
