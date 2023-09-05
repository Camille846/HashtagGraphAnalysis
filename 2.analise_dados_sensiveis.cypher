// Código chamando os arquivos JSON pela biblioteca APOC e criando propriedades e relacionamentos entre Tweet, users e hashtags.
CALL apoc.load.directory('*.json') YIELD value
WITH value as arquivo
ORDER BY arquivo desc
CALL apoc.load.json(arquivo) YIELD value
UNWIND value.data as tweet
UNWIND tweet.possibly_sensitive as sensitive
MERGE (t:Tweet {tweet_id: tweet.id})
ON MATCH SET t.mensagem = tweet.text 
SET t.data_criacao = datetime(tweet.created_at)
SET t.sensitive_tweet = tweet.possibly_sensitive
MERGE (u:User {user_id: tweet.author_id})
MERGE (u) -[:POSTOU] -> (t);

  
// Código para encontrar tweets com conteúdo sensível e criar uma label Sensitive para esses nós.
MATCH (t: Tweet)
WHERE t.sensitive_tweet = true
    REMOVE t:Tweet
    SET t:Sensitive;

// Código para criar relacionamentos entre os tweets postados e os tweets com conteúdo possivelmente sensível.
CALL apoc.load.directory('*.json') YIELD value
WITH value as arquivo
ORDER BY arquivo desc
CALL apoc.load.json(arquivo) YIELD value
UNWIND value.data as tweet
UNWIND tweet.possibly_sensitive as sensitive
MERGE (t:Tweet {tweet_id: tweet.id})
MERGE (u:User {user_id: tweet.author_id})
MERGE (s:Sensitive {sensitive: tweet.possibly_sensitive})

ON MATCH SET t.mensagem = tweet.text 
SET t.data_criacao = datetime(tweet.created_at)
SET t.sensitive_tweet = tweet.possibly_sensitive
MERGE (u) -[:POSTOU] -> (t);
MERGE (t) -[:POSSUI] -> (s);

// Código para gerar um grafo com os usuários que postaram os tweets sensíveis com filtro para apenas um dia de mensagem.
MATCH (n)
WHERE exists(n.data_criacao) AND date(datetime(n.data_criacao)) = date('2020-03-31')
RETURN n