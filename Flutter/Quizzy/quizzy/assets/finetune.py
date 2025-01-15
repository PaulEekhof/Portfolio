from random import Random
from transformers import GPT2LMHeadModel, GPT2Tokenizer

# Load the fine-tuned model
model = GPT2LMHeadModel.from_pretrained("funny_question_model")
tokenizer = GPT2Tokenizer.from_pretrained("funny_question_model")

# Set up padding token
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token
    model.config.pad_token_id = model.config.eos_token_id

# Generate funny questions
input_prompt_list = [
    "Why did",
    "What do you call",
    "How many",
    "If you could",
    "What would happen if",
    "Have you ever",
    "When was the last time",
    "How come",
    "What would you do if",
    "Why is it that",
    "Who would win in a fight between",
    "If I told you",
    "What’s the deal with",
    "If you had to",
    "What happens when",
    "How would you feel if",
    "Do you think",
    "What’s your opinion on",
    "How would you explain",
    "Where do you think",
    "Why do we",
    "What’s the best way to",
    "If animals could",
    "Wouldn’t it be funny if",
    "What happens if you",
    "Can you imagine",
    "What’s the strangest thing about",
    "What would you say if",
    "How would you explain",
    "If you could choose",
    "Why do we always",
    "What’s the most ridiculous thing about",
    "How does it feel when",
    "Have you ever wondered",
    "If you could change",
    "What would you name",
    "What’s the weirdest thing",
    "Where would you go if",
    "Why can’t",
    "What if you could",
    "If you could time travel to",
    "How do you feel about",
    "What would it be like if",
    "Why is it that we",
    "What makes you think",
    "How would you describe",
    "What do you think would happen if",
    "Why can’t we just",
    "What is the first thing you think of when",
    "How much do you think",
    "What would you do if",
    "How do you explain",
    "Why do we think",
    "What happens when you try",
    "What would happen if you didn’t",
    "Have you ever thought about",
    "How do you feel when you",
    "If you had to guess",
    "What’s the funniest thing about",
    "When was the last time you",
    "If you could travel anywhere in time",
    "What’s the worst thing that could happen if",
    "What do you think is the reason for",
    "If you were in charge of",
    "What’s the most unexpected thing about",
    "What’s the most bizarre thing about",
    "How do you think we would react if",
    "What’s the first thing you’d do if",
    "If you could only choose one",
    "Why does everyone think",
    "What’s the first thing that comes to mind when",
    "Why do people always say",
    "How did we end up with",
    "Why do we always think that",
    "What would be the consequences of",
    "What makes you believe that",
    "How much would you pay to",
    "What would it take to",
    "Why don’t we ever",
    "How does it work when",
    "What’s the most random thing you’ve ever",
    "What would happen if you tried to",
    "How did that even happen",
    "Why is it so hard to",
    "What makes people think that",
    "How did you end up with",
    "What would you change about",
    "What if you could live in",
    "What’s your opinion on people who",
    "What’s the weirdest idea you’ve ever had",
    "Why do we need to",
    "What would you say if someone asked",
    "If you could do anything right now",
    "What’s something you wish people would stop saying",
    "What do you think would happen if",
    "How would you react if",
    "Why do you think people always",
    "What’s the most embarrassing thing about",
    "What would you ask if you could talk to",
    "How would you explain to someone who"
]

for _ in range(5):  # Generate 5 questions
    input_prompt = input_prompt_list[Random().randint(0, len(input_prompt_list) - 1)]
    inputs = tokenizer(
        input_prompt,
        return_tensors="pt",
        padding=True,
        add_special_tokens=True
    )

    try:
        # Generate with proper parameters
        output = model.generate(
            input_ids=inputs["input_ids"],
            attention_mask=inputs["attention_mask"],
            max_length=50,
            num_return_sequences=1,
            no_repeat_ngram_size=2,
            temperature=0.7,
            top_k=50,
            top_p=0.95,
            do_sample=True,
            pad_token_id=tokenizer.pad_token_id
        )

        # Decode the output
        generated_text = tokenizer.decode(output[0], skip_special_tokens=True)
        print(generated_text)
    except Exception as e:
        print(f"Error generating question for prompt '{input_prompt}': {e}")
