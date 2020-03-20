-- Declare variables to use in later queries
DECLARE target_site STRING;
SET target_site = 'bizstandardnews.com';

WITH tables AS (
	-- SELECT * FROM `fh-bigquery.reddit_posts.2019*`
	SELECT * FROM `fh-bigquery.reddit_posts.2019_04` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_05` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_06` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_07` UNION ALL
	SELECT * FROM `fh-bigquery.reddit_posts.2019_08` 
)


-- Scan for posts linking to target websites from selected months
SELECT id, title, selftext, subreddit, author, created_utc, url, num_comments, score, ups, downs
FROM tables
WHERE title LIKE CONCAT('%', target_site, '%')
  OR selftext LIKE CONCAT('%', target_site, '%')
LIMIT 100



WITH tables AS (
	SELECT * FROM `fh-bigquery.reddit_comments.2019*`
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_04` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_05` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_06` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_07` UNION ALL
-- 	SELECT * FROM `fh-bigquery.reddit_posts.2019_08` 
)

-- Scan for comments linking to target websites from selected months
SELECT id, body, subreddit, author, created_utc, score, ups, downs
FROM tables
WHERE body LIKE CONCAT('%', target_site, '%')
LIMIT 100