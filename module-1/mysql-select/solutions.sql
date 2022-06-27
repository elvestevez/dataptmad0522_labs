/* ## Challenge 1 - Who Have Published What At Where? */

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", 
    t.title "TITLE", p.pub_name "PUBLISHER"
FROM authors a
    INNER JOIN titleauthor ta ON a.au_id = ta.au_id
    INNER JOIN titles t ON ta.title_id = t.title_id
    INNER JOIN publishers p ON t.pub_id = p.pub_id


/* ## Challenge 2 - Who Have Published How Many At Where? */

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", 
    p.pub_name "PUBLISHER", COUNT(*) "TITLE CONT"
FROM authors a
    INNER JOIN titleauthor ta ON a.au_id = ta.au_id
    INNER JOIN titles t ON ta.title_id = t.title_id
    INNER JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY "TITLE CONT" DESC


/* ## Challenge 3 - Best Selling Authors */

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", 
    COUNT(*) "TOTAL", SUM(s.qty) "TOTAL UNITS"
FROM authors a
    INNER JOIN titleauthor ta ON a.au_id = ta.au_id
    INNER JOIN sales s ON s.title_id = ta.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY "TOTAL UNITS" DESC
LIMIT 3


/* ## Challenge 4 - Best Selling Authors Ranking */

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", 
    COUNT(*) "TOTAL", IFNULL(SUM(s.qty),0) "TOTAL UNITS"
FROM authors a
    LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
    LEFT JOIN sales s ON s.title_id = ta.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY "TOTAL UNITS" DESC
