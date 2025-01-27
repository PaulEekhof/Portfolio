# CRUD Application

This repository contains two simple CRUD (Create, Read, Update, Delete) applications written in Python. One application manages a list of generic items, and the other manages expenses and incomes. Both applications store data in JSON files.

## Features

### Item Management (console_crud.py)
- Create new items
- Read and display all items
- Update existing items
- Delete items
- Search for items by ID or name

### Expense Tracker (console_expenses.py)
- Add new expenses or incomes
- View all expenses and incomes
- Update existing expenses or incomes
- Delete expenses or incomes
- Search for expenses or incomes by description or date
- Calculate and display the total balance
- Calculate balance between two dates

## Requirements

- Python 3.x

## Usage

1. Clone the repository or download the source code.
2. Ensure you have Python 3.x installed on your machine.

### Running the Item Management Application

```sh
python console_crud.py
```

### Running the Expense Tracker Application

```sh
python console_expenses.py
```

## JSON Files

- `data.json`: Used by `console_crud.py` to store item data.
- `expenses.json`: Used by `console_expenses.py` to store expense and income data.

## Notes

- Ensure the JSON files are in the same directory as the Python scripts.
- The applications will create the JSON files if they do not exist.

## Function Descriptions

### console_crud.py

- `load_data()`: Loads data from the JSON file.
- `save_data(data)`: Saves data to the JSON file.
- `generate_id(data)`: Generates a unique ID for new items.
- `input_int(prompt)`: Validates user input for integers.
- `input_str(prompt)`: Validates user input for non-empty strings.
- `create_item(data)`: Creates a new item and adds it to the data.
- `read_items(data)`: Reads and displays all items.
- `update_item(data)`: Updates an existing item.
- `delete_item(data)`: Deletes an item.
- `search_item(data)`: Searches for an item by ID or name.
- `main_menu()`: Displays the main menu and handles user choices.

### console_expenses.py

- `load_data()`: Loads data from the JSON file.
- `save_data(data)`: Saves data to the JSON file.
- `generate_id(data)`: Generates a unique ID for new expenses.
- `input_int(prompt)`: Validates user input for integers.
- `input_str(prompt)`: Validates user input for non-empty strings.
- `input_float(prompt)`: Validates user input for floats.
- `input_date(prompt)`: Validates user input for dates in YYYY-MM-DD format.
- `input_type(prompt)`: Validates user input for expense type (income/expense).
- `create_expense(data)`: Creates a new expense and adds it to the data.
- `read_expenses(data)`: Reads and displays all expenses.
- `update_expense(data)`: Updates an existing expense.
- `delete_expense(data)`: Deletes an expense.
- `search_expenses(data)`: Searches for expenses by description or date.
- `calculate_balance(data)`: Calculates the total balance (income - expenses).
- `calculate_balance_from_date()`: Calculates the balance between two dates.
- `main_menu()`: Displays the main menu and handles user choices.