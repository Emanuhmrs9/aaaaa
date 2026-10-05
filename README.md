# Shopee Oportunidades

Painel local para encontrar produtos da Shopee com potencial de divulgação como afiliado, usando a Shopee Affiliate Open API real.

## Importante: credenciais

A Open API oficial brasileira apresenta autenticação com **AppId + Secret**. O Explorer oficial da Shopee mostra esses dois campos. O projeto, portanto, **não cria nem exige `AFFILIATE_ID`**.

Se a sua tela mostra um **PID**, não presuma que PID seja AppId. Use o valor como `SHOPEE_APP_ID` somente se a própria área da Shopee o identificar como AppId/Open API AppId. Se a sua conta de afiliado tiver apenas PID e Secret e não houver AppId/Open API AppId, o código não inventa uma equivalência: será necessário obter/habilitar o acesso à Open API da Shopee.

Fonte oficial: https://open-api.affiliate.shopee.com.br/explorer

## Segurança

As credenciais ficam exclusivamente no backend, em `.env`.

Nunca coloque Secret em `frontend/` e nunca publique `.env` no GitHub. O `.gitignore` já bloqueia `.env`.

## Instalação no Windows

1. Extraia a pasta para um local simples, por exemplo:

   `C:\Shopee\shopee-oportunidades`

2. Abra a pasta.

3. Na barra de endereço do Explorer, digite `cmd` e pressione Enter.

4. Verifique o Node.js:

   ```bat
   node --version
   npm --version
   ```

5. Instale as dependências:

   ```bat
   npm install
   ```

6. Copie `.env.example` para `.env`.

7. Abra `.env` e preencha:

   ```env
   SHOPEE_APP_ID=SEU_APP_ID
   SHOPEE_SECRET=SEU_SECRET
   ```

8. Opcionalmente, configure SubIds:

   ```env
   SHOPEE_SUB_IDS=instagram,whatsapp,site
   ```

9. Inicie:

   ```bat
   npm start
   ```

10. Abra:

   `http://localhost:3000`

Ou use **Iniciar Site.bat** com dois cliques.

## Como testar a conexão

No painel, use **Testar conexão**. O sistema fará uma chamada real à Open API.

- Credencial inválida: verifique AppId e Secret.
- Assinatura inválida: confirme os valores exatamente, sem espaços extras.
- Acesso negado: a conta pode não ter acesso à Open API/operação.
- Limite: aguarde e tente novamente.
- Erro de rede: verifique internet, firewall e antivírus.

O sistema não exibe `Internal Server Error` sozinho: ele tenta apresentar a causa retornada pela Shopee.

## O que o sistema usa

- GraphQL: `https://open-api.affiliate.shopee.com.br/graphql`
- Consulta de produtos: `productOfferV2`
- Geração de link rastreável: `generateShortLink`
- Assinatura SHA-256 no backend

## Produto e link

O painel usa o produto retornado pela Shopee. Quando a oferta fornece `offerLink`, ele é usado para abrir a oferta. Quando não fornece, o sistema envia o `productLink` para `generateShortLink` e abre o link de afiliado retornado pela Shopee.

Isso evita fabricar parâmetros de tracking.

A Shopee informa que links de afiliado devem ser gerados pela plataforma da Shopee para que a atribuição de comissão seja válida.

Fonte oficial: https://help.shopee.com.br/portal/10/article/163057-Entenda-o-processo-de-validação-das-comissões

## Funcionalidades

- pesquisa real de produtos;
- ordenação por relevância, vendas, preço e comissão;
- análise de oportunidade 0–100;
- explicação da pontuação;
- preço, desconto, vendas, avaliação e comissão quando fornecidos pela API;
- página/modal do produto;
- abrir o mesmo produto na Shopee;
- copiar link de afiliado;
- favoritos locais;
- filtros/ordenação;
- mensagens de erro específicas;
- credenciais protegidas no backend.

## Limite da pontuação

A pontuação é uma heurística do painel e considera apenas dados disponíveis na API: vendas, comissão, avaliação e desconto. O sistema não inventa dados de procura ou concorrência quando eles não são fornecidos.

## Reiniciar

Para parar: `Ctrl+C` no CMD.

Para iniciar novamente:

```bat
npm start
```

ou dê dois cliques em `Iniciar Site.bat`.

## Não compartilhe

Nunca envie para ninguém:

- `SHOPEE_SECRET`;
- arquivo `.env`;
- tokens ou chaves de API.
