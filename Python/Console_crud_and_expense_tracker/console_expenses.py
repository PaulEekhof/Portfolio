import json
import os
from datetime import datetime

# Constants
JSON_FILE = 'expenses.json'

# Load data from JSON file


def load_data():
    if os.path.exists(JSON_FILE):
        try:
            with open(JSON_FILE, 'r') as file:
                return json.load(file)
        except (json.JSONDecodeError, IOError):
            print("Error: Unable to load data. Starting with an empty list.")
    return []

# Save data to JSON file


def save_data(data):
    try:
        with open(JSON_FILE, 'w') as file:
            json.dump(data, file, indent=4)
    except IOError:
        print("Error: Unable to save data.")

# Generate a unique ID


def generate_id(data):
    if not data:
        return 1
    return max(item['id'] for item in data) + 1

# Validate user input for integers


def input_int(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            print("Invalid input. Please enter a valid integer.")

# Validate user input for non-empty strings


def input_str(prompt):
    while True:
        value = input(prompt).strip()
        if value:
            return value
        print("Input cannot be empty. Please try again.")

# Validate user input for float


def input_float(prompt):
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Invalid input. Please enter a valid number.")

# Validate user input for date (YYYY-MM-DD)


def input_date(prompt):
    while True:
        date_str = input_str(prompt)
        try:
            datetime.strptime(date_str, '%Y-%m-%d')  # Validate date format
            return date_str
        except ValueError:
            print("Invalid date format. Please use YYYY-MM-DD.")

# Validate user input for expense type (income/expense)


def input_type(prompt):
    while True:
        type_str = input(prompt).strip().lower()
        if type_str in ['income', 'expense']:
            return type_str
        print("Invalid type. Please enter 'income' or 'expense'.")

# Create a new expense


def create_expense(data):
    expense = {
        'id': generate_id(data),
        'date': input_date("Enter date (YYYY-MM-DD): "),
        'amount': input_float("Enter amount: "),
        'description': input_str("Enter description: "),
        'type': input_type("Enter type (income/expense): ")
    }
    data.append(expense)
    save_data(data)
    print("Expense added successfully!")

# Read and display all expenses


def read_expenses(data):
    if not data:
        print("No expenses found.")
    else:
        print("\n--- All Expenses ---")
        for expense in data:
            print(
                f"ID: {expense['id']}, "
                f"Date: {expense['date']}, "
                f"Amount: {expense['amount']}, "
                f"Description: {expense['description']}, "
                f"Type: {expense['type'].capitalize()}"
            )
        print("-------------------")

# Update an existing expense


def update_expense(data):
    expense_id = input_int("Enter expense ID to update: ")
    for expense in data:
        if expense['id'] == expense_id:
            expense['date'] = input_date(
                f"Enter new date (current: {expense['date']}): ")
            expense['amount'] = input_float(
                f"Enter new amount (current: {expense['amount']}): ")
            expense['description'] = input_str(
                f"Enter new description (current: {expense['description']}): ")
            expense['type'] = input_type(
                f"Enter new type (current: {expense['type']}): ")
            save_data(data)
            print("Expense updated successfully!")
            return
    print("Expense not found.")

# Delete an expense


def delete_expense(data):
    expense_id = input_int("Enter expense ID to delete: ")
    for expense in data:
        if expense['id'] == expense_id:
            data.remove(expense)
            save_data(data)
            print("Expense deleted successfully!")
            return
    print("Expense not found.")

# Search for expenses by description or date


def search_expenses(data):
    search_term = input_str("Enter search term (description or date): ")
    results = [
        expense for expense in data
        if search_term.lower() in expense['description'].lower() or search_term in expense['date']
    ]
    if results:
        print("\n--- Search Results ---")
        for expense in results:
            print(
                f"ID: {expense['id']}, "
                f"Date: {expense['date']}, "
                f"Amount: {expense['amount']}, "
                f"Description: {expense['description']}, "
                f"Type: {expense['type'].capitalize()}"
            )
    else:
        print("No matching expenses found.")

# Calculate total balance (income - expenses)


def calculate_balance(data):
    balance = 0
    for expense in data:
        if expense['type'] == 'income':
            balance += expense['amount']
        else:
            balance -= expense['amount']
    return balance

# The user can give two dates and the program will calculate the balance between those two dates


def calculate_balance_from_date():
    data = load_data()
    start_date = input_date("Enter start date (YYYY-MM-DD): ")
    end_date = input_date("Enter end date (YYYY-MM-DD): ")
    balance = 0
    for expense in data:
        if start_date <= expense['date'] <= end_date:
            if expense['type'] == 'income':
                balance += expense['amount']
            else:
                balance -= expense['amount']
    return balance


# Main menu
def main_menu():
    data = load_data()
    while True:
        print("\n--- Expense Tracker Menu ---")
        print("1. Add Expense/Income")
        print("2. View All Expenses")
        print("3. Update Expense")
        print("4. Delete Expense")
        print("5. Search Expenses")
        print("6. View Balance")
        print("7. Calculate Balance from Date")
        print("8. Exit")
        choice = input("Enter your choice: ").strip()

        if choice == '1':
            create_expense(data)
        elif choice == '2':
            read_expenses(data)
        elif choice == '3':
            update_expense(data)
        elif choice == '4':
            delete_expense(data)
        elif choice == '5':
            search_expenses(data)
        elif choice == '6':
            balance = calculate_balance(data)
            print(f"\nCurrent Balance: {balance}")
        elif choice == '7':
            balance = calculate_balance_from_date()
            break
        elif choice == '8':
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")


# Run the program
if __name__ == "__main__":
    main_menu()
