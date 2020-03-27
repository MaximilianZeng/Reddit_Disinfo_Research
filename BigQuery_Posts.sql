-- Declare variables to use in later queries
DECLARE target_site STRING;
DECLARE target_reddit_group STRING;
SET target_reddit_group = 'The_Donald';
SET target_site = 'abcnews.com.co';

-- search for posts
WITH tables AS (
	-- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
	SELECT * FROM `fh-bigquery.reddit_posts.2019_04` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_05` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_06` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_07` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_08` 
)
-- Scan for posts linking to target websites from selected months
SELECT id, title, selftext, subreddit, author, created_utc, url, num_comments, score
FROM tables
-- search if the title/comment contain the target site
WHERE title LIKE CONCAT('%', target_site, '%')
    OR selftext LIKE CONCAT('%', target_site, '%')
LIMIT 100


-- # posts in specific subreddit
SELECT COUNT(id) as total_post
FROM tables
WHERE subreddit LIKE CONCAT('%', target_reddit_group, '%')

-- # posts linking to target websites in specific subreddit
SELECT COUNT(id) as post_contain_links
FROM tables
WHERE subreddit LIKE CONCAT('%', target_reddit_group, '%')
    AND (
        title LIKE CONCAT('%', 'http', '%')
        OR title LIKE CONCAT('%', 'www', '%')
        OR selftext LIKE CONCAT('%', 'http', '%')
        OR selftext LIKE CONCAT('%', 'www', '%')
    )

-- # posts containing bad links
SELECT COUNT(id) as post_contain_poison_links
FROM tables
WHERE subreddit LIKE CONCAT('%', target_reddit_group, '%')
    AND (
        title LIKE CONCAT('%', target_site, '%')
        OR selftext LIKE CONCAT('%', target_site, '%')
    )





-- Search for comments
-- WITH tables AS (
-- 	SELECT * FROM `fh-bigquery.reddit_comments.2019*`
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_04` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_05` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_06` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_07` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_08` 
-- )
-- Scan for comments linking to target websites from selected months
-- SELECT id, body, subreddit, author, created_utc, score, ups, downs
-- FROM tables
-- WHERE body LIKE CONCAT('%', target_site, '%')
-- LIMIT 100