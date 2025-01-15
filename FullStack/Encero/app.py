from flask import Flask, request, render_template, send_file, flash, redirect
import os
from models.pack_model import PackModel
from models.open_custom_model import OpenCustomModel

app = Flask(__name__, static_folder='static')
app.secret_key = 'supersecretkey'
UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload')
def upload_form():
    return render_template('upload.html')

@app.route('/open_view', methods=['GET', 'POST'])
def open_view_form():
    if request.method == 'POST':
        package = request.files['package']
        key = request.form['key']
        display_option = request.form['display_option']

        if not package or not key:
            flash('Package and key are required.')
            return redirect('/open_view')

        package_path = os.path.join(UPLOAD_FOLDER, package.filename)
        package.save(package_path)

        model_path = 'models/open_custom_model.py'  # Update this to the correct path
        open_model = OpenCustomModel(model_path)
        files = open_model.open_package(package_path, key)

        if not files:
            flash('Failed to open package. Invalid key or package.')
            return redirect('/open_view')

        if display_option == 'content':
            for file in files:
                with open(file['path'], 'rb') as f:
                    file['content'] = f.read().decode('utf-8', errors='ignore')
        elif display_option == 'snippet':
            for file in files:
                with open(file['path'], 'rb') as f:
                    file['snippet'] = f.read(200).decode('utf-8', errors='ignore')  # Read the first 200 characters as a snippet

        return render_template('open_view.html', files=files, display_option=display_option)

    return render_template('open_view.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    files = request.files.getlist('file')
    extension = request.form['extension']
    key = request.form['key']
    file_paths = []

    if not extension or not key:
        flash('Extension name and key are required.')
        return redirect('/upload')

    for file in files:
        if file.filename != '':
            file_path = os.path.join(UPLOAD_FOLDER, file.filename)
            file.save(file_path)
            file_paths.append(file_path)

    if not file_paths:
        flash('No files uploaded.')
        return redirect('/upload')

    pack_model = PackModel()
    package_path = pack_model.pack_files(file_paths, extension, key)  # Pass the key to the method

    flash('Files packaged successfully.')
    return send_file(package_path, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)