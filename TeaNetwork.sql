USE master;
GO

DROP DATABASE IF EXISTS TeaNetwork;
CREATE DATABASE TeaNetwork;
GO

USE TeaNetwork;
GO

CREATE TABLE Person
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE Country
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(30) NOT NULL,
    continent NVARCHAR(30) NOT NULL
) AS NODE;

CREATE TABLE Tea
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    type NVARCHAR(30) NOT NULL
) AS NODE;
GO

CREATE TABLE FriendOf AS EDGE;
CREATE TABLE LivesIn AS EDGE;
CREATE TABLE ProducedIn AS EDGE;
CREATE TABLE Likes
(
    rating INT
) AS EDGE;
GO

ALTER TABLE FriendOf
ADD CONSTRAINT EC_FriendOf CONNECTION (Person TO Person);

ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Person TO Country);

ALTER TABLE ProducedIn
ADD CONSTRAINT EC_ProducedIn CONNECTION (Tea TO Country);

ALTER TABLE Likes
ADD CONSTRAINT EC_Likes CONNECTION (Person TO Tea);
GO

INSERT INTO Person (id, name)
VALUES (1, N'       '),
       (2, N'     '),
       (3, N'       '),
       (4, N'         '),
       (5, N'      '),
       (6, N'         '),
       (7, N'     '),
       (8, N'     '),
       (9, N'        '),
       (10, N'    ');
GO

INSERT INTO Country (id, name, continent)
VALUES (1, N'     ', N'    '),
       (2, N'     ', N'    '),
       (3, N'   -     ', N'    '),
       (4, N'      ', N'    '),
       (5, N'     ', N'      '),
       (6, N'      ', N'    '),
       (7, N'       ', N'    '),
       (8, N'         ', N'             '),
       (9, N'            ', N'      '),
       (10, N'    ', N'    ');
GO

INSERT INTO Tea (id, name, type)
VALUES (1, N'          ', N'׸    '),
       (2, N'     ', N'      '),
       (3, N'    ', N'                '),
       (4, N'      ', N'׸    '),
       (5, N'     ', N'׸    '),
       (6, N'     ', N'      '),
       (7, N'    ', N'    '),
       (8, N'      ', N'        '),
       (9, N'              ', N'׸    '),
       (10, N'           ', N'     ');
GO

INSERT INTO FriendOf ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE id = 1), (SELECT $node_id FROM Person WHERE id = 2)),
       ((SELECT $node_id FROM Person WHERE id = 1), (SELECT $node_id FROM Person WHERE id = 5)),
       ((SELECT $node_id FROM Person WHERE id = 2), (SELECT $node_id FROM Person WHERE id = 3)),
       ((SELECT $node_id FROM Person WHERE id = 3), (SELECT $node_id FROM Person WHERE id = 1)),
       ((SELECT $node_id FROM Person WHERE id = 3), (SELECT $node_id FROM Person WHERE id = 6)),
       ((SELECT $node_id FROM Person WHERE id = 4), (SELECT $node_id FROM Person WHERE id = 2)),
       ((SELECT $node_id FROM Person WHERE id = 5), (SELECT $node_id FROM Person WHERE id = 4)),
       ((SELECT $node_id FROM Person WHERE id = 6), (SELECT $node_id FROM Person WHERE id = 7)),
       ((SELECT $node_id FROM Person WHERE id = 6), (SELECT $node_id FROM Person WHERE id = 8)),
       ((SELECT $node_id FROM Person WHERE id = 8), (SELECT $node_id FROM Person WHERE id = 3)),
       ((SELECT $node_id FROM Person WHERE id = 9), (SELECT $node_id FROM Person WHERE id = 10)),
       ((SELECT $node_id FROM Person WHERE id = 10), (SELECT $node_id FROM Person WHERE id = 7));
GO

INSERT INTO LivesIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE id = 1), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Person WHERE id = 2), (SELECT $node_id FROM Country WHERE id = 2)),
       ((SELECT $node_id FROM Person WHERE id = 3), (SELECT $node_id FROM Country WHERE id = 3)),
       ((SELECT $node_id FROM Person WHERE id = 4), (SELECT $node_id FROM Country WHERE id = 3)),
       ((SELECT $node_id FROM Person WHERE id = 5), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Person WHERE id = 6), (SELECT $node_id FROM Country WHERE id = 4)),
       ((SELECT $node_id FROM Person WHERE id = 7), (SELECT $node_id FROM Country WHERE id = 4)),
       ((SELECT $node_id FROM Person WHERE id = 8), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Person WHERE id = 9), (SELECT $node_id FROM Country WHERE id = 5)),
       ((SELECT $node_id FROM Person WHERE id = 10), (SELECT $node_id FROM Country WHERE id = 6));
