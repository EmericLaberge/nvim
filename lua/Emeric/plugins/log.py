import os

def log_all_files(directory, log_file_path):
    with open(log_file_path, 'w') as log_file:
        for file_name in sorted(os.listdir(directory)):
            file_path = os.path.join(directory, file_name)
            if os.path.isfile(file_path):
                log_file.write(f"\n--- {file_name} ---\n")
                with open(file_path, 'r') as current_file:
                    log_file.write(current_file.read())
                    log_file.write("\n")

# Example usage:
log_all_files('.', 'log.txt')

