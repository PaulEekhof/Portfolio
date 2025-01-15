# import matplotlib
# matplotlib.use('Agg')  # Use the Agg backend for rendering charts

# import matplotlib.pyplot as plt
# import pandas as pd
# import os

# class LemmingObject:
#     def __init__(self, dataset_path, chart_type, chart_params):
#         """
#         Initialize a LemmingObject with a dataset, chart type, and chart parameters.
        
#         :param dataset_path: Path to the dataset (csv, txt, xml).
#         :param chart_type: Type of the chart ('Line', 'Bar', 'Scatter', 'Histogram', 'Pie').
#         :param chart_params: Parameters specific to the chart type.
#         """
#         self.dataset_path = dataset_path
#         self.chart_type = chart_type
#         self.chart_params = chart_params
#         self.data = self.load_data()

#     def load_data(self):
#         """Load the dataset based on the file extension."""
#         ext = os.path.splitext(self.dataset_path)[1]
#         if ext == '.csv':
#             return pd.read_csv(self.dataset_path)
#         elif ext == '.txt':
#             return pd.read_csv(self.dataset_path, delimiter='\t')
#         elif ext == '.xml':
#             return pd.read_xml(self.dataset_path)
#         else:
#             raise ValueError(f"Unsupported file format: {ext}")

#     def get_data(self):
#         """Return the loaded data."""
#         return self.data


# class LemmingChart:
#     def __init__(self, lemming_object):
#         """
#         Initialize a LemmingChart with a LemmingObject.
        
#         :param lemming_object: An instance of LemmingObject.
#         """
#         self.lemming_object = lemming_object
#         self.chart_type = lemming_object.chart_type
#         self.chart_params = lemming_object.chart_params

#     def generate_chart(self):
#         """Generate a matplotlib chart based on the chart type."""
#         data = self.lemming_object.get_data()

#         if self.chart_type == 'Line':
#             x, y = self.chart_params
#             plt.plot(data[x], data[y], label="Trend")
#             plt.title("Line Plot")
#             plt.xlabel("X-axis")
#             plt.ylabel("Y-axis")
#             plt.legend()
        
#         elif self.chart_type == 'Bar':
#             keys, values = self.chart_params
#             plt.bar(data[keys], data[values], color='skyblue')
#             plt.title("Bar Chart")
#             plt.xlabel("Categories")
#             plt.ylabel("Values")
        
#         elif self.chart_type == 'Scatter':
#             x, y = self.chart_params
#             plt.scatter(data[x], data[y], color='purple')
#             plt.title("Scatter Plot")
#             plt.xlabel("X-axis")
#             plt.ylabel("Y-axis")
        
#         elif self.chart_type == 'Histogram':
#             column = self.chart_params
#             plt.hist(data[column], bins=5, color='orange', edgecolor='black')
#             plt.title("Histogram")
#             plt.xlabel("Bins")
#             plt.ylabel("Frequency")
        
#         elif self.chart_type == 'Pie':
#             keys, values = self.chart_params
#             plt.pie(data[values], labels=data[keys], autopct='%1.1f%%', startangle=140)
#             plt.title("Pie Chart")
        
#         else:
#             raise ValueError(f"Unsupported chart type: {self.chart_type}")

#     def save_chart(self, output_path='static/lemming_chart.png'):
#         """
#         Save the generated chart to a file.
        
#         :param output_path: Path to save the chart image.
#         """
#         plt.savefig(output_path)
#         plt.close()

#     def render_html(self, output_path='static/lemming_chart.png'):
#         """
#         Generate and save the chart, then return an HTML snippet for displaying it.
        
#         :param output_path: Path to save the chart image.
#         :return: HTML string to embed the chart in chart.html.
        
#         """
#         self.generate_chart()
#         self.save_chart(output_path)
#         return f'<img src="{output_path}" alt="Lemming Chart" style="max-width:100%; height:auto;">'

#     def update_chart_data(self, new_data):
#         """
#         Update the chart data dynamically.
        
#         :param new_data: New data to update the chart with.
#         """
#         self.lemming_object.data = new_data
#         self.generate_chart()


# # Example Usage
# if __name__ == "__main__":
#     # Example dataset in CSV format
#     csv_path = 'datasets/medium_datasets.csv'  # Replace with the actual dataset path
    
#     # Create a LemmingObject for a line chart
#     lemming_object = LemmingObject(
#         dataset_path=csv_path,
#         chart_type='Line',
#         chart_params=['Month', 'Product_A']
#     )
    
#     # Create and render a LemmingChart
#     lemming_chart = LemmingChart(lemming_object)
#     html_snippet = lemming_chart.render_html()
    
#     print(html_snippet)  # Use this HTML in your web app
