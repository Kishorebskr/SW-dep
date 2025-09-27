import yaml
import sys

def update_values_file(env, app_version):
    values_file_path = f'../charts/webapp/values/{env}.yaml'
    
    try:
        with open(values_file_path, 'r') as file:
            values = yaml.safe_load(file)

        values['appVersion'] = app_version

        with open(values_file_path, 'w') as file:
            yaml.dump(values, file)

        print(f"Updated {env}.yaml with appVersion: {app_version}")

    except FileNotFoundError:
        print(f"Error: {values_file_path} not found.")
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python update-values.py <environment> <app_version>")
        sys.exit(1)

    environment = sys.argv[1]
    version = sys.argv[2]

    if environment not in ['dev', 'prod']:
        print("Error: Environment must be 'dev' or 'prod'.")
        sys.exit(1)

    update_values_file(environment, version)