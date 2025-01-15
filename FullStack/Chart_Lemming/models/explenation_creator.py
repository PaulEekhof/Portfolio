import pandas as pd

class ChartExplanation:
    def __init__(self, dataset_path, chart_type, chart_params):
        """
        Initialize the ChartExplanation with the dataset path, chart type, and chart parameters.

        :param dataset_path: Path to the dataset file.
        :param chart_type: Type of the chart (e.g., 'Line', 'Bar', 'Pie', 'Scatter', 'Histogram').
        :param chart_params: Parameters for the chart (e.g., ['Month', 'Value']).
        """
        self.dataset_path = dataset_path
        self.chart_type = chart_type
        self.chart_params = chart_params
        self.data = pd.read_csv(dataset_path)

    def generate_explanation(self):
        """
        Generate an explanation for the chart based on the dataset and chart type.

        :return: A string explanation for the chart.
        """
        explanation = f"This is a {self.chart_type} chart showing the relationship between {self.chart_params[0]} and {self.chart_params[1]}."
        return explanation
