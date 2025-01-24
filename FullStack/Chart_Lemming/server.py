import os
from flask import Flask, request, jsonify, render_template
from werkzeug.utils import secure_filename
import pandas as pd
from models.file_converter import FileConverter


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'

# Ensure the uploads directory exists
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])

@app.route('/')
def index():
    return render_template('chart.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'})
    if file:
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        
        # Convert the file if necessary
        if file_path.endswith('.txt'):
            try:
                converter = FileConverter(file_path, file_path.replace('.txt', '.csv'))
                converter.txt_to_csv()
                file_path = file_path.replace('.txt', '.csv')
            except Exception as e:
                return jsonify({'error': f"File conversion failed: {str(e)}"})
        
        chart_type = request.form['chartType']
        
        # Load the dataset and get column names
        data = pd.read_csv(file_path)
        columns = data.columns.tolist()
        print(f"Dataset columns: {columns}")  # Debug: Print column names
        
        if len(columns) < 2:
            return jsonify({'error': "Dataset must contain at least two columns"})
        
        chart_params = columns[:2]  # Use the first two columns for the chart
        
        # Check if the expected columns are present
        missing_columns = [param for param in chart_params if param not in data.columns]
        if missing_columns:
            return jsonify({'error': f"Dataset does not contain the required columns: {missing_columns}"})
        
        # Import the necessary modules here to avoid circular import
        from models.chart_creator import ChartCreator
        from models.explenation_creator import ChartExplanation
        from models.predictor_model import NextSentencePredictor
        
        # Generate chart
        try:
            chart_creator = ChartCreator(
                dataset_path=file_path,
                chart_type=chart_type,
                chart_params=chart_params
            )
            chart_creator.generate_chart()
            chart_creator.save_chart('static/lemming_chart.png')
        except Exception as e:
            return jsonify({'error': f"Chart generation failed: {str(e)}"})

        # Generate explanation
        try:
            chart_explanation = ChartExplanation(
                dataset_path=file_path,
                chart_type=chart_type,
                chart_params=chart_params
            )
            explanation = chart_explanation.generate_explanation()
        except Exception as e:
            return jsonify({'error': f"Explanation generation failed: {str(e)}"})

        # Predict the next sentence for the explanation
        try:
            predictor = NextSentencePredictor(model_path='custom_models/test_custom_model')
            predicted_explanation = predictor.predict_next_sentence(explanation)
        except Exception as e:
            return jsonify({'error': f"Prediction failed: {str(e)}"})
        
        return jsonify({
            'message': 'Chart updated successfully',
            'newData': chart_creator.data[chart_params[1]].tolist(),
            'newLabels': chart_creator.data[chart_params[0]].tolist(),
            'explanation': predicted_explanation
        })

if __name__ == '__main__':
    app.run(debug=True)
