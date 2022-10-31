import pickle
import json
import numpy as np
from tqdm import tqdm


relations_vp = ["P19", "P106", "P131", "P279", "P361"]
relations_fp = [x+"-fp" for x in relations_vp]
relations_cp = [x+"-cp" for x in relations_vp]
relations = relations_vp + relations_fp + relations_cp

models = ["gpt2", "bert_base", "bert_large", "roberta.base", "roberta.large"]


def get_rank(obj, ret):
    topk = ret['masked_topk']['topk']
    for x in topk:
        if obj==x['token_word_form']:
            return x['i']+1
    return len(topk)+1

def get_ds(relation_name):
    ds = {}
    with open(f"data/S-TEST/{relation_name}.jsonl") as f:
        for line in f:
            d_tmp = json.loads(line)
            ds[d_tmp['sub_label']] = d_tmp
    return ds

def measure_granularity(relation_name, model_name):
    pos=0
    ds = get_ds(relation_name)
    data = pickle.load(open(f"output/results/{model_name}/{relation_name}/result.pkl", 'rb'))

    for ret in data['list_of_results']:
        sub = ret['sample']['sub_label']
        obj1 = ds[sub]['obj_label']
        obj2 = ds[sub]['obj2_label']
        r1 = get_rank(obj1, ret)
        r2 = get_rank(obj2, ret)
        if r1<r2:
            pos+=1

    pr = pos / len(data['list_of_results'])
    return pr



print(models)
print(relations)

for m in models:
    for r in relations:
        pr = measure_granularity(r,m)
        print(r, m, "|", "p_r:", pr)
    print("-----------------")