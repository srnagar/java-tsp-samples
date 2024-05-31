import os
import argparse

# Create a new directory with the given name
def create_directory(directory_name):
    try:
        os.makedirs(directory_name + "/tsp")
        print(f"Directory '{directory_name}' created successfully.")
        create_tspconfig(directory_name)
    except FileExistsError:
        print(f"Directory '{directory_name}' already exists.")
    except Exception as e:
        print(f"An error occurred: {e}")


# Create tspconfig.yaml file
def create_tspconfig(directory_name):

    namespace = directory_name.replace("-", ".")
    namespace = "com." + namespace
    try:
        with open(directory_name + "/tsp/tspconfig.yaml", "w") as f:
           f.write("parameters:")
           f.write("\n  \"service-directory-name\":")
           f.write("\n    default: \"playground\"")
           f.write("\nemit:")
           f.write("\n  - \"@azure-tools/typespec-java\"")
           f.write("\noptions:")
           f.write("\n  \"@azure-tools/typespec-java\":")
           f.write("\n    namespace: " + namespace)
           f.write("\n    partial-update: true")
           f.write("\n    emitter-output-dir: \"{project-root}/../\"")
           f.write("\n    flavor: azure")
           print("File 'tsp/tspconfig.yaml' created successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")

  
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Create a new directory.')
    parser.add_argument('directory_name', type=str, help='Name of the directory to create')

    args = parser.parse_args()
    create_directory(args.directory_name)