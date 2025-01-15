import csv

class FileConverter():
    def __init__(self, input_file, output_file):
        self.input_file = input_file
        self.output_file = output_file

    def txt_to_csv(self):
        with open(self.input_file, 'r') as txt_file:
            lines = txt_file.readlines()

        with open(self.output_file, 'w', newline='') as csv_file:
            writer = csv.writer(csv_file)
            for line in lines:
                writer.writerow(line.strip().split())

# Example usage:
# converter = FileConverter('input.txt', 'output.csv')
# converter.txt_to_csv()