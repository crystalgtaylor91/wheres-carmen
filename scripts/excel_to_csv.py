import pandas as pd
import os
import sys
import logging

logging.basicConfig(
    level=logging.INFO, 
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def loop_through_files(source_folder, target_folder):
    if os.path.exists(source_folder):
        os.makedirs(target_folder, exist_ok=True)
        for filename in os.listdir(source_folder):
            if filename.endswith(".xlsx"):
                excel_file = os.path.join(source_folder, filename)
                csv_file = os.path.join(target_folder, filename.replace(".xlsx", ".csv"))
                excel_to_csv(excel_file, csv_file)
    else:
        logging.error(f'Please provide a valid source_folder, {source_folder} cannot be found')


def excel_to_csv(source_file, target_file):
    xlsx = pd.ExcelFile(source_file)

    for sheet_name in xlsx.sheet_names:
        df = pd.read_excel(xlsx, sheet_name=sheet_name)
        df['region'] = sheet_name
        file_name = target_file.replace('.csv', f'_{sheet_name}.csv')
        df.to_csv(file_name, index=False)
        logging.info(f'Converted {source_file} sheet {sheet_name} to CSV stored at {file_name}')


if __name__ == "__main__":
    source_folder = sys.argv[1]
    target_folder = sys.argv[2]
    loop_through_files(source_folder, target_folder)
