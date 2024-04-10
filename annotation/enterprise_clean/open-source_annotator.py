# A sample annotation script, wipe out infomation related to privacy

import argparse
from datasets import load_dataset , Dataset
import os
import pandas as pd
import json
import sys
from tqdm.auto import tqdm
from vllm import LLM,SamplingParams,EngineArgs
from time import sleep
import random
import re

random.seed(42)

def main() -> None:

    output_path = "..."
    output_name = "..."

    path = '...'
    with open(path, mode='r',encoding='utf-8') as f:
        problems = json.load(f)

    model_name_or_path = "..."
    samplingparams = SamplingParams(
        top_k = 10,
        top_p = 0.95,
        temperature = 0.3,
        max_tokens = 4096,
        frequency_penalty = 1.2
    )
    llm = LLM(
        model = model_name_or_path,
        tokenizer = model_name_or_path,
        tokenizer_mode='auto',
        trust_remote_code=False,
        download_dir=None,
        tensor_parallel_size=8,
        block_size=16,
        gpu_memory_utilization=0.8,
        max_num_seqs=256,
    )

    prompts = []
    dicts = []

    print("Begin mapping data...")
    for entry in problems:
        prompt = entry.get('prompt', entry.get('question', None)),
        dict = {
            'prompt': prompt,
            'detail': entry,
        }
        prompts.append(prompt)
        dicts.append(dict)

    print("End mapping data...")
    print(f"The first insight of mapped dataset:{prompts[0]}")

    outputs = llm.generate(prompts, samplingparams)
    answers = []
    for dict ,output in zip(dicts,outputs):
        model_output = output.outputs[0].text

        answers.append(
            {
                'prompt': dict['prompt'],
                'detail': dict['detail'],
                'merged_prompt': model_output,
            },
        )
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    
    with open(os.path.join(output_path,output_name),mode='w',encoding='utf-8') as f:
        json.dump(answers,f, indent=4, ensure_ascii=False)

if __name__=='__main__':
    sys.exit(main())
    
