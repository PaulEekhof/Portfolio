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