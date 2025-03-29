from pydantic import BaseModel
from typing import Optional

class Operadora(BaseModel):
  __tablename__ = 'operadoras'
  Registro_ANS:str
  CNPJ: str
  Razao_Social: str 
  Nome_Fantasia: Optional[str]
  Cidade: str
  Endereco_eletronico: str 
  