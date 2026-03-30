SELECT 
    CASE 
        WHEN critic_score >= 9 THEN '9-10 Excellent'
        WHEN critic_score >= 7 THEN '7-8 Good'
        WHEN critic_score >= 5 THEN '5-6 Average'
        ELSE '1-4 Poor'
    END AS score_bracket,
    COUNT(*) AS num_games,
    ROUND(AVG(total_sales), 3) AS avg_sales_millions
FROM video_games
GROUP BY 
    CASE 
        WHEN critic_score >= 9 THEN '9-10 Excellent'
        WHEN critic_score >= 7 THEN '7-8 Good'
        WHEN critic_score >= 5 THEN '5-6 Average'
        ELSE '1-4 Poor'
    END
ORDER BY avg_sales_millions DESC;

SELECT 
    CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
    genre,
    ROUND(SUM(total_sales), 1) AS total_sales_millions
FROM video_games
WHERE release_year IS NOT NULL
GROUP BY decade, genre
ORDER BY decade, total_sales_millions DESC;

SELECT 
    publisher,
    COUNT(DISTINCT title) AS unique_games,
    ROUND(SUM(total_sales), 1) AS total_sales_millions,
    ROUND(AVG(total_sales), 3) AS avg_sales_per_game,
    ROUND(AVG(critic_score), 2) AS avg_critic_score
FROM video_games
GROUP BY publisher
ORDER BY total_sales_millions DESC
LIMIT 20;

SELECT 
    title,
    genre,
    publisher,
    ROUND(critic_score, 1) AS critic_score,
    ROUND(total_sales, 2) AS total_sales_millions,
    CASE
        WHEN critic_score < 6 AND total_sales > 1 THEN 'Hidden Gem'
        WHEN critic_score >= 9 AND total_sales < 0.5 THEN 'Overrated'
        WHEN critic_score >= 9 AND total_sales >= 5 THEN 'True Legend'
        ELSE 'Standard'
    END AS category
FROM video_games
ORDER BY total_sales_millions DESC;
