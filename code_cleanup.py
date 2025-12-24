import os

project_dir = os.getcwd()
print(f"Starting cleanup in directory: {project_dir}")

for root, dirs, files in os.walk(project_dir):
    # Exclude .git directories
    if ".git" in dirs:
        dirs.remove(".git")

    for filename in files:
        file_path = os.path.join(root, filename)

        if filename.endswith((".vcxproj", ".sln")):
            os.remove(file_path)
            print(f"Removed VS file: {file_path}")
            continue

        if filename.endswith((".c", ".h")):
            with open(file_path, "rb") as f:
                content = f.read()

            try:
                # If content is not UTF-8, a UnicodeDecodeError is raised.
                decoded_content = content.decode("utf-8")
            except UnicodeDecodeError:
                # Assume CP1252 if not UTF-8. Fails if it's not CP1252 either.
                decoded_content = content.decode("cp1252")

            # Normalize line endings
            decoded_content = decoded_content.replace("\r\n", "\n")
            utf8_content = decoded_content.encode("utf-8")

            if content != utf8_content:
                with open(file_path, "wb") as f:
                    f.write(utf8_content)
                print(f"Successfully converted {file_path}")

print("Cleanup finished.")
