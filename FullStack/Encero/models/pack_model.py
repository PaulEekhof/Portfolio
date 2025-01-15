# This takes all the files uploaded by the user and packs it into 1 package file with a custom extension. It also creates a key to open the package with.

import zipfile
import os

class PackModel:
    def __init__(self):
        self.pack = None

    def set_pack(self, pack):
        self.pack = pack

    def get_pack(self):
        return self.pack

    def pack_files(self, file_paths, extension, key):
        # Implement the logic to package files using the provided key
        # This is a placeholder implementation
        package_path = f'package.{extension}'
        with open(package_path, 'wb') as package_file:  # Open in binary mode
            for file_path in file_paths:
                with open(file_path, 'rb') as file:  # Open in binary mode
                    package_file.write(file.read())
        # Save the key in a secure way
        key_path = f'{package_path}.key'
        with open(key_path, 'w') as key_file:
            key_file.write(key)
        return package_path

    def generate_key(self, key):
        key_path = 'key.txt'
        try:
            with open(key_path, 'w') as key_file:
                key_file.write(key)
            return key_path
        except Exception as e:
            print(f"Error generating key: {e}. Key: {key}")
            return None