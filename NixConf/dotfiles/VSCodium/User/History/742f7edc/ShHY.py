import requests
import json
import os
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, TrainingArguments
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader
from tqdm import tqdm

#------------setup--------------#
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

model_id = "Qwen/Qwen2.5-3B-Instruct"

tokenizer = AutoTokenizer.from_pretrained(model_id)

model = AutoModelForCausalLM.from_pretrained(
    model_id,
    torch_dtype=torch.float16,
    device_map="auto"
)


lora_config = LoraConfig(
    r=8,
    lora_alpha=32,
    lora_dropout=0.1,
    bias="none",
    task_type="CAUSAL_LM",
)

model.train()

#------------data--------------#

dataset = load_dataset("daily_dialog")


def format_to_llama_chat(chat):
    messages = []
    for i, utterance in enumerate(example["dialog"]):
        role = "user" if i % 2 == 0 else "assistant"
        messages.append({"role": role, "content": utterance.strip()})
    

    text = tokenizer.apply_chat_template(
        messages, 
        tokenize=False, 
        add_generation_prompt=False
    )
    return {"text": text}


formatted_dataset = dataset.map(format_to_llama_chat, remove_columns=["dialog", "act", "emotion"])

print(formatted_dataset["train"][0])["text"]