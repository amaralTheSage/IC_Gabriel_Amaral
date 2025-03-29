Escrevi todas as declarações e queries no próprio arquivo .sql na minha IDE e executei no terminal do MySQL versão 8.0.34.

Nos arquivos .sql há alguns comentários que explicam melhor algumas das decisões tomadas.

Ao inserir os dados das _demonstrações contábeis_ no banco de dados,
tentei a alternativa de criar uma procedure que importaria os dados, mas o comando LOAD DATA INFILE não pode ser executado com PREPARE/EXECUTE:

DELIMITER ??
CREATE PROCEDURE importar_dados_csv(IN path VARCHAR(255))
BEGIN
SET @comando = CONCAT('
LOAD DATA INFILE "', path, '"
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY '';''
ENCLOSED BY ''"''
LINES TERMINATED BY ''\n''
IGNORE 1 ROWS;
');

    PREPARE comando FROM @comando; /* Converte a string em código executável
    EXECUTE comando;
    DEALLOCATE PREPARE comando; /* Limpa o comando da memória

END ??
DELIMITER ;

CALL importar_dados_csv('C:/Users/rocky/Desktop/teste_intuitive-care/banco de dados/dados/Demonstracoes Contabeis - gov/1T2023.csv');
