DECLARE target_user STRING;

SET target_user = ;

WITH post_tables AS (
  -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
  SELECT * FROM `fh-bigquery.reddit_posts.2019_01`
), comment_tables AS (
  -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
  SELECT * FROM `fh-bigquery.reddit_comments.2019_01`
)

-- Select one user's activity in reddit comments in particular subreddit
SELECT
url,  
  comments.id as Comment_ID, 
  comments.body as Comment_Text,
  comments.author as Comment_Author, 
  comments.link_id as Comment_LinkID, 
  comments.parent_id as Comment_ParentID
FROM post_tables
LEFT_JOIN comment_tables
ON (
  posts.subreddit_id = comments.subreddit_id
  AND comments.link_id LIKE CONCAT('%', parent_id, '%')
)
WHERE author ='Spartan_Marine' 
AND subreddit in ('deathguard40k')
LIMIT 100