# Quizzy

**Quizzy** is a fun and interactive Flutter application that generates hilarious questions using a custom-trained GPT-2 model running on a local server. The app provides users with random funny questions, allows them to input their own prompts, and lets them save their favorite questions for later use.

## Features

- **Generate Random Funny Questions**: With a tap, users can get a random funny question
- **Input a Custom Prompt**: Users can input their own prompts for unique questions
- **Save Favorite Questions**: Save and access favorite questions anytime
- **View Saved Questions**: Dedicated screen to view and manage saved questions
- **Simple and Intuitive UI**: Clean, user-friendly interface
- **State Management Using Provider**: Efficient state management
- **Multiple Quiz Types**: Support for various question categories
- **Localization Support**: Ready for multiple languages

## Requirements

- Flutter SDK
- Python 3.7+
- PyTorch
- Flask

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/quizzy.git
    ```
2. Navigate to the project directory:
    ```sh 
    cd quizzy
    ```
3. Install Flutter dependencies:
    ```sh
    flutter pub get
    ```
4. Install Python dependencies:
    ```sh
    pip install -r requirements.txt
    ```

## Model Setup

1. Download the pre-trained model:
    ```sh
    python download_model.py
    ```
2. Fine-tune the model (optional):
    ```sh
    python finetune.py
    ```

## Running the App

1. Start the Flask server:
    ```sh
    python server.py
    ```
2. Run the Flutter app:
    ```sh
    flutter run
    ```

## Project Structure

Here’s an overview of the file structure:

- **`main.dart`**: The entry point of the Flutter app, setting up core functionality and navigation.
- **`funnyquestions.dart`**: Contains logic for generating and displaying funny questions.
- **`favorites.dart`**: Displays a screen showing a list of saved favorite questions loaded from `assets/save.json`.
- **`generate.dart`**: A screen with buttons to generate random questions or input prompts to generate custom questions.
- **`question.dart`**: Displays a screen where users can enter a custom prompt, and upon pressing "GO", a generated question is shown.
- **`model.dart`**: Handles interactions with the model, including generating responses to prompts.

## Model

The app uses a fine-tuned GPT-2 model to generate funny questions. Key components of the model:

- **Loader**: Loads the pre-trained model for generating questions.
- **Pre-trainer**: Prepares the model for training on a custom dataset.
- **Tokenizer**: Tokenizes input text into a format that the model can understand.
- **Language Modeling**: Handles language modeling to generate appropriate responses.
- **Training Arguments**: Specifies the configuration for model training.
- **Trainer**: Trains the model on the custom datasets.
- **Model Saver**: Saves the trained model for future use.

## Fine-tuning

The GPT-2 model is fine-tuned using a custom dataset containing:

- 100 starter question prompts to enable diverse and engaging question generation.

## Server

The app also includes a Flask server that runs the fine-tuned GPT-2 model locally. The server listens for input prompts and returns a generated funny question as a response.

## How to Run the Server

1. Install the necessary Python dependencies:
    ```sh
    pip install -r requirements.txt
    ```
2. Start the Flask server:
    ```sh
    python server.py
    ```

The server will be accessible on `http://localhost:5000`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
