# Personal Expense Tracker

This is a personal expense management application built with Python and customtkinter.

## Features
- Add new expenses
- Edit existing expenses
- Delete expenses
- Export expenses to a text file
- Search expenses by category
- View all expenses
- Calculate total, difference, and future balance based on selected expenses

## How to Run
1. Ensure you have Python installed on your system.
2. Install the required dependencies:
   ```bash
   pip install customtkinter tkcalendar
   ```
3. Run the application:
   ```bash
   python app2.py
   ```

## Usage
1. **Home**: View the latest expense and income.
2. **Expenses**: View all expenses.
3. **New Expense**: Add a new expense by entering the description, amount, date, and category, then click "Add Expense".
4. **Edit Expense**: Select an expense from the dropdown, load the expense details, edit the fields, and click "Edit Expense" to update the expense.
5. **Search**: Search expenses by category and view the results.
6. **Export**: Export a selection of expenses or all expenses to a TXT file.
7. **Exit**: Exit the application.

## Data Storage
- All data is saved in `data.json` file in the same directory as the application.
- The data is a list of expenses, where each expense is a dictionary with the keys "description", "amount", "date", and "category".

## Example Data
```json
{
    "expenses": [
        {"description": "bread", "amount": 1.5, "date": "2023-01-01", "category": "groceries"},
        {"description": "butter", "amount": 2.0, "date": "2023-01-02", "category": "groceries"}
    ],
    "categories": ["groceries"]
}
```

## License
This project is licensed under the MIT License.
