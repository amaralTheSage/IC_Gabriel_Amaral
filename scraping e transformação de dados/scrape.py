from bs4 import BeautifulSoup
import requests
import os
import zipfile

page = requests.get('https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos')

soup = BeautifulSoup(page.text, 'html.parser')

anexo_1 = soup.find('a', string='Anexo I.')
anexo_2 = soup.find('a', string="Anexo II.")

os.makedirs('pdfs', exist_ok=True)

with open('pdfs/anexo_1.pdf', 'wb') as file:
    file.write(requests.get(anexo_1.get('href')).content)

with open('pdfs/anexo_2.pdf', 'wb') as file:
    file.write(requests.get(anexo_2.get('href')).content)

with zipfile.ZipFile('pdfs/pdfs_compactados.zip', 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write('pdfs/anexo_1.pdf')
    zipf.write('pdfs/anexo_2.pdf')