import zipfile

class OpenCustomModel:
    def __init__(self, model_path):
        self.model_path = model_path

    def open_package(self, package_path, key):
        # Implement the logic to open the package using the provided key
        # This is a placeholder implementation
        files = []
        try:
            with open(package_path, 'rb') as package_file:
                # Simulate opening the package and extracting files
                # In a real implementation, you would decrypt and extract files here
                files.append({
                    'path': package_path,  # Add the path key
                    'name': 'example.txt',
                    'type': 'text/plain',
                    'content': package_file.read().decode('utf-8')
                })
        except Exception as e:
            print(f"Error opening package: {e}")
            return None
        return files

    def load_model(self):
        print(f"Loading model from {self.model_path}")
        # Load model from path
        return "Model loaded successfully"

    def predict(self, key_path):
        print(f"Predicting with key {key_path}")
        try:
            with open(key_path, 'r') as key_file:
                key = key_file.read()
            with zipfile.ZipFile(self.model_path, 'r') as package:
                package.extractall(pwd=key.encode())
            return f"Package opened successfully with key: {key}"
        except Exception as e:
            return f"Error opening package: {e}"

    def list_files(self, key_path):
        print(f"Listing files with key {key_path}")
        try:
            with open(key_path, 'r') as key_file:
                key = key_file.read()
            with zipfile.ZipFile(self.model_path, 'r') as package:
                package.setpassword(key.encode())
                return package.namelist()
        except Exception as e:
            return f"Error listing files: {e}"

    def get_file_content(self, file_name, key_path):
        print(f"Getting content of file {file_name} with key {key_path}")
        try:
            with open(key_path, 'r') as key_file:
                key = key_file.read()
            with zipfile.ZipFile(self.model_path, 'r') as package:
                package.setpassword(key.encode())
                with package.open(file_name) as file:
                    return file.read().decode('utf-8')
        except Exception as e:
            return f"Error getting file content: {e}"