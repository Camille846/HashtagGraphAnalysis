// Código chamando os arquivos JSON pela biblioteca APOC e criando propriedades e relacionamentos entre Tweet, users e hashtags.

CALL apoc.load.directory('*.json') YIELD value
WITH value as arquivo
ORDER BY arquivo desc
CALL apoc.load.json(arquivo) YIELD value
UNWIND value.data AS tweet
UNWIND tweet.entities.hashtags AS hashtag
MERGE (t:Tweet {tweet_id: tweet.id})
ON MATCH SET t.mensagem = tweet.text
SET t.data_criacao = datetime(tweet.created_at)
MERGE (u:User {user_id: tweet.author_id})
MERGE (h:Hashtag {tag: hashtag.tag})
MERGE (t) -[:TEM] -> (h)
MERGE (u) -[:POSTOU] -> (t);

// Para criar propriedades nos nós de tweets referenciados recebidos pela chave "referenced_tweets" do arquivo JSON.
CALL apoc.load.directory('*.json') YIELD value
WITH value as arquivo
ORDER BY arquivo desc
CALL apoc.load.json(arquivo) YIELD value
UNWIND value.data AS tweet
UNWIND tweet.referenced_tweets AS ref
MERGE (t:Tweet {tweet_id:tweet.id})
ON MATCH SET t.tipo_ref = ref.type;
 
//  Código removendo a propriedade Tweet para substituí-la por Retweet, filtrando assim, os nós da label Tweet que possui a propriedade tipo_ref.  
  
MATCH (t: Tweet)
WHERE t.tipo_ref = 'retweeted'
    REMOVE t:Tweet
    SET t:Retweet

//  Código removendo a propriedade Tweet para substituí-la por Quoted, filtrando assim, os nós da label Tweet que possui a propriedade tipo_ref.  
MATCH (t: Tweet)
WHERE t.tipo_ref = 'quoted'
    REMOVE t:Tweet
    SET t:Quoted

//  Código para encontrar hashtag principal que originou o arquivo JSON
MATCH (t:Tweet)-[:POSSUI]->(h:Hashtag)
WITH h.tag AS hashtag, count(t) AS qtde_tweets
ORDER BY qtde_tweets DESC
LIMIT 1
RETURN hashtag

//  Código Para gerar um grafo com os usuários que postaram os tweets e que possuem a hashtag principal em apenas um dia de mensagem.
MATCH (u:User) -[:POSTOU] -> (t:Tweet) 
MATCH (t:Tweet)-[:TEM]->(h:Hashtag {tag: 'issoaglobonaomostra'})
WHERE date(t.data_criacao) = date('2020-03-23')
RETURN t, h, u

