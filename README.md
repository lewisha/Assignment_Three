# Assignment_Three
There are two parts, the first is Q&amp;A, the second is coding

Part One
Answer following questions
1.	In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
    JOIN and Subquery have their own advantages and disadvantages,
    If I 
    
    Otherwise, I would use 
    
3.	What is CTE and when to use it?
    CTE stands for Common Table Expressions, 





5.	What are Table Variables? What is their scope and where are they created in SQL Server?
    TV stands for 
    They were created and stored in the temptb, can only be used in their session.





7.	What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
    Delete removes rows one at a time.
    
    Truncate removes all records and doesn't fire triggers. Truncate is faster compared to delete as it makes less use of the transaction log. 
    Truncate is not possible when a table is referenced by a Foreign Key or tables are used in replication or with indexed views.



9.	What is Identity column? How does DELETE and TRUNCATE affect it?
     IDENTITY column is a special type of column that is used to automatically generate key values based on a provided seed (starting point) and increment. 
     SQL Server provides us with a number of functions that work with the IDENTITY column.
     
    Delete retains the identity and does not reset it to the seed value.
    Truncate reset the identity to its seed value.
