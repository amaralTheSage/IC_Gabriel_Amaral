Este frontend foi construído em Vuejs e utiliza o axios para buscar os registros na API desenvolvida anteriormente

para instalar as dependências:
npm i

Para rodar a aplicação:
npm run dev

O servidor será rodado por padrão no port 5173 e pode ser acessado pelo navegador em:
http://127.0.0.1:5173

A aplicação tem como funcionalidade:

- Demonstração dos registros parciais (com as colunas estabelecidas na API);
- Pesquisa com base em qualquer coluna (ex: se o usuário pesquisar por "Sul", registros semelhantes na razão social, nome fantasia, cidade, e todos as outras colunas aparecerão). Julguei ser uma boa maneira de garantir que o usuário encontre o que procura.
- Paginação, cada página retornando 10 registros por vez.

Além deste README, há comentários explicando mais de perto alguns processos dessa aplicação.