GO

INSERT INTO ProducedIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Tea WHERE id = 1), (SELECT $node_id FROM Country WHERE id = 2)),
       ((SELECT $node_id FROM Tea WHERE id = 2), (SELECT $node_id FROM Country WHERE id = 4)),
       ((SELECT $node_id FROM Tea WHERE id = 3), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Tea WHERE id = 4), (SELECT $node_id FROM Country WHERE id = 3)),
       ((SELECT $node_id FROM Tea WHERE id = 5), (SELECT $node_id FROM Country WHERE id = 2)),
       ((SELECT $node_id FROM Tea WHERE id = 6), (SELECT $node_id FROM Country WHERE id = 4)),
       ((SELECT $node_id FROM Tea WHERE id = 7), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Tea WHERE id = 8), (SELECT $node_id FROM Country WHERE id = 9)),
       ((SELECT $node_id FROM Tea WHERE id = 9), (SELECT $node_id FROM Country WHERE id = 1)),
       ((SELECT $node_id FROM Tea WHERE id = 10), (SELECT $node_id FROM Country WHERE id = 1));
GO

INSERT INTO Likes ($from_id, $to_id, rating)
VALUES ((SELECT $node_id FROM Person WHERE id = 1), (SELECT $node_id FROM Tea WHERE id = 3), 10),
       ((SELECT $node_id FROM Person WHERE id = 2), (SELECT $node_id FROM Tea WHERE id = 1), 8),
       ((SELECT $node_id FROM Person WHERE id = 3), (SELECT $node_id FROM Tea WHERE id = 4), 9),
       ((SELECT $node_id FROM Person WHERE id = 4), (SELECT $node_id FROM Tea WHERE id = 4), 7),
       ((SELECT $node_id FROM Person WHERE id = 5), (SELECT $node_id FROM Tea WHERE id = 3), 9),
       ((SELECT $node_id FROM Person WHERE id = 6), (SELECT $node_id FROM Tea WHERE id = 2), 10),
       ((SELECT $node_id FROM Person WHERE id = 7), (SELECT $node_id FROM Tea WHERE id = 2), 10),
       ((SELECT $node_id FROM Person WHERE id = 8), (SELECT $node_id FROM Tea WHERE id = 3), 9),
       ((SELECT $node_id FROM Person WHERE id = 9), (SELECT $node_id FROM Tea WHERE id = 8), 8),
       ((SELECT $node_id FROM Person WHERE id = 10), (SELECT $node_id FROM Tea WHERE id = 7), 9);
GO

--                  ?
SELECT Person1.name, Person2.name AS     
FROM Person AS Person1, FriendOf, Person AS Person2
WHERE MATCH(Person1-(FriendOf)->Person2)
AND Person1.name = N'       ';
GO

--                                    ?
SELECT person2.name AS        , Tea.name AS    , Likes.rating
FROM Person AS person1, Person AS person2, Likes, FriendOf, Tea
WHERE MATCH(person1-(FriendOf)->person2-(Likes)->Tea)
AND person1.name = N'       ';
GO

--              ,                           ?
SELECT Person.name AS        , Tea.name AS    , Likes.rating, Country.name AS       
FROM Person, Likes, Tea, LivesIn, Country, ProducedIn
WHERE MATCH(Person-(Likes)->Tea-(ProducedIn)->Country AND Person-(LivesIn)->Country);
GO

--               ,                              ?
SELECT Person.name AS        , Country.name AS       _          , Tea.name AS    , 
       Likes.rating, Country2.name AS       _            
FROM Person, Likes, Tea, LivesIn, Country, Country AS Country2, ProducedIn
WHERE MATCH(Country<-(LivesIn)-Person-(Likes)->Tea-(ProducedIn)->Country2)
AND Country.name <> Country2.name;
GO

