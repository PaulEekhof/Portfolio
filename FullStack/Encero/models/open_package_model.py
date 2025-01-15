import zipfile

def open_package(package_path):
    try:
        with zipfile.ZipFile(package_path, 'r') as package:
            package.extractall()
    except Exception as e:
        print(f"Error opening package: {e}")

if __name__ == "__main__":
    open_package('package.bep')
