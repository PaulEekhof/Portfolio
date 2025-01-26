import json
import os

# Constants
JSON_FILE = 'save.json'

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

# Create a new item
def create_item(data):
    item = {
        'id': generate_id(data),
        'name': input_str("Enter item name: "),
        'quantity': input_int("Enter item quantity: ")
    }
    data.append(item)
    save_data(data)
    print("Item created successfully!")

# Read all items
def read_items(data):
    if not data:
        print("No items found.")
    else:
        print("\n--- Items ---")
        for item in data:
            print(f"ID: {item['id']}, Name: {item['name']}, Quantity: {item['quantity']}")
        print("-------------")

# Update an existing item
def update_item(data):
    item_id = input_int("Enter item ID to update: ")
    for item in data:
        if item['id'] == item_id:
            item['name'] = input_str("Enter new item name: ")
            item['quantity'] = input_int("Enter new item quantity: ")
            save_data(data)
            print("Item updated successfully!")
            return
    print("Item not found.")

# Delete an item
def delete_item(data):
    item_id = input_int("Enter item ID to delete: ")
    for item in data:
        if item['id'] == item_id:
            data.remove(item)
            save_data(data)
            print("Item deleted successfully!")
            return
    print("Item not found.")

# Search for an item by ID or name
def search_item(data):
    search_term = input_str("Enter item ID or name to search: ")
    try:
        search_id = int(search_term)
        for item in data:
            if item['id'] == search_id:
                print(f"ID: {item['id']}, Name: {item['name']}, Quantity: {item['quantity']}")
                return
    except ValueError:
        pass  # Not an ID, search by name

    results = [item for item in data if search_term.lower() in item['name'].lower()]
    if results:
        print("\n--- Search Results ---")
        for item in results:
            print(f"ID: {item['id']}, Name: {item['name']}, Quantity: {item['quantity']}")
    else:
        print("No matching items found.")

# Main menu
def main_menu():
    data = load_data()
    while True:
        print("\n--- CRUD Menu ---")
        print("1. Create Item")
        print("2. Read Items")
        print("3. Update Item")
        print("4. Delete Item")
        print("5. Search Item")
        print("6. Exit")
        choice = input("Enter your choice: ").strip()

        if choice == '1':
            create_item(data)
        elif choice == '2':
            read_items(data)
        elif choice == '3':
            update_item(data)
        elif choice == '4':
            delete_item(data)
        elif choice == '5':
            search_item(data)
        elif choice == '6':
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")

# Run the program
if __name__ == "__main__":
    main_menu()