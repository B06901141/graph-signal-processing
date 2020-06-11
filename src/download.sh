#!/bin/bash

mkdir -p ../data
if [ ! -f ../data/mnist_train.csv ] || [ ! -f ../data/mnist_test.csv ]; then
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

    echo "Transfering to CSV..."

    python dataset2csv.py

fi

rm -rf ../data/train_data
rm -rf ../data/train_label
rm -rf ../data/test_data
rm -rf ../data/test_label
