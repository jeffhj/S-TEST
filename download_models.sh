#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

set -e
set -u

ROOD_DIR="$(realpath $(dirname "$0"))"
DST_DIR="$ROOD_DIR/pre-trained_language_models"

mkdir -p "$DST_DIR"
cd "$DST_DIR"


echo "GPT2"
if [[ ! -f gpt/gpt2/config.json ]]; then
  rm -rf 'gpt/gpt2'
  mkdir -p 'gpt/gpt2'
  cd 'gpt/gpt2'
  wget 'https://s3.amazonaws.com/models.huggingface.co/bert/gpt2-vocab.json' -O vocab.json
  wget 'https://s3.amazonaws.com/models.huggingface.co/bert/gpt2-merges.txt' -O merges.txt
  wget -c 'https://s3.amazonaws.com/models.huggingface.co/bert/gpt2-pytorch_model.bin' -O 'pytorch_model.bin'
  wget -c 'https://s3.amazonaws.com/models.huggingface.co/bert/gpt2-config.json' -O 'config.json'
  cd ../..
fi

echo "BERT BASE CASED"
if [[ ! -f bert/cased_L-12_H-768_A-12/bert_config.json ]]; then
  mkdir -p 'bert'
  cd bert
  wget -c "https://storage.googleapis.com/bert_models/2018_10_18/cased_L-12_H-768_A-12.zip"
  unzip cased_L-12_H-768_A-12
  rm cased_L-12_H-768_A-12.zip
  cd cased_L-12_H-768_A-12
  wget -c "https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-cased.tar.gz"
  tar -xzf bert-base-cased.tar.gz
  rm bert-base-cased.tar.gz
  rm bert_model*
  cd ../../
fi

echo "BERT LARGE CASED"
if [[ ! -f bert/cased_L-24_H-1024_A-16/bert_config.json ]]; then
  mkdir -p 'bert'
  cd bert
  wget -c "https://storage.googleapis.com/bert_models/2018_10_18/cased_L-24_H-1024_A-16.zip"
  unzip cased_L-24_H-1024_A-16.zip
  rm cased_L-24_H-1024_A-16.zip
  cd cased_L-24_H-1024_A-16
  wget -c "https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-cased.tar.gz"
  tar -xzf bert-large-cased.tar.gz
  rm bert-large-cased.tar.gz
  rm bert_model*
  cd ../../
fi

echo "RoBERTa Base"
if [[ ! -f roberta/roberta.base/dict.txt ]]; then
  rm -rf 'roberta/roberta.base'
  mkdir -p 'roberta/roberta.base'
  cd 'roberta'
  wget -c 'https://dl.fbaipublicfiles.com/fairseq/models/roberta.base.tar.gz'
  tar -xzf roberta.base.tar.gz
  rm roberta.base.tar.gz
  cd ..
fi

echo "RoBERTa Large"
if [[ ! -f roberta/roberta.large/dict.txt ]]; then
  rm -rf 'roberta/roberta.large'
  mkdir -p 'roberta/roberta.large'
  cd 'roberta'
  wget -c 'https://dl.fbaipublicfiles.com/fairseq/models/roberta.large.tar.gz'
  tar -xzf roberta.large.tar.gz
  rm roberta.large.tar.gz
  cd ..
fi


cd "$ROOD_DIR"
echo 'Building common vocab'
if [ ! -f "$DST_DIR/common_vocab_cased.txt" ]; then
  python lama/vocab_intersection.py
else
  echo 'Already exists. Run to re-build:'
  echo 'python lama/vocab_intersection.py'
fi

