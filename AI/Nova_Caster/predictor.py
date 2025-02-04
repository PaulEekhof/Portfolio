import pandas as pd
import numpy as np
import logging
from rules import RULES

# Using llama_cpp for GGUF model inference
try:
    from llama_cpp import Llama
except ImportError:
    raise ImportError("The 'llama-cpp-python' library is not installed. Please install it using 'pip install llama-cpp-python'")

class PredictNextNumber:
    def __init__(self, csv_file: str, gguf_model_path: str):
        self.csv_file = csv_file
        self.df = None
        self.column_data = None
        self.setup_logging()  # Initialize logging first
        self.model = self.load_gguf_model(gguf_model_path)  # Load GGUF model
        self.rules = RULES()
        self.load_csv()
        self.data = self.df  # Add this line for GUI compatibility

    def setup_logging(self):
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )
        self.logger = logging.getLogger(__name__)

    def load_csv(self):
        try:
            self.df = pd.read_csv(self.csv_file)
            self.logger.info("CSV file '%s' loaded successfully.", self.csv_file)
        except Exception as e:
            self.logger.error("Error loading CSV file '%s': %s", self.csv_file, e)
            raise

    def select_column(self, column_name: str):
        if column_name not in self.df.columns:
            raise ValueError(f"Column '{column_name}' not found in CSV.")
        # Convert the column to numeric, converting non-numeric values to NaN, then drop NaNs
        numeric_series = pd.to_numeric(self.df[column_name], errors='coerce').dropna()
        if numeric_series.empty:
            raise ValueError(f"No numeric data found in column '{column_name}'.")
        self.column_data = numeric_series.values
        self.logger.info("Selected column '%s' with %d numeric entries.", column_name, len(self.column_data))

    def prepare_data(self):
        """
        Prepare data by extracting the last 5 numeric values from the selected column.
        """
        if self.column_data is None:
            raise ValueError("No column selected. Please run select_column() first.")
        if len(self.column_data) < 5:
            raise ValueError("Not enough data to prepare prompt. Need at least 5 data points.")
        last_5_values = self.column_data[-5:]
        self.logger.info("Prepared prompt with last 5 values: %s", last_5_values)
        return last_5_values

    def load_gguf_model(self, model_path: str):
        try:
            model = Llama(model_path=model_path)
            self.logger.info("GGUF model loaded successfully from '%s'.", model_path)
            return model
        except Exception as e:
            self.logger.error("Error loading GGUF model: %s", e)
            raise

    def train_model(self):
        """
        Train the model using a rolling window of 5 values to predict the 6th value.
        Training is skipped because the GGUF model is already pretrained.
        """
        self.logger.info("Skipping model training as GGUF model is pretrained.")

    def analyze_pattern(self, sequence):
        """Analyze sequence and return appropriate rule if pattern is found"""
        if self.rules.is_arithmetic(sequence):
            return "arithmetic"
        if self.rules.is_geometric(sequence):
            return "geometric"
        if self.rules.is_fibonacci_like(sequence):
            return "fibonacci"
        if self.rules.is_exponential(sequence):
            return "exponential"
        return None

    def apply_rule(self, sequence, rule_type):
        """Apply the identified rule to predict next value"""
        if rule_type == "arithmetic":
            diff = sequence[-1] - sequence[-2]
            return sequence[-1] + diff
        if rule_type == "geometric":
            ratio = sequence[-1] / sequence[-2]
            return sequence[-1] * ratio
        if rule_type == "fibonacci":
            return sequence[-1] + sequence[-2]
        if rule_type == "exponential":
            ratio = sequence[-1] / sequence[-2]
            return sequence[-1] * ratio
        return None

    def predict_next_value(self) -> float:
        """
        Predict the next value using the last 10 numeric values from the selected column.
        Attempts to safely extract a numeric prediction from model output.
        """
        if self.column_data is None or len(self.column_data) < 10:
            raise ValueError("Not enough data to predict next value. Ensure at least 10 numeric data points are available.")
        try:
            # Prepare the prompt using the last 10 values
            last_10_values = self.column_data[-10:]
            prompt = f"Based on the following values: {last_10_values.tolist()}, predict the next numerical value."
            
            # Call the model (using __call__)
            response = self.model(
                prompt=prompt,
                max_tokens=10,
                temperature=0.7,
                top_p=0.95
            )
            if 'choices' in response and response['choices']:
                prediction_str = response['choices'][0]['text'].strip()
                try:
                    return float(prediction_str)
                except ValueError:
                    # Try extracting a float using regular expressions
                    import re
                    numbers = re.findall(r"[-+]?\d*\.\d+|\d+", prediction_str)
                    if not numbers:
                        raise ValueError(f"No valid number in model output: {prediction_str}")
                    return float(numbers[0])
            raise ValueError("Model did not return any choices for prediction.")
        except Exception as e:
            self.logger.error("Prediction error: %s", e)
            raise

if __name__ == "__main__":
    # Use a raw string to avoid escape sequence issues in the file path.
    path = "" # Add the path to your GGUF model here
    test_data = "csv_test.csv"  # Add the path to your CSV file here
    predictor = PredictNextNumber(test_data, path)
    predictor.select_column("numeric_column")  # Replace "numeric_column" with an actual numeric column name from your CSV.
    prediction = predictor.predict_next_value()
    print("Prediction:", prediction)
