import sys
from PyQt6.QtWidgets import (
    QApplication, QWidget, QLabel, QVBoxLayout, QPushButton, QTextEdit, QDateEdit, 
    QMessageBox, QSpinBox, QHBoxLayout
)
from PyQt6.QtCore import Qt, QDate

### Calculate Rapture Age based on birthdate
### Rapture Age is defined as the number of times the rapture was predicted since the person's birth year up to the current year.
### This version uses PyQt6 for a graphical user interface to create a user-friendly experience on Windows desktop.

RAPTURE_YEARS = [
    1843, 1844, 1874, 1878, 1881, 1910, 1914, 1918, 1925, 1975, 1975,
    1981, 1981, 1982, 1988, 1988, 1989, 1992, 1993, 1994, 1994, 1995,
    2000, 2000, 2001, 2007, 2011, 2011, 2012, 2014, 2015, 2017, 2020, 2021, 2025
]

class RaptureAgeCalculatorApp(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Rapture Age Calculator")
        self.setFixedSize(600, 420)
        self.setStyleSheet("""
            QWidget {
                background-color: #1e1e2f;
                color: #f0f0f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            QLabel#headerLabel {
                font-size: 24px;
                font-weight: 700;
                color: #ff6f61;
            }
            QDateEdit, QSpinBox {
                font-size: 16px;
                padding: 5px;
                border: 2px solid #ff6f61;
                border-radius: 8px;
                background-color: #2a2a40;
                color: #fffff5;
            }
            QPushButton {
                font-size: 18px;
                font-weight: 600;
                color: #fffff5;
                background-color: #ff6f61;
                border-radius: 10px;
                padding: 10px;
            }
            QPushButton:hover {
                background-color: #e55a4d;
            }
            QTextEdit {
                background-color: #2a2a40;
                border: none;
                font-size: 14px;
                padding: 10px;
                color: #f0f0f5;
                border-radius: 8px;
            }
        """)

        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(40, 30, 40, 30)
        main_layout.setSpacing(20)

        self.header = QLabel("Rapture Age Calculator")
        self.header.setObjectName("headerLabel")
        self.header.setAlignment(Qt.AlignmentFlag.AlignCenter)

        birthdate_layout = QHBoxLayout()
        birthdate_label = QLabel("Select your birthdate:")
        birthdate_label.setFixedWidth(150)
        self.date_picker = QDateEdit(calendarPopup=True)
        self.date_picker.setDate(QDate(1983, 7, 16))
        self.date_picker.setDisplayFormat("yyyy-MM-dd")
        self.date_picker.setAlignment(Qt.AlignmentFlag.AlignCenter)
        birthdate_layout.addWidget(birthdate_label)
        birthdate_layout.addWidget(self.date_picker)

        current_year_layout = QHBoxLayout()
        current_year_label = QLabel("Enter current year:")
        current_year_label.setFixedWidth(150)
        self.current_year_spin = QSpinBox()
        self.current_year_spin.setRange(1843, 2100)
        self.current_year_spin.setValue(2025)
        self.current_year_spin.setAlignment(Qt.AlignmentFlag.AlignCenter)

        # Apply improved arrow styling on the spin box AFTER creation
        self.current_year_spin.setStyleSheet("""
            QSpinBox {
                font-size: 16px;
                padding: 5px;
                border: 2px solid #ff6f61;
                border-radius: 8px;
                background-color: #2a2a40;
                color: #f0f0f5;
                min-width: 100px;
            }
            QSpinBox::up-button {
                subcontrol-origin: border;
                subcontrol-position: top right;
                width: 18px;
                border-left: 1px solid #ff6f61;
                background-color: #ff6f61;
                image: none;
                border-top-right-radius: 8px;
            }
            QSpinBox::up-arrow {
                width: 10px;
                height: 10px;
                border: solid white;
                border-width: 0 3px 3px 0;
                display: inline-block;
                padding: 3px;
                transform: rotate(-45deg);
                margin: 3px auto;
            }
            QSpinBox::up-button:hover {
                background-color: #e55a4d;
            }
            QSpinBox::down-button {
                subcontrol-origin: border;
                subcontrol-position: bottom right;
                width: 18px;
                border-left: 1px solid #ff6f61;
                background-color: #ff6f61;
                border-bottom-right-radius: 8px;
            }
            QSpinBox::down-arrow {
                width: 10px;
                height: 10px;
                border: solid white;
                border-width: 3px 3px 0 0;
                display: inline-block;
                padding: 3px;
                transform: rotate(45deg);
                margin: 3px auto;
            }
            QSpinBox::down-button:hover {
                background-color: #e55a4d;
            }
        """)

        current_year_layout.addWidget(current_year_label)
        current_year_layout.addWidget(self.current_year_spin)

        self.button_calc = QPushButton("Calculate Rapture Age")
        self.button_calc.clicked.connect(self.calculate_rapture_age)

        self.text_output = QTextEdit()
        self.text_output.setReadOnly(True)
        self.text_output.setPlaceholderText("Your Rapture Age result will appear here...")

        main_layout.addWidget(self.header)
        main_layout.addLayout(birthdate_layout)
        main_layout.addLayout(current_year_layout)
        main_layout.addWidget(self.button_calc)
        main_layout.addWidget(self.text_output)

        self.setLayout(main_layout)

    def calculate_rapture_age(self):
        birthdate_qdate = self.date_picker.date()
        birth_year = birthdate_qdate.year()
        current_year = self.current_year_spin.value()

        if current_year < birth_year:
            QMessageBox.warning(self, "Input Error", "Current year cannot be earlier than birth year.")
            return

        missed = [year for year in RAPTURE_YEARS if birth_year <= year < current_year]
        rapture_age = len(missed)

        if missed:
            missed_str = ", ".join(map(str, missed))
        else:
            missed_str = "None! Lucky you!"

        result_text = (f"🎉 You are '{rapture_age}' years old in Rapture Years!\n\n"
                       f"You missed the following rapture predictions:\n{missed_str}")

        self.text_output.setText(result_text)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = RaptureAgeCalculatorApp()
    window.show()
    sys.exit(app.exec())
