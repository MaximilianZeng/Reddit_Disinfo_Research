DECLARE target_user STRING;
DECLARE target_site STRING;
DECLARE target_reddit_group STRING;

SET target_user = ;
SET target_reddit_group = 'The_Donald';
SET target_site = 'abcnews.com.co';


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
WHERE author =target_user
AND subreddit = target_reddit_group
-- AND subreddit in ('deathguard40k')
LIMIT 100

-- # posts in specific subreddit by target user
SELECT id, title, selftext, subreddit, author, created_utc, url, num_comments, score
-- SELECT COUNT(id) as post_contain_poison_links
FROM tables
WHERE subreddit = target_reddit_group
-- WHERE subreddit in (target_reddit_group, )
    AND author = target_user

-- # posts linking to a websites in specific subreddit by target user
SELECT id, title, selftext, subreddit, author, created_utc, url, num_comments, score
-- SELECT COUNT(id) as post_contain_poison_links
FROM tables
WHERE subreddit = target_reddit_group
    AND (
        title LIKE CONCAT('%', 'http', '%')
        OR title LIKE CONCAT('%', 'www', '%')
        OR selftext LIKE CONCAT('%', 'http', '%')
        OR selftext LIKE CONCAT('%', 'www', '%')
    )
    AND author = target_user

    -- # posts linking to target websites in specific subreddit by target user
-- # posts containing bad links
SELECT id, title, selftext, subreddit, author, created_utc, url, num_comments, score
-- SELECT COUNT(id) as post_contain_poison_links
FROM tables
WHERE subreddit = target_reddit_group
    AND (
        title LIKE CONCAT('%', target_site, '%')
        OR selftext LIKE CONCAT('%', target_site, '%')
    )
    AND author = target_user