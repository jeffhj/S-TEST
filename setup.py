# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#
from setuptools import setup, find_packages

requirements = ['Cython==0.29.2', 'numpy==1.15.1', 'torch==1.2.0', 'pytorch-pretrained-bert==0.6.1', 'allennlp==0.9.0', 'spacy==2.1.8', 'tqdm==4.26.0', 'termcolor==1.1.0', 'pandas==0.23.4', 'fairseq==0.8.0', 'scipy==1.3.2', 'urllib3==1.26.7']
setup(
    name = 'S-TEST',
    version = '0.1.2',
    description = 'S-TEST: Specificity Testing',
    packages = find_packages(),
    install_requires=requirements,
)
