/* ## Challenge 1 - Most Profiting Authors 
   ### Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication */

SELECT t.title_id "Title ID", ta.au_id "Author ID", 
    t.advance * ta.royaltyper / 100 "Advance", 
    t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
ORDER BY "Title ID", "Author ID"


/* ## Challenge 1 - Most Profiting Authors 
   ### Step 2: Aggregate the total royalties for each title and author */

-- Option 1
SELECT t.title_id "Title ID", ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY t.title_id, ta.au_id
ORDER BY "Title ID", "Author ID"

SELECT "Title ID", "Author ID", SUM("Royalty") "Royalty"
FROM
(
SELECT t.title_id "Title ID", ta.au_id "Author ID", 
    t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
)
GROUP BY "Title ID", "Author ID"
ORDER BY "Title ID", "Author ID"

-- Option 2
WITH Title_Au_Roy AS
(
SELECT t.title_id "Title ID", ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY t.title_id, ta.au_id
)
SELECT "Title ID", "Author ID", "Royalty"
FROM Title_Au_Roy
ORDER BY "Title ID", "Author ID"


/* ## Challenge 1 - Most Profiting Authors 
   ### Step 3: Calculate the total profits of each author */

WITH Title_Au_Roy AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY ta.au_id
),
Title_Au_Adv AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.advance * ta.royaltyper / 100) "Advance"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
GROUP BY ta.au_id
)
SELECT tar."Author ID", "Royalty" + "Advance" "Profits"
FROM Title_Au_Roy tar
    INNER JOIN Title_Au_Adv taa ON tar."Author ID" = taa."Author ID" 
ORDER BY tar."Author ID"


/* ## Challenge 2 - Alternative Solution */

CREATE TEMPORARY TABLE Title_Au_Roy AS
SELECT ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY ta.au_id

CREATE TEMPORARY TABLE Title_Au_Adv AS
SELECT ta.au_id "Author ID", 
    SUM(t.advance * ta.royaltyper / 100) "Advance"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
GROUP BY ta.au_id

SELECT tar."Author ID", "Royalty" + "Advance" "Profits"
FROM Title_Au_Roy tar
    INNER JOIN Title_Au_Adv taa ON tar."Author ID" = taa."Author ID" 


/* ## Challenge 3 */

-- Option 1
CREATE VIEW most_profiting_authors AS
WITH Title_Au_Roy AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY ta.au_id
),
Title_Au_Adv AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.advance * ta.royaltyper / 100) "Advance"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
GROUP BY ta.au_id
)
SELECT tar."Author ID" au_id, "Royalty" + "Advance" profits
FROM Title_Au_Roy tar
    INNER JOIN Title_Au_Adv taa ON tar."Author ID" = taa."Author ID" 
ORDER BY Profits DESC
LIMIT 3

-- Option 2
CREATE VIEW most_profiting_authors AS
WITH Title_Au_Roy AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "Royalty"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON s.title_id = t.title_id
GROUP BY ta.au_id
),
Title_Au_Adv AS
(
SELECT ta.au_id "Author ID", 
    SUM(t.advance * ta.royaltyper / 100) "Advance"
FROM titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
GROUP BY ta.au_id
),
au_profits AS
(
SELECT tar."Author ID", "Royalty" + "Advance" "Profits"
FROM Title_Au_Roy tar
    INNER JOIN Title_Au_Adv taa ON tar."Author ID" = taa."Author ID" 
ORDER BY Profits DESC
),
order_au_profits AS
(
SELECT "Author ID", "Profits",
    ROW_NUMBER() OVER() au_num
FROM au_profits
)
SELECT "Author ID" au_id, "Profits" profits FROM order_au_profits
WHERE order_au_profits.au_num <= 3
