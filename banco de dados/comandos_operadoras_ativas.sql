CREATE DATABASE IF NOT EXISTS teste_IC_gabriel_amaral;
USE teste_IC_gabriel_amaral;

/* Alguns desses valores não parecem adequados, como um telefone de 20 caracteres, mas foi o necessário para se adequar aos dados do próprio csv, que contém em alguns registros valores gigantes por algum motivo*/
CREATE TABLE IF NOT EXISTS operadoras (
    Registro_ANS VARCHAR(40),
    CNPJ VARCHAR(14),
    Razao_Social VARCHAR(200),
    Nome_Fantasia VARCHAR(100),
    Modalidade VARCHAR(50),
    Logradouro VARCHAR(100),
    Numero VARCHAR(15),
    Complemento VARCHAR(100),
    Bairro VARCHAR(80),
    Cidade VARCHAR(80),
    UF CHAR(2),
    CEP VARCHAR(10),
    DDD VARCHAR(2),
    Telefone VARCHAR(20), 
    Fax VARCHAR(15),
    Endereco_eletronico VARCHAR(100),
    Representante VARCHAR(100),
    Cargo_Representante VARCHAR(50),
    Regiao_de_Comercializacao VARCHAR(1) ,
    Data_Registro_ANS DATE,
    PRIMARY KEY (Registro_ANS)
);

/* No meu caso, foi necessário modificar o valor de "secure-file-priv" para "" no arquivo de configuração do meu MySQL (my.ini, em C:\ProgramData\MySQL\MySQL Server 8.0/my.ini) e então resetar o serviço do MySQL*/
/* Mude para o caminho correto do arquivo na sua máquina */
LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Operadoras Ativas ANS/Relatorio_cadop.csv"
INTO TABLE operadoras
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
