import os
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, Trainer, TrainingArguments, DataCollatorForLanguageModeling
from datasets import Dataset
import joblib

class CustomAIModelTrainer:
    def __init__(self, data_directory, model_name, dataset_list):
        """
        Initialize the trainer with a data directory, a model name, and a list of text files.

        :param data_directory: Directory containing the training data.
        :param model_name: Name of the Hugging Face model to train (e.g., 'gpt2').
        :param dataset_list: List of text files to use for training.
        """
        self.data_directory = data_directory
        self.model_name = model_name
        self.dataset_list = dataset_list
        self.tokenizer = AutoTokenizer.from_pretrained(model_name)
        
        # Set padding token if not already set
        if self.tokenizer.pad_token is None:
            self.tokenizer.pad_token = self.tokenizer.eos_token
        
        self.model = AutoModelForCausalLM.from_pretrained(model_name)

    def load_data(self):
        """Load the training data from the specified list of text files."""
        contexts = []
        next_sentences = []
        for filename in self.dataset_list:
            file_path = os.path.join(self.data_directory, filename)
            if os.path.isfile(file_path) and filename.endswith('.txt'):
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        lines = file.readlines()
                except UnicodeDecodeError:
                    with open(file_path, 'r', encoding='latin-1') as file:
                        lines = file.readlines()
                for line in lines:
                    if line.startswith("Context:"):
                        contexts.append(line.replace("Context:", "").strip())
                    elif line.startswith("Next Sentence:"):
                        next_sentences.append(line.replace("Next Sentence:", "").strip())
        # Debug: Print the number of contexts and next sentences loaded
        print(f"Number of contexts loaded: {len(contexts)}")
        print(f"Number of next sentences loaded: {len(next_sentences)}")
        return contexts, next_sentences

    def train_model(self):
        """Train the Hugging Face model."""
        contexts, next_sentences = self.load_data()
        train_texts = [f"{context} {next_sentence}" for context, next_sentence in zip(contexts, next_sentences)]
        
        # Debug: Print the number of training texts
        print(f"Number of training texts: {len(train_texts)}")
        
        # Check if the dataset is empty
        if len(train_texts) == 0:
            raise ValueError("The training dataset is empty. Please check the input data.")

        # Create a Dataset from the training texts
        train_dataset = Dataset.from_dict({"text": train_texts})

        # Tokenize the dataset
        def tokenize_function(examples):
            return self.tokenizer(examples["text"], truncation=True, max_length=128, padding="max_length")

        tokenized_dataset = train_dataset.map(tokenize_function, batched=True, remove_columns=["text"])

        # Create a DataCollator for language modeling
        data_collator = DataCollatorForLanguageModeling(
            tokenizer=self.tokenizer,
            mlm=False
        )

        # Define training arguments
        training_args = TrainingArguments(
            output_dir='./results',
            overwrite_output_dir=True,
            num_train_epochs=1,
            per_device_train_batch_size=4,
            save_steps=10_000,
            save_total_limit=2,
            remove_unused_columns=False,  # Add this line to avoid the error
        )

        # Create a Trainer
        trainer = Trainer(
            model=self.model,
            args=training_args,
            data_collator=data_collator,
            train_dataset=tokenized_dataset,
        )

        # Train the model
        trainer.train()
        self.save_model(self.model, f'{self.model_name}_custom_model')

    def predict(self, context):
        """Predict the next sentence for the given context using the trained model."""
        input_ids = self.tokenizer.encode(context, return_tensors="pt")
        output = self.model.generate(
            input_ids,
            max_length=len(input_ids[0]) + 50,
            temperature=0.7,
            num_return_sequences=1,
            pad_token_id=self.tokenizer.eos_token_id,
            do_sample=True,
            top_k=50,
            top_p=0.95
        )
        generated_text = self.tokenizer.decode(output[0], skip_special_tokens=True)
        next_sentence = generated_text[len(context):].strip()
        return next_sentence

    def save_model(self, model, model_path):
        """Save the trained model to a file."""
        model.save_pretrained(model_path)
        self.tokenizer.save_pretrained(model_path)
        print(f"Model saved to {model_path}")
        
    def full_pipeline_predict(self):
        """Train the model, save it, and make a prediction."""
        self.train_model()
        context = "The bar graph compares the total rainfall in four different seasons, with seasons on the x-axis and rainfall in millimeters on the y-axis."
        prediction = self.predict(context)
        print("Predicted next sentence:", prediction)
        
    def full_pipeline_save(self):
        """Train the model and save it."""
        self.train_model()
        self.save_model(self.model, f'{self.model_name}_custom_test_model')

# Example usage:
if __name__ == "__main__":
    # Prepare the directory and file list
    # Test
    data_directory = 'datasets/test'
    # Full dataset
    # data_directory = 'datasets/matplotlib'
    dataset_list = [f for f in os.listdir(data_directory) if f.endswith('.txt')]

    # if no files are found, add this list of files
    if len(dataset_list) == 0:
        dataset_list = ["datasets/test/test.txt", 'datasets/test/test copy.txt']
        
    # Debug: Print the dataset list
    print(f"Dataset list: {dataset_list}")
    
    # Initialize the trainer
    trainer = CustomAIModelTrainer(
        data_directory=data_directory,
        model_name='gpt2',  # Use a valid model identifier
        dataset_list=dataset_list
    )

    # Train the model
    # trainer.train_model()
    trainer.full_pipeline_predict()

    # Make a prediction
    context = "The bar graph compares the total rainfall in four different seasons, with seasons on the x-axis and rainfall in millimeters on the y-axis."
    prediction = trainer.predict(context)
    print("Predicted next sentence:", prediction)
