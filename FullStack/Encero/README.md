# Encero File Upload and Packaging

This simple application allows users to upload multiple files, specify a custom extension for the package, and download the package along with a key to open it. It also gives the user the ability to open a custom file with a key.

## Features

- Upload multiple files
- Specify a custom extension for the package
- Download the packaged files
- Download the key to open the package
- Upload the custom packaged file
- Upload the key
- Display the files included in the package

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/Encero.git
    cd Encero
    ```

2. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

3. Run the application:
    ```bash
    python app.py
    ```

## Usage

1. Open your web browser and go to `http://127.0.0.1:5000/`.
2. Upload the files you want to package.
3. Enter the desired extension name for the package.
4. Enter a key to secure the package.
5. Click the "Upload" button to create and download the package.
6. Download the key from the provided link.
7. To open the package, use the following command:
    ```bash
    python -c "from models.open_custom_model import OpenCustomModel; model = OpenCustomModel('package.customext'); model.load_model(); print(model.predict('key.txt'))"
    ```
8. To view the package contents, go to the "View Package" page, upload the package file and key, and choose whether to display the file names and types or the file names, types, and content.

## API Endpoints

### `GET /`
Renders the home page.

### `GET /upload`
Renders the upload form.

### `POST /upload`
Handles file uploads, packages them, and returns the packaged file for download.

### `GET /open_view`
Renders the form to open and view a package.

### `POST /open_view`
Handles the package opening and displays the contents based on the selected display option.

## Directory Structure

```
Encero/
├── app.py
├── LICENSE
├── models/
│   ├── __init__.py
│   ├── open_custom_model.py
│   ├── open_package_model.py
│   └── pack_model.py
├── README.md
├── requirements.txt
├── static/
│   ├── assets/
│   │   └── images/
│   ├── css/
│   │   └── style.css
├── templates/
│   ├── header.html
│   ├── index.html
│   ├── open_view.html
│   ├── open.html
│   └── upload.html
└── uploads/
```

## Models

### `PackModel`
Located in [models/pack_model.py](models/pack_model.py)

- `set_pack(pack)`: Sets the pack.
- `get_pack()`: Gets the pack.
- `pack_files(file_paths, extension, key)`: Packages the files using the provided key and extension.
- `generate_key(key)`: Generates a key file.

### `OpenCustomModel`
Located in [models/open_custom_model.py](models/open_custom_model.py)

- `__init__(self, model_path)`: Initializes the model with the given path.
- `open_package(self, package_path, key)`: Opens the package using the provided key.
- `load_model(self)`: Loads the model from the path.
- `predict(self, key_path)`: Predicts using the key.
- `list_files(self, key_path)`: Lists files in the package.
- `get_file_content(self, file_name, key_path)`: Gets the content of a file in the package.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
