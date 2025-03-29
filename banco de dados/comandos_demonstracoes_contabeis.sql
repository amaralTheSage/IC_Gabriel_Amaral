CREATE DATABASE IF NOT EXISTS teste_IC_gabriel_amaral;
USE teste_IC_gabriel_amaral;

CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    data DATE,
    reg_ans VARCHAR(10),
    cd_conta_contabil VARCHAR(10),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2)
);


/* No meu caso, foi necessário modificar o valor de "secure-file-priv" para "" no arquivo de configuração do meu MySQL (my.ini, em C:\ProgramData\MySQL\MySQL Server 8.0/my.ini) e então resetar o serviço do MySQL*/
/* Mude para os caminhos corretos dos arquivos na sua máquina */
/* 2023 */ 
LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/1T2023.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), /* Foi necessário substituir as vírgulas por pontos */
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/2T2023.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    

LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/3T2023.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/4T2023.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = DATE_FORMAT(STR_TO_DATE(@date_column, '%d/%m/%Y'), '%Y-%m-%d'), /* Neste arquivo as datas estão no formato dd/mm/aaaa, ao invés do esperado: aaaa-mm-dd */
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


/* 2024 */
LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/1T2024.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/2T2024.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/3T2024.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE "C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/4T2024.csv"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'            
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(data, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'), 
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');



/*_____________________________________*/
/* QUERIES */

/* Quais as 10 operadoras com maiores despesas em "EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre? */

SELECT reg_ans, descricao, SUM(vl_saldo_final) AS despesas 
FROM demonstracoes_contabeis 
WHERE data >= '2024-07-01' /* Considerei o último trimestre como sendo os 3 meses anteriores ao ultimo registro (10/2024)*/  
AND
descricao LIKE "%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%"
GROUP BY reg_ans, descricao 
ORDER BY despesas DESC 
LIMIT 10;


/* Quais as 10 operadoras com maiores despesas nessa categoria no último ano? */
SELECT reg_ans, descricao, SUM(vl_saldo_final) AS despesas 
FROM demonstracoes_contabeis 
WHERE data >= '2023-10-01' /* Considerei o último ano como sendo os últimos 12 meses anteriores ao último registro, ao invés do ano de 2024 (2024-01-01) */  
AND
descricao LIKE "%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%"
GROUP BY reg_ans, descricao 
ORDER BY despesas DESC 
LIMIT 10;