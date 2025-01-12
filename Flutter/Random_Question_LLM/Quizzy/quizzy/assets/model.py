from transformers import GPT2LMHeadModel, GPT2Tokenizer, Trainer, TrainingArguments, DataCollatorForLanguageModeling
from datasets import load_dataset, concatenate_datasets
import torch
from accelerate import Accelerator

# Initialize accelerator
accelerator = Accelerator()

# Load your existing question dataset
questions_dataset = load_dataset("text", data_files={"train": "assets/quetions.txt"}, split="train")

# Load additional datasets
jokes_dataset = load_dataset("text", data_files={"train": "assets/jokes.txt"}, split="train")
riddles_dataset = load_dataset("text", data_files={"train": "assets/riddles.txt"}, split="train")
workplace_dataset = load_dataset("text", data_files={"train": "assets/workplace.txt"}, split="train")

# Combine datasets
combined_dataset = concatenate_datasets([
    questions_dataset,
    jokes_dataset,
    riddles_dataset,
    workplace_dataset
])

# Load pre-trained GPT-2 model and tokenizer
model = GPT2LMHeadModel.from_pretrained("gpt2")
tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

# Setup padding token
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token
    model.config.pad_token_id = model.config.eos_token_id

# Tokenize the dataset
def tokenize_function(examples):
    outputs = tokenizer(examples["text"], truncation=True, padding="max_length", max_length=50)
    outputs["labels"] = outputs["input_ids"].copy()  # Add labels for loss calculation
    return outputs

# Use the combined dataset instead of the single dataset
tokenized_datasets = combined_dataset.map(tokenize_function, batched=True)

# Create data collator for language modeling
data_collator = DataCollatorForLanguageModeling(
    tokenizer=tokenizer,
    mlm=False  # We want standard language modeling, not masked
)

# Set up training arguments
training_args = TrainingArguments(
    output_dir="./results",
    per_device_train_batch_size=4,
    num_train_epochs=3,
    logging_dir="./logs",
    save_steps=500,
    logging_steps=100,
)

# Initialize trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized_datasets,
    data_collator=data_collator,
)

# Ensure input tensor is not empty before passing to the model
def safe_train():
    try:
        # Check if dataset is empty
        if len(tokenized_datasets) == 0:
            print("Error: Dataset is empty")
            return
        
        # Check if dataset has required features
        if not all(key in tokenized_datasets.features for key in ['input_ids', 'attention_mask']):
            print("Error: Dataset missing required features")
            return
            
        # Train the model
        trainer.train()
        
        # Save the model
        model.save_pretrained("funny_question_model")
        tokenizer.save_pretrained("funny_question_model")
        
    except Exception as e:
        print(f"Training error occurred: {str(e)}")
        raise

# Train the model
safe_train()
