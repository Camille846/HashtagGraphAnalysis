# Análise de Tweets com Banco Orientado a Grafos 

## Sobre o Projeto

O objetivo deste repositório é analisar um conjunto de arquivos JSON contendo dados de Tweets coletados entre 31/12/2019 e 01/04/2021. Estes arquivos foram filtrados usando uma única hashtag, que deve ser identificada pelo analista. Além da identificação da hashtag, o desafio é escolher uma perspectiva para análise de relacionamento entre os dados e representá-los em um grafo, onde os nós podem ser usuários ou tweets e os relacionamentos podem ser retweets, citações ou qualquer outra forma que o analista perceba como relevante.

## Motivação

A análise de dados de redes sociais é uma das principais aplicações de bancos de dados NoSQL no mercado atual. Assim, praticar com dados reais ajuda entender e se preparar para desafios reais de mercado. Este projeto visa treinar a habilidade de analisar dados de forma técnica e imparcial, separando opiniões pessoais da análise.

# Análise de Tweets com Neo4j

## Descrição do Conjunto de Dados e Projeto

Você terá acesso a 547 arquivos de um conjunto total de mais de 1000 arquivos coletados do Twitter entre 2006 e 2022, filtrados com uma única hashtag específica. Cada arquivo contém cerca de 100 tweets distribuídos em 4 principais contêineres de dados:

- **data**: A principal fonte de dados para este projeto. Inclui a mensagem e informações contextuais, como nome de usuário, hashtags usadas, se é um retweet, menções a outros usuários e mais.
- **errors**: Informações sobre quaisquer erros que ocorreram durante a coleta, como usuários que não foram encontrados, deletados, banidos ou suspensos. Esta seção pode não ser crítica para a análise.
- **includes**: Detalhes sobre anexos, mídia, links e outras informações extras relacionadas aos tweets e usuários.
- **meta**: Metadados sobre o arquivo JSON, incluindo o ID do tweet mais recente, o ID do tweet mais antigo, o token para a próxima coleta e a quantidade total de mensagens no arquivo.

## Como Começar

1. Instalar Neo4j localmente ou na nuvem.
2. Configurar o banco de dados para receber dados JSON do Twitter.
3. Importar os dados dos 547 arquivos JSON.
4. Identificar a hashtag que originou a coleta dos dados.
5. Criar um grafo com a hashtag central e os tweets relacionados. A representação deve ser limitada a um dia ou menos, com no mínimo 10 nós.
6. Analisar os dados e escolher uma informação específica para análise que possa ser representada em um grafo com mais de 10 nós interconectados.
7. Definir um período específico para a análise.
8. Criar e executar uma consulta para recuperar os dados escolhidos.
9. Visualizar a consulta em um grafo e apresentá-la.

### Arquivo 1: Descoberta da Hashtag Principal

Seu desafio é identificar a hashtag presente em todos os tweets coletados. Ao identificar, crie um grafo com a hashtag como nó central e os tweets relacionados como nós conectados. A visualização deve se limitar a um dia de mensagens, garantindo ao menos 10 nós. Inclua uma captura do grafo e o código utilizado em seu relatório. Marque ambos com seu RU e salve como PDF. Ao final, responda: Qual hashtag foi usada para a coleta?

### Arquivo 2: Análise dos Dados Segundo Viés à Sua Escolha

Após a primeira tarefa, o próximo desafio é extrair informações significativas de um vasto conjunto de dados. Selecione um viés de análise que possa gerar um grafo interconectado com mais de 10 nós (e idealmente menos de 200). Com base em sua escolha, defina um período para análise e crie a consulta adequada no Neo4j. Apresente o grafo resultante em seu relatório. Finalize respondendo: Qual comando você utilizou para importar os dados JSON no Neo4j?

## Resultados

![hashtag_principal](https://github.com/Camille846/HashtagGraphAnalysis/assets/83260908/0f72cebb-54af-4789-9325-2a90a515fde8)

Resultado do grafo com os registros encontrados sobre a hashtag principal: "issoaglobonaomostra". Ao centro vemos a hashtag principal usada que gerou os arquivos JSON destacada com cor amarela e em volta todos os tweets, em azul claro, com seus respectivos tweets de interação como retweets e citações. Em vermelho, há a representação dos usuários e sua relação com os tweets. 


![analise_tweets_sensiveis](https://github.com/Camille846/HashtagGraphAnalysis/assets/83260908/6a3732d1-aebf-4d10-a063-2484a5917d6e)

Resultado do grafo com os registros de tweet com conteúdos possivelmente sensíveis e não-sensíveis publicados no dia 31 de março de 2020 e suas relações. Os tweets postados estão em coloração verde e sua relação, representada em seta, com os nodes em vermelho, os quais representam conteúdo possivelmente sensível marcado, portanto, como “true”.  Em azul, é representado o usuário que fez a publicação com conteúdo possivelmente sensível. 

## Contribuição

Sugestões, feedbacks e contribuições são bem-vindos! Abra um "issue" ou faça um "pull request" para colaborar.








