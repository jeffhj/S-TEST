# S-TEST: Specificity Testing

The code and data for "[Can Language Models Be Specific? How?](https://arxiv.org/abs/2210.05159)"



## Introduction

S-TEST is a benchmark for measuring the specificity of the language of pre-trained language models. <br>

Currently, S-TEST contains a set of connectors to the following pre-trained language models. <br>

- GPT-2 (Radford et al., 2019)
- BERT-Base (Devlin et al., 2019)
- BERT-Large (Devlin et al., 2019)
- RoBERTa-Base (Liu et al., 2019)
- RoBERTa-Large (Liu et al., 2019)

> This repo is build upon the [LAMA benchmark](https://github.com/facebookresearch/LAMA).



## The S-TEST Probe

To reproduce the results:

### 1. Create conda environment and install requirements

```
conda create -n stest37 -y python=3.7 && conda activate stest37
python setup.py install
pip install -r requirements.txt
```

### 2. Download the models

Install spacy model

```bash
python3 -m spacy download en
```

Download the models

```bash
chmod +x download_models.sh
./download_models.sh
```

The script will create and populate a `pre-trained_language_models` folder.
If you are interested in a particular model please edit the script.


### 3. Run the experiments

```bash
python scripts/run_experiments.py
```

Temporary results will be logged in `output/` and  `last_results.csv`

### 4. Evaluate with $p_r$

```bash
python eval.py
```



## Citation

The details of this repo are described in the following paper. If you find this repo useful, please kindly cite it:

```
@article{huang2022can,
  title={Can Language Models Be Specific? How?},
  author={Huang, Jie and Chang, Kevin Chen-Chuan and Xiong, Jinjun and Hwu, Wen-mei},
  journal={arXiv preprint arXiv:2210.05159},
  year={2022}
}
```