--                                        ?
SELECT person3.name AS        , Tea.name AS    , Likes.rating
FROM Person AS person1, Person AS person2, Person AS person3, Likes, 
     FriendOf AS FriendOf1, FriendOf AS FriendOf2, Tea
WHERE MATCH(person1-(FriendOf1)->person2-(FriendOf2)->person3-(Likes)->Tea)
AND person1.name = N'     ';
GO

--                                      (       "+")SHORTEST_PATH with +
SELECT Person1.name AS        , 
       STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS       
FROM Person AS Person1, FriendOf FOR PATH AS fo, Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
AND Person1.name = N'       ';
GO

--                                   3      (       "{1,3}")SHORTEST_PATH with {1,3}
SELECT Person1.name AS        , 
       STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS       
FROM Person AS Person1, FriendOf FOR PATH AS fo, Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
AND Person1.name = N'         ';
GO


--SQL-                           Power BI
--                (FriendOf)
SELECT 
    p1.id AS IdFirst,
    p1.name AS First,
    CONCAT(N'Person', p1.id) AS [First image name],
    p2.id AS IdSecond,
    p2.name AS Second,
    CONCAT(N'Person', p2.id) AS [Second image name]
FROM Person AS p1
    , FriendOf AS f
    , Person AS p2
WHERE MATCH(p1-(f)->p2);

--                   (Likes)
SELECT 
    p.id AS IdPerson,
    p.name AS Person,
    CONCAT(N'Person', p.id) AS [Person image name],
    t.id AS IdTea,
    t.name AS Tea,
    CONCAT(N'Tea', t.id) AS [Tea image name],
    l.rating AS Rating,
    IIF(t.id IN (
        SELECT t2.id
        FROM Tea AS t2
            , ProducedIn AS pi
            , Country AS c
            , LivesIn AS li
            , Person AS p2
        WHERE MATCH(t2-(pi)->c AND p2-(li)->c)
        AND p2.id = p.id
    ), N'           ', N'             ') AS [Type of country]
FROM Person AS p
    , Likes AS l
    , Tea AS t
WHERE MATCH(p-(l)->t);

--                         

SELECT 
    t.id AS IdTea,
    t.name AS Tea,
    CONCAT(N'Tea', t.id) AS [Tea image name],
    c.id AS IdCountry,
    c.name AS Country,
    CONCAT(N'Country', c.id) AS [Country image name],
    c.continent AS Continent
FROM Tea AS t
    , ProducedIn AS pi
    , Country AS c
WHERE MATCH(t-(pi)->c);


--            (         )
SELECT 
    p1.id AS IdSource,
    p1.name AS Source,
    CONCAT(N'Person', p1.id) AS [Source image name],
    p2.id AS IdTarget,
    p2.name AS Target,
    CONCAT(N'Person', p2.id) AS [Target image name],
    'FriendOf' AS EdgeType,
    NULL AS Weight
FROM Person AS p1
    , FriendOf AS f
    , Person AS p2
WHERE MATCH(p1-(f)->p2)
UNION
SELECT 
    p.id AS IdSource,
    p.name AS Source,
    CONCAT(N'Person', p.id) AS [Source image name],
    c.id AS IdTarget,
    c.name AS Target,
    CONCAT(N'Country', c.id) AS [Target image name],
    'LivesIn' AS EdgeType,
    NULL AS Weight
FROM Person AS p
    , LivesIn AS li
    , Country AS c
WHERE MATCH(p-(li)->c)
UNION
SELECT 
    t.id AS IdSource,
    t.name AS Source,
    CONCAT(N'Tea', t.id) AS [Source image name],
    c.id AS IdTarget,
    c.name AS Target,
    CONCAT(N'Country', c.id) AS [Target image name],
    'ProducedIn' AS EdgeType,
    NULL AS Weight
FROM Tea AS t
    , ProducedIn AS pi
    , Country AS c
WHERE MATCH(t-(pi)->c)
UNION
SELECT 
    p.id AS IdSource,
    p.name AS Source,
    CONCAT(N'Person', p.id) AS [Source image name],
    t.id AS IdTarget,
    t.name AS Target,
    CONCAT(N'Tea', t.id) AS [Target image name],
    'Likes' AS EdgeType,
    l.rating AS Weight
FROM Person AS p
    , Likes AS l
    , Tea AS t
WHERE MATCH(p-(l)->t);

--SELECT @@SERVERNAME
--TeaNetworkGraph
