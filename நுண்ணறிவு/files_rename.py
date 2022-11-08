import os
# import glob

base_path = os.path.dirname(__file__)
# print("base_path\n", base_path)

files_and_folders = os.listdir(base_path)
print("files_and_folders\n")
# for name in files_and_folders:
#     print(name)


recursive_file_paths = []
recursive_folder_paths = []
for root, directories, files in os.walk(base_path):
    # print("root, directories, files in each step of walk\n", root, directories, files)
    for name in files:
        file_path = os.path.join(root, name)
        recursive_file_paths.append(file_path)
    for name in directories:
        folder_path = os.path.join(root, name)
        recursive_folder_paths.append(folder_path)
# renaming logic starts here.
for file_path in recursive_file_paths:
    folder_name, file_name = os.path.split(file_path)
    name_parts = file_name.split('.')
    extension = str(name_parts[-1])
    if len(name_parts) > 3 and (extension == "srt" or extension == "mp4" or extension == "mkv"):
        # print("current name : ", file_name)
        # print("name_parts : ", name_parts)
        name_parts.pop(-1)
        new_name = " ".join(name_parts) + "." + str(extension)
        print("new name :", new_name)
        os.rename(os.path.join(folder_name, file_name), os.path.join(folder_name, new_name) )


# print("recursive_file_paths_count\n", len(recursive_file_paths))
# print("recursive_folder_paths_count\n", len(recursive_folder_paths))
