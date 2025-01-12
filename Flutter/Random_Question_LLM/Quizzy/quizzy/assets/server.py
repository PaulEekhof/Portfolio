from flask import Flask, request, jsonify
from transformers import GPT2LMHeadModel, GPT2Tokenizer

app = Flask(__name__)

# Load the fine-tuned model
model = GPT2LMHeadModel.from_pretrained("funny_question_model")
tokenizer = GPT2Tokenizer.from_pretrained("funny_question_model")

# Default prompt for random question generation
default_prompt = "Tell me a funny question:"

@app.route('/generate_question', methods=['POST'])
def generate_question():
    data = request.get_json()
    
    # Check if a prompt was provided, otherwise use the default prompt
    prompt = data.get('prompt', default_prompt)
    
    # Generate the funny question
    input_ids = tokenizer.encode(prompt, return_tensors="pt")
    output = model.generate(input_ids, max_length=50, num_return_sequences=1, no_repeat_ngram_size=2)
    generated_text = tokenizer.decode(output[0], skip_special_tokens=True)
    
    return jsonify({"question": generated_text})

if __name__ == '__main__':
    app.run(debug=True)
