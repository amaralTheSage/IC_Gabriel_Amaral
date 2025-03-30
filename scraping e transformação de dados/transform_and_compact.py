import zipfile
import pdfplumber
import pandas as pd
import os


headers = ["PROCEDIMENTO", "RN (alteração)", "VIGÊNCIA", "Seg. Odontológica", "Seg. Ambulatorial", 
           "HCO", "HSO", "REF", "PAC", "DUT", "SUBGRUPO", "GRUPO", "CAPÍTULO"]
table = []

with pdfplumber.open('pdfs/anexo_1.pdf') as pdf:
    for page in pdf.pages:
        table_in_page = page.extract_table()
      
        if table_in_page:
            for row in table_in_page:
                # confere há o header "PROCEDIMENTO" na primeira colunas da primeira fileira de cada página.
                # fiz isso para que os headers não se repetissem para todas as páginas
                if row[0] != 'PROCEDIMENTO': 
                    table.append(row)

os.makedirs('csvs', exist_ok=True)

data_frame = pd.DataFrame(table, columns=headers)
data_frame.to_csv("csvs/dados_extraidos.csv", index=False)

with zipfile.ZipFile('csvs/Teste_Gabriel_Amaral.zip', 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write('csvs/dados_extraidos.csv')