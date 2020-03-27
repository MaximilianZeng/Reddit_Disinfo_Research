DECLARE parent_id STRING;
DECLARE post_id STRING;

SET post_id = 'af80hh';
SET parent_id = 'af80hh';


WITH post_tables AS (
    -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
    SELECT * FROM `fh-bigquery.reddit_posts.2019_04`
), comment_tables AS (
    -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
    SELECT * FROM `fh-bigquery.reddit_comments.2019_04`
)

-- -- Select all the comments of a certain post
-- SELECT
--   url,  
--   comments.id as Comment_ID, 
--   comments.body as Comment_Text,
--   comments.author as Comment_Author, 
--   comments.link_id as Comment_LinkID, 
--   comments.parent_id as Comment_ParentID
-- FROM post_tables as posts
-- LEFT JOIN comment_tables as comments
-- ON (
--   posts.subreddit_id = comments.subreddit_id
--   AND comments.link_id LIKE CONCAT('%', parent_id, '%')
-- )
-- WHERE posts.id = post_id
-- LIMIT 100;

-- WITH post_tables AS (
--   -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
--   SELECT * FROM `fh-bigquery.reddit_posts.2019_01`
-- ), comment_tables AS (
--   -- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
--   SELECT * FROM `fh-bigquery.reddit_comments.2019_01`
-- )
-- Select all the comments of a certain post

SELECT
    url,  
    comments.id as Comment_ID, 
    comments.body as Comment_Text,
    comments.author as Comment_Author, 
    comments.link_id as Comment_LinkID, 
    comments.parent_id as Comment_ParentID
    
FROM post_tables as posts
LEFT JOIN comment_tables as comments
ON (
    posts.subreddit_id = comments.subreddit_id
    AND comments.link_id LIKE CONCAT('%', parent_id, '%')
)
WHERE posts.id = post_id
LIMIT 100;

