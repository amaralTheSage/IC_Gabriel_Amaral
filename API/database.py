import mysql.connector 
from mysql.connector import Error
from fastapi import HTTPException

def conectar_ao_db():
    try:
        # ** --> "desmonta" o dicionário em chaves e valores
        conn = mysql.connector.connect(**MYSQL_CONFIG)
        return conn
    except Error as e:
        raise HTTPException(
            status_code=500,
            detail=f"Falha na conexão ao banco de dados: {e}"
        )

# Alterar de acordo com seu MySQL
MYSQL_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'password1900',
    'database': 'teste_IC_gabriel_amaral'
}


