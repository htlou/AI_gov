import os
def get_output_file_name(original_file_name):
    """
    Get output file name with suffix '_filtered'
    e.g., 
    input: patent_2015.json
    output: patent_2015_filtered.json
    """


    # 分割文件名和扩展名
    file_name_without_extension, extension = os.path.splitext(original_file_name)

    # 在文件名后添加"_filtered"，然后重新添加扩展名
    filtered_file_name = f"{file_name_without_extension}_filtered{extension}"
    print(f"Changed output file name:{filtered_file_name}")

    return filtered_file_name