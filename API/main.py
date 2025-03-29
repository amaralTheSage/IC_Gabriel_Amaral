from fastapi import FastAPI, Query, HTTPException
from typing import Optional
from mysql.connector import Error
from database import MYSQL_CONFIG, conectar_ao_db
from models import Operadora
from fastapi.middleware.cors import CORSMiddleware

# python -m uvicorn main:app --reload 

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite todas origens -> foi necessário pra resolver um erro, não recomendado em produção
    allow_credentials=True,
    allow_methods=["GET"],  # Permite somente GETs
)

@app.get("/", response_model=list[Operadora])
async def buscar_operadoras(
    query: Optional[str] = Query(None), 
    page: Optional[int] = Query(0)
):
    conn = None
    cursor = None
    try:
        conn = conectar_ao_db()
        cursor = conn.cursor(dictionary=True)  
        
        colunas = [
            "Registro_ANS",
            "CNPJ",
            "Razao_Social",
            "Nome_Fantasia",
            "Cidade",
            "Endereco_eletronico"
        ]
        
        if query or (query and page) :
            condicoes = [f"{col} LIKE %s" for col in colunas] # %s -> mysql.connector entende como o valor da query
            sql = f"SELECT * FROM operadoras WHERE {' OR '.join(condicoes)} LIMIT {(page-1)*10},10"
            params = [f"%{query}%"] * len(colunas)

            print(f'query: {query},\n conditions: {condicoes},\n sql: {sql},\n params: {params}')
            # Output desse print explica bem as váriaveis:
            #   query: Companhia,
            #   conditions: ['Registro_ANS LIKE %s', 'CNPJ LIKE %s', 'Razao_Social LIKE %s', 'Nome_Fantasia LIKE %s', 'Cidade LIKE %s', 'Endereco_eletronico LIKE %s'],
            #   sql: SELECT * FROM operadoras WHERE Registro_ANS LIKE %s OR CNPJ LIKE %s OR Razao_Social LIKE %s OR Nome_Fantasia LIKE %s OR Cidade LIKE %s OR Endereco_Eletronico LIKE %s LIMIT 0,10,
            #   params: ['%Companhia%', '%Companhia%', '%Companhia%', '%Companhia%', '%Companhia%', '%Companhia%']

            cursor.execute(sql, params)

        elif page:
            cursor.execute(f"SELECT * FROM operadoras LIMIT {(page-1)*10},10")
 
        # fiz separado assim para ser possível acessar uma lista completa pelo postman ou no navegador, sem limitação padrão de 10
        else:
            cursor.execute(f"SELECT * FROM operadoras")
        
        results = cursor.fetchall()
        return results
        
    except Error as e:
        raise HTTPException(
            status_code=500,
            detail=f"Falha na conexão ao banco de dados: {e}"
        )

    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()
