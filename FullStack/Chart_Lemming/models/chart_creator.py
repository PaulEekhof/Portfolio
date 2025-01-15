import matplotlib.pyplot as plt
import pandas as pd
import os
from io import BytesIO
import base64

# Use the Agg backend for Matplotlib to avoid GUI issues
import matplotlib
matplotlib.use('Agg')

class ChartCreator:
    def __init__(self, dataset_path, chart_type, chart_params):
        """
        Initialize a ChartCreator with a dataset, chart type, and chart parameters.

        :param dataset_path: Path to the dataset (csv, txt, xml).
        :param chart_type: Type of the chart ('Line', 'Bar', 'Scatter', 'Histogram', 'Pie').
        :param chart_params: Parameters specific to the chart type.
        """
        self.dataset_path = dataset_path
        self.chart_type = chart_type
        self.chart_params = chart_params
        self.data = self.load_data()

    def load_data(self):
        """Load the dataset based on the file extension."""
        ext = os.path.splitext(self.dataset_path)[1]
        if ext == '.csv':
            return pd.read_csv(self.dataset_path)
        elif ext == '.txt':
            return pd.read_csv(self.dataset_path, delimiter='\t')
        elif ext == '.xml':
            return pd.read_xml(self.dataset_path)
        else:
            raise ValueError(f"Unsupported file format: {ext}")

    def process_data(self):
        """Process the data based on the chart type."""
        data = self.data
        if self.chart_type == 'Line':
            x, y = self.chart_params
            return data[x], data[y]
        elif self.chart_type == 'Bar':
            keys, values = self.chart_params
            return data[keys], data[values]
        elif self.chart_type == 'Scatter':
            x, y = self.chart_params
            return data[x], data[y]
        elif self.chart_type == 'Histogram':
            column = self.chart_params[0]
            return data[column]
        elif self.chart_type == 'Pie':
            keys, values = self.chart_params
            return data[keys], data[values]
        else:
            raise ValueError(f"Unsupported chart type: {self.chart_type}")

    def generate_chart(self):
        """Generate a matplotlib chart based on the chart type."""
        data = self.data

        if self.chart_type == 'Line':
            x, y = self.chart_params
            plt.plot(data[x], data[y], label="Trend")
            plt.title("Line Plot")
            plt.xlabel("X-axis")
            plt.ylabel("Y-axis")
            plt.legend()
        
        elif self.chart_type == 'Bar':
            keys, values = self.chart_params
            plt.bar(data[keys], data[values], color='skyblue')
            plt.title("Bar Chart")
            plt.xlabel("Categories")
            plt.ylabel("Values")
        
        elif self.chart_type == 'Scatter':
            x, y = self.chart_params
            plt.scatter(data[x], data[y], color='purple', s=50, alpha=0.7)
            plt.title("Scatter Plot")
            plt.xlabel("X-axis")
            plt.ylabel("Y-axis")
        
        elif self.chart_type == 'Histogram':
            column = self.chart_params[0]
            plt.hist(data[column], bins=10, color='orange', edgecolor='black', alpha=0.8)
            plt.title("Histogram")
            plt.xlabel("Bins")
            plt.ylabel("Frequency")
        
        elif self.chart_type == 'Pie':
            keys, values = self.chart_params
            plt.pie(data[values], labels=data[keys], autopct='%1.1f%%', startangle=140)
            plt.title("Pie Chart")
        
        else:
            raise ValueError(f"Unsupported chart type: {self.chart_type}")

        # Return the chart as an image in memory
        buffer = BytesIO()
        plt.savefig(buffer, format='png')
        plt.close()
        buffer.seek(0)
        return buffer

    def save_chart(self, path):
        """Save the chart to a file."""
        chart_buffer = self.generate_chart()
        with open(path, 'wb') as f:
            f.write(chart_buffer.read())
        chart_buffer.close()

    def render_html(self):
        """
        Generate the chart and return an HTML string for embedding it.

        :return: HTML string containing the base64-encoded chart image.
        """
        chart_buffer = self.generate_chart()
        base64_image = base64.b64encode(chart_buffer.read()).decode('utf-8')
        chart_buffer.close()

        return f'<img src="data:image/png;base64,{base64_image}" alt="Lemming Chart" style="max-width:100%; height:auto;">'

# Example Usage
if __name__ == "__main__":
    # Example dataset in CSV format
    csv_path = 'datasets/medium_datasets.csv'  # Replace with the actual dataset path

    # Create a ChartCreator for a histogram chart
    chart_creator = ChartCreator(
        dataset_path=csv_path,
        chart_type='Histogram',
        chart_params=['Value']  # Replace 'Value' with the actual column name
    )

    # Generate and render the chart as HTML
    html_snippet = chart_creator.render_html()

    # Print the HTML snippet (use this in your web app)
    print(html_snippet)
