import customtkinter as ctk
import tkinter as tk
from tkinter import messagebox
from tkcalendar import DateEntry
import json
from datetime import datetime
import csv
import uuid

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Personal Expense Tracker")
        self.geometry("1080x720")
        self.data, self.categories = self.load_data()
        self.configure_grid()
        self.create_widgets()

    def load_data(self):
        try:
            with open('data.json', 'r') as file:
                data = json.load(file)
                return data.get('expenses', []), data.get('categories', [])
        except (FileNotFoundError, json.JSONDecodeError):
            return [], []

    def save_data(self):
        with open('data.json', 'w') as file:
            json.dump({"expenses": self.data, "categories": self.categories}, file)

    def configure_grid(self):
        self.grid_columnconfigure(1, weight=1)
        self.grid_rowconfigure(0, weight=1)

    def create_widgets(self):
        self.sidebar = ctk.CTkFrame(self, width=200, corner_radius=10)
        self.sidebar.grid(row=0, column=0, sticky="nswe", padx=10, pady=10)
        self.create_sidebar()

        self.content = ctk.CTkFrame(self, corner_radius=10)
        self.content.grid(row=0, column=1, sticky="nswe", padx=10, pady=10)
        self.show_home_frame()

    def create_sidebar(self):
        buttons = [
            ("Home", self.show_home_frame),
            ("Expenses", self.show_expenses_frame),
            ("New Expense", self.show_new_expense_form),
            ("Edit Expense", self.show_edit_frame),
            ("Search", self.show_search_frame),
            ("Export", self.show_export_frame),
            ("Categories", self.show_categories_frame),
            ("Exit", self.quit)
        ]

        for text, command in buttons:
            button = ctk.CTkButton(
                self.sidebar, 
                text=text, 
                command=command,
                width=180,
                height=40,
                corner_radius=10
            )
            button.pack(pady=10)

    def show_home_frame(self):
        self.clear_content()
        HomeFrame(self.content, self).pack(fill="both", expand=True)

    def show_expenses_frame(self):
        self.clear_content()
        ExpenseFrame(self.content, self).pack(fill="both", expand=True)

    def show_new_expense_form(self):
        self.clear_content()
        NewFrame(self.content, self).pack(fill="both", expand=True)

    def show_edit_frame(self):
        if not self.data:
            messagebox.showerror("No expenses", "No expenses found to edit")
            return
        self.clear_content()
        EditFrame(self.content, self).pack(fill="both", expand=True)

    def show_search_frame(self):
        self.clear_content()
        SearchFrame(self.content, self).pack(fill="both", expand=True)

    def show_export_frame(self):
        self.clear_content()
        ExportFrame(self.content, self).pack(fill="both", expand=True)

    def show_categories_frame(self):
        self.clear_content()
        CategoriesFrame(self.content, self).pack(fill="both", expand=True)

    def clear_content(self):
        for widget in self.content.winfo_children():
            widget.destroy()

class HomeFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        labels = [
            "Home",
            "Welcome to the Expense Tracker.",
            "Use the sidebar to navigate the app.",
            "Manage, search, and export your expenses with ease."
        ]
        for text in labels:
            label = ctk.CTkLabel(self, text=text, font=("Helvetica", 16))
            label.pack(pady=10)

class ExpenseFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = ctk.CTkLabel(self, text="Expenses", font=("Helvetica", 18))
        label.pack(pady=10)

        self.expenses_listbox = tk.Listbox(self, bg="black", fg="white", selectbackground="gray")
        self.expenses_listbox.pack(fill="both", expand=True, pady=10, padx=10)
        
        self.load_expenses(controller.data)

    def load_expenses(self, data):
        self.expenses_listbox.delete(0, tk.END)
        if not data:
            self.expenses_listbox.insert(tk.END, "No expenses yet")
        else:
            for index, expense in enumerate(data, start=1):
                self.expenses_listbox.insert(
                    tk.END, f"{index}. €{expense['amount']} | {expense['description']} (Date: {expense['date']})"
                )

class NewFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        self.controller = controller
        label = ctk.CTkLabel(self, text="Add New Expense", font=("Helvetica", 18))
        label.pack(pady=10)

        fields = [
            ("Description", ctk.CTkEntry),
            ("Amount", ctk.CTkEntry),
            ("Date", lambda parent: DateEntry(parent, date_pattern='yyyy-mm-dd'))
        ]

        self.entries = {}
        for name, widget in fields:
            lbl = ctk.CTkLabel(self, text=name + ":")
            lbl.pack(pady=5)
            entry = widget(self)
            entry.pack(pady=5)
            self.entries[name] = entry

        self.category_label = ctk.CTkLabel(self, text="Category:")
        self.category_label.pack(pady=5)
        self.category_combobox = ctk.CTkComboBox(self, values=self.controller.categories)
        self.category_combobox.pack(pady=5)

        self.new_category_label = ctk.CTkLabel(self, text="New Category:")
        self.new_category_label.pack(pady=5)
        self.new_category_entry = ctk.CTkEntry(self)
        self.new_category_entry.pack(pady=5)

        add_btn = ctk.CTkButton(self, text="Add Expense", command=self.add_expense)
        add_btn.pack(pady=20)

    def add_expense(self):
        description = self.entries["Description"].get()
        amount = self.entries["Amount"].get()
        try:
            amount = float(amount)
        except ValueError:
            messagebox.showerror("Invalid input", "Amount must be a number")
            return
        
        date = self.entries["Date"].get_date().strftime("%Y-%m-%d")
        category = self.category_combobox.get()
        new_category = self.new_category_entry.get()

        if new_category:
            if new_category not in self.controller.categories:
                self.controller.categories.append(new_category)
                category = new_category
            else:
                messagebox.showerror("Invalid input", "Category already exists")
                return

        expense_id = str(uuid.uuid4())
        self.controller.data.append({"id": expense_id, "description": description, "amount": amount, "date": date, "category": category})
        self.controller.save_data()
        messagebox.showinfo("Info", f"Expense added: {description} - {amount}")
        self.controller.show_new_expense_form()

class EditFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        self.controller = controller
        self.label = ctk.CTkLabel(self, text="Edit Expense")
        self.label.pack(pady=10, padx=10)

        self.expense_listbox = ctk.CTkComboBox(self, values=self.get_expenses())
        self.expense_listbox.pack(pady=5, padx=10)

        button_load = ctk.CTkButton(self, text="Load Expense", command=self.load_expense)
        button_load.pack(pady=10, padx=10)

        self.description_label = ctk.CTkLabel(self, text="Description:")
        self.description_label.pack(pady=5, padx=10)
        self.description_entry = ctk.CTkEntry(self)
        self.description_entry.pack(pady=5, padx=10)

        self.amount_label = ctk.CTkLabel(self, text="Amount:")
        self.amount_label.pack(pady=5, padx=10)
        self.amount_entry = ctk.CTkEntry(self)
        self.amount_entry.pack(pady=5, padx=10)

        self.date_label = ctk.CTkLabel(self, text="Date:")
        self.date_label.pack(pady=5, padx=10)
        self.date_entry = DateEntry(self, date_pattern='yyyy-mm-dd')
        self.date_entry.pack(pady=5, padx=10)

        self.category_label = ctk.CTkLabel(self, text="Category:")
        self.category_label.pack(pady=5, padx=10)
        self.category_entry = ctk.CTkEntry(self)
        self.category_entry.pack(pady=5, padx=10)

        self.edit_button = ctk.CTkButton(self, text="Edit Expense", command=self.edit_expense)
        self.edit_button.pack(pady=10, padx=10)

        self.delete_button = ctk.CTkButton(self, text="Delete Expense", command=self.delete_expense)
        self.delete_button.pack(pady=10, padx=10)

    def get_expenses(self):
        return [f"{expense.get('description', 'N/A')}: €{expense.get('amount', 'N/A')} (Date: {expense.get('date', 'N/A')})" for expense in self.controller.data]

    def load_expense(self):
        selected_value = self.expense_listbox.get()
        if not selected_value:
            messagebox.showerror("No selection", "Please select an expense to edit")
            return
        try:
            selected_index = self.get_expenses().index(selected_value)
        except ValueError:
            messagebox.showerror("Not found", "Selected expense not found")
            return
        expense = self.controller.data[selected_index]

        self.description_entry.delete(0, tk.END)
        self.description_entry.insert(0, expense.get("description", ""))

        self.amount_entry.delete(0, tk.END)
        self.amount_entry.insert(0, expense.get("amount", ""))

        self.date_entry.set_date(expense.get("date", datetime.now().strftime("%Y-%m-%d")))

        self.category_entry.delete(0, tk.END)
        self.category_entry.insert(0, expense.get("category", ""))

    def edit_expense(self):
        selected_value = self.expense_listbox.get()
        if not selected_value:
            messagebox.showerror("No selection", "Please select an expense to edit")
            return
        selected_index = self.get_expenses().index(selected_value)
        description = self.description_entry.get()
        try:
            amount = float(self.amount_entry.get())
        except ValueError:
            messagebox.showerror("Invalid input", "Amount must be a number")
            return

        if not description or amount <= 0:
            messagebox.showerror("Invalid input", "Please enter a valid description and amount")
            return

        date = self.date_entry.get_date().strftime("%Y-%m-%d")
        category = self.category_entry.get()
        self.controller.data[selected_index] = {"id": self.controller.data[selected_index]["id"], "description": description, "amount": amount, "date": date, "category": category}
        self.controller.save_data()
        self.controller.show_edit_frame()

    def delete_expense(self):
        selected_value = self.expense_listbox.get()
        if not selected_value:
            messagebox.showerror("No selection", "Please select an expense to delete")
            return
        try:
            selected_index = self.get_expenses().index(selected_value)
        except ValueError:
            messagebox.showerror("Error", "Selected expense not found")
            self.controller.show_edit_frame()
            return

        confirm = messagebox.askyesno("Confirm Deletion", "Are you sure you want to delete this expense?")
        if not confirm:
            return

        self.controller.data.pop(selected_index)
        self.controller.save_data()
        messagebox.showinfo("Deleted", "Expense has been successfully deleted")
        self.controller.show_edit_frame()

class SearchFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        self.controller = controller
        self.label = ctk.CTkLabel(self, text="Search")
        self.label.pack(pady=10, padx=10)

        self.category_label = ctk.CTkLabel(self, text="Category:")
        self.category_label.pack(pady=5, padx=10)
        self.category_listbox = tk.Listbox(self, selectmode=tk.MULTIPLE)
        for category in self.controller.categories:
            self.category_listbox.insert(tk.END, category)
        self.category_listbox.pack(pady=5, padx=10)

        self.term_label = ctk.CTkLabel(self, text="Search Term:")
        self.term_label.pack(pady=5, padx=10)
        self.term_entry = ctk.CTkEntry(self)
        self.term_entry.pack(pady=5, padx=10)

        self.date_from_label = ctk.CTkLabel(self, text="From Date:")
        self.date_from_label.pack(pady=5, padx=10)
        self.date_from_entry = DateEntry(self, date_pattern='yyyy-mm-dd')
        self.date_from_entry.pack(pady=5, padx=10)

        self.date_to_label = ctk.CTkLabel(self, text="To Date:")
        self.date_to_label.pack(pady=5, padx=10)
        self.date_to_entry = DateEntry(self, date_pattern='yyyy-mm-dd')
        self.date_to_entry.pack(pady=5, padx=10)

        self.search_button = ctk.CTkButton(self, text="Search", command=self.search_expenses)
        self.search_button.pack(pady=10, padx=10)

        self.total_button = ctk.CTkButton(self, text="Calculate Total", command=self.calculate_total)
        self.total_button.pack(pady=10, padx=10)

        self.results_listbox = tk.Listbox(self)
        self.results_listbox.pack(fill="both", expand=True, pady=10, padx=10)

    def search_expenses(self):
        selected_categories = [self.category_listbox.get(i) for i in self.category_listbox.curselection()]
        search_term = self.term_entry.get().lower()
        self.results_listbox.delete(0, tk.END)
        if not selected_categories and not search_term:
            self.results_listbox.insert(tk.END, "Please select a category or enter a search term")
            return
        elif not self.controller.data:
            self.results_listbox.insert(tk.END, "No expenses found")
            return
        for index, expense in enumerate(self.controller.data, start=1):
            if (not selected_categories or expense.get("category") in selected_categories) and \
               (not search_term or search_term in expense.get("description", "").lower()):
                self.results_listbox.insert(tk.END, f"{index}. {expense['description']} - €{expense['amount']} (Date: {expense['date']})")

    def calculate_total(self):
        date_from = self.date_from_entry.get_date()
        date_to = self.date_to_entry.get_date()
        total = 0
        for expense in self.controller.data:
            expense_date = datetime.strptime(expense.get("date"), "%Y-%m-%d").date()
            if date_from <= expense_date <= date_to:
                total += expense.get("amount", 0)
        self.results_listbox.delete(0, tk.END)
        self.results_listbox.insert(tk.END, f"Total expenses between {date_from} and {date_to}: €{total}")

class ExportFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        self.controller = controller
        self.label = ctk.CTkLabel(self, text="Export Data")
        self.label.pack(pady=10, padx=10)

        self.start_date_label = ctk.CTkLabel(self, text="Start Date:")
        self.start_date_label.pack(pady=5, padx=10)
        self.start_date_entry = DateEntry(self, date_pattern='yyyy-mm-dd')
        self.start_date_entry.pack(pady=5, padx=10)

        self.end_date_label = ctk.CTkLabel(self, text="End Date:")
        self.end_date_label.pack(pady=5, padx=10)
        self.end_date_entry = DateEntry(self, date_pattern='yyyy-mm-dd')
        self.end_date_entry.pack(pady=5, padx=10)

        self.export_button = ctk.CTkButton(self, text="Export to TXT", command=self.export_to_txt)
        self.export_button.pack(pady=10, padx=10)

        self.export_label = ctk.CTkLabel(self, text="")
        self.export_label.pack(pady=10, padx=10)

    def export_to_txt(self):
        if not self.controller.data:
            messagebox.showerror("No data", "No expenses found to export")
            return

        start_date = self.start_date_entry.get_date()
        end_date = self.end_date_entry.get_date()

        if start_date > end_date:
            messagebox.showerror("Invalid date range", "Start date must be before end date")
            return

        filtered_expenses = [
            expense for expense in self.controller.data
            if start_date <= datetime.strptime(expense["date"], "%Y-%m-%d").date() <= end_date
        ]

        if not filtered_expenses:
            messagebox.showinfo("No data", "No expenses found in the selected date range")
            return

        filename = f"expenses_{start_date.strftime('%Y%m%d')}_to_{end_date.strftime('%Y%m%d')}.txt"
        with open(filename, mode="w") as file:
            for expense in filtered_expenses:
                file.write(f"Description: {expense['description']}, Amount: €{expense['amount']}, Date: {expense['date']}, Category: {expense['category']}\n")

        self.export_label.configure(text=f"Data exported to {filename}")

class CategoriesFrame(ctk.CTkFrame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        self.controller = controller
        self.label = ctk.CTkLabel(self, text="Manage Categories")
        self.label.pack(pady=10, padx=10)

        self.category_listbox = tk.Listbox(self)
        self.category_listbox.pack(fill="both", expand=True, pady=10, padx=10)
        self.load_categories()

        self.new_category_label = ctk.CTkLabel(self, text="New Category:")
        self.new_category_label.pack(pady=5)
        self.new_category_entry = ctk.CTkEntry(self)
        self.new_category_entry.pack(pady=5)

        self.add_category_button = ctk.CTkButton(self, text="Add Category", command=self.add_category)
        self.add_category_button.pack(pady=10)

        self.delete_category_button = ctk.CTkButton(self, text="Delete Category", command=self.delete_category)
        self.delete_category_button.pack(pady=10)

    def load_categories(self):
        self.category_listbox.delete(0, tk.END)
        for category in self.controller.categories:
            self.category_listbox.insert(tk.END, category)

    def add_category(self):
        new_category = self.new_category_entry.get()
        if new_category and new_category not in self.controller.categories:
            self.controller.categories.append(new_category)
            self.controller.save_data()
            self.load_categories()
            self.new_category_entry.delete(0, tk.END)
        else:
            messagebox.showerror("Invalid input", "Category already exists or is empty")

    def delete_category(self):
        selected_category = self.category_listbox.get(tk.ACTIVE)
        if selected_category:
            self.controller.categories.remove(selected_category)
            self.controller.save_data()
            self.load_categories()
        else:
            messagebox.showerror("No selection", "Please select a category to delete")

if __name__ == "__main__":
    app = App()
    app.mainloop()
