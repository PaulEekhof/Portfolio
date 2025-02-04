# Nova Caster

A Python application that predicts the next number in a sequence by combining traditional mathematical pattern recognition with AI-powered GGUF model predictions.

## Overview

This application uses a dual-approach system:
1. Mathematical pattern analysis for common sequences
2. AI-powered predictions using GGUF models for complex patterns

## Features

- Modern dark-themed GUI interface
- Multiple pattern recognition algorithms:
  - Arithmetic & geometric progressions
  - Fibonacci sequences
  - Polynomial patterns
  - Prime number relationships
  - Exponential growth/decay
  - Modular arithmetic patterns
  - Sequence symmetry
  - Number factorization
- GGUF model integration for advanced predictions
- CSV data import and analysis
- Comprehensive error handling and logging

## Requirements

- Python 3.8 or higher
- Dependencies:
  ```
  llama-cpp-python
  pandas
  numpy
  tkinter
  ```
- GGUF model file (recommended: Qwen2-Math or similar)

## Installation

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Download a GGUF model (e.g., Qwen2-Math) and place it in your preferred location

## Usage

### GUI Method
```bash
python gui.py
```
Then:
1. Click "Browse" to select your CSV file
2. Click "Browse" to select your GGUF model
3. Choose the numeric column to analyze
4. Click "Predict Next Number"

### API Usage
```python
from predictor import PredictNextNumber

predictor = PredictNextNumber(
    csv_file="data.csv",
    gguf_model_path="path/to/model.gguf"
)

predictor.select_column("numeric_column")
next_number = predictor.predict_next_value()
print(f"Next number: {next_number}")
```

## Directory Structure

```
NovaCaster/
├── gui.py          # GUI implementation
├── predictor.py    # Core prediction logic
├── rules.py        # Pattern recognition rules
└── README.md       # Documentation
```

## How It Works

1. Pattern Analysis:
   - Analyzes sequence for mathematical patterns
   - Identifies common progressions and relationships
   - Applies rule-based predictions when patterns are found

2. AI Prediction:
   - Uses GGUF model for complex pattern recognition
   - Processes numerical sequences as context
   - Generates predictions based on training

3. Combined Approach:
   - Prioritizes mathematical patterns when clear
   - Falls back to AI predictions for complex sequences
   - Provides confidence scores for predictions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

This project is licensed under the MIT License. See the LICENSE file for details.
