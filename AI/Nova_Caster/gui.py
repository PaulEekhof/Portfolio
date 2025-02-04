import pandas as pd
import numpy as np
import logging
from rules import RULES
import tkinter as tk
from tkinter import ttk
from tkinter import filedialog
from tkinter import messagebox
from predictor import PredictNextNumber


class ModernDarkTheme:
    BG_COLOR = "#2b2b2b"
    FG_COLOR = "#ffffff"
    ACCENT_COLOR = "#3d7aab"
    HOVER_COLOR = "#4d8abf"
    BUTTON_BG = "#3d7aab"
    ENTRY_BG = "#363636"
    ERROR_COLOR = "#ff5555"

    @classmethod
    def apply_theme(cls, root):
        style = ttk.Style()
        style.theme_use('clam')

        # Configure colors
        style.configure('.',
            background=cls.BG_COLOR,
            foreground=cls.FG_COLOR,
            fieldbackground=cls.ENTRY_BG)
        
        # Button style
        style.configure('Custom.TButton',
            background=cls.BUTTON_BG,
            foreground=cls.FG_COLOR,
            padding=10,
            font=('Segoe UI', 10))
        
        style.map('Custom.TButton',
            background=[('active', cls.HOVER_COLOR)],
            foreground=[('active', cls.FG_COLOR)])

        # Combobox style
        style.configure('Custom.TCombobox',
            background=cls.ENTRY_BG,
            foreground=cls.FG_COLOR,
            fieldbackground=cls.ENTRY_BG,
            arrowcolor=cls.FG_COLOR)

        # Label style
        style.configure('Custom.TLabel',
            background=cls.BG_COLOR,
            foreground=cls.FG_COLOR,
            font=('Segoe UI', 10))

        # Frame style
        style.configure('Custom.TFrame',
            background=cls.BG_COLOR)

class PredictionApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Nova Caster")
        self.root.geometry("600x500")
        self.root.configure(bg=ModernDarkTheme.BG_COLOR)
        
        ModernDarkTheme.apply_theme(root)
        
        self.csv_file_path = ""
        self.gguf_model_path = ""
        self.predictor = None
        self.column_var = tk.StringVar()
        self.df = None  # Add this line to store the DataFrame
        
        self.create_widgets()

    def create_widgets(self):
        # Main container
        main_frame = ttk.Frame(self.root, style='Custom.TFrame')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # File selection section
        file_frame = ttk.Frame(main_frame, style='Custom.TFrame')
        file_frame.pack(fill=tk.X, pady=10)

        # CSV File selection
        csv_container = ttk.Frame(file_frame, style='Custom.TFrame')
        csv_container.pack(fill=tk.X, pady=5)
        
        ttk.Label(csv_container, text="CSV File:", style='Custom.TLabel').pack(side=tk.LEFT, padx=5)
        self.csv_path_label = ttk.Label(csv_container, text="No file selected", style='Custom.TLabel')
        self.csv_path_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
        self.csv_button = ttk.Button(csv_container, text="Browse", style='Custom.TButton', command=self.upload_csv)
        self.csv_button.pack(side=tk.RIGHT, padx=5)

        # GGUF Model selection
        model_container = ttk.Frame(file_frame, style='Custom.TFrame')
        model_container.pack(fill=tk.X, pady=5)
        
        ttk.Label(model_container, text="Model:", style='Custom.TLabel').pack(side=tk.LEFT, padx=5)
        self.model_path_label = ttk.Label(model_container, text="No model selected", style='Custom.TLabel')
        self.model_path_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
        self.model_button = ttk.Button(model_container, text="Browse", style='Custom.TButton', command=self.upload_gguf_model)
        self.model_button.pack(side=tk.RIGHT, padx=5)

        # Column selection
        column_frame = ttk.Frame(main_frame, style='Custom.TFrame')
        column_frame.pack(fill=tk.X, pady=10)
        
        ttk.Label(column_frame, text="Select Column:", style='Custom.TLabel').pack(side=tk.LEFT, padx=5)
        self.column_combo = ttk.Combobox(column_frame, textvariable=self.column_var, style='Custom.TCombobox')
        self.column_combo.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        # Prediction section
        prediction_frame = ttk.Frame(main_frame, style='Custom.TFrame')
        prediction_frame.pack(fill=tk.X, pady=20)
        
        self.predict_button = ttk.Button(prediction_frame, text="Predict Next Number", 
                                       style='Custom.TButton', command=self.predict)
        self.predict_button.pack(pady=10)

        self.result_label = ttk.Label(prediction_frame, text="Prediction Result: ", 
                                    style='Custom.TLabel', font=('Segoe UI', 12, 'bold'))
        self.result_label.pack(pady=10)

    def upload_csv(self):
        file_path = filedialog.askopenfilename(filetypes=[("CSV Files", "*.csv")])
        if file_path:
            try:
                self.df = pd.read_csv(file_path)
                self.csv_file_path = file_path
                self.csv_path_label.config(text=file_path.split('/')[-1])
                self.update_column_menu_csv()  # New method call
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load CSV file: {str(e)}")

    def update_column_menu_csv(self):
        """Update column menu when CSV is loaded, before model initialization"""
        if self.df is not None:
            columns = self.df.columns.tolist()
            self.column_combo['values'] = columns
            self.column_var.set(columns[0] if columns else '')

    def upload_gguf_model(self):
        file_path = filedialog.askopenfilename(filetypes=[("GGUF Files", "*.gguf")])
        if file_path:
            self.gguf_model_path = file_path
            self.model_path_label.config(text=file_path.split('/')[-1])
            self.update_column_menu()

    def update_column_menu(self):
        """Original method now only initializes the predictor if both files are ready"""
        if self.csv_file_path and self.gguf_model_path:
            try:
                self.predictor = PredictNextNumber(self.csv_file_path, self.gguf_model_path)
            except Exception as e:
                messagebox.showerror("Error", str(e))

    def predict(self):
        if not self.csv_file_path:
            messagebox.showerror("Error", "Please select a CSV file first")
            return
        if not self.gguf_model_path:
            messagebox.showerror("Error", "Please select a GGUF model first")
            return
        if not self.predictor:
            try:
                self.predictor = PredictNextNumber(self.csv_file_path, self.gguf_model_path)
            except Exception as e:
                messagebox.showerror("Error", str(e))
                return
            
        try:
            column_name = self.column_var.get()
            self.predictor.select_column(column_name)
            prediction = self.predictor.predict_next_value()
            self.result_label.config(text=f"Prediction Result: {prediction}")
        except Exception as e:
            messagebox.showerror("Error", str(e))

if __name__ == "__main__":
    root = tk.Tk()
    app = PredictionApp(root)
    root.mainloop()