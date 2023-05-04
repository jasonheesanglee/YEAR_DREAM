CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20),
type VARCHAR(10)
);

INSERT INTO mypokemon (number, name, type)
VALUES(10, "caterpie", "bug"),
(25, "pikachu", "electric"),
(133, "eevee", "normal");

USE pokemon;
CREATE TABLE mynewpokemon (
번호 INT,
이름 VARCHAR(20),
타입 VARCHAR(10)
);

INSERT INTO mynewpokemon (번호, 이름, 타입)
VALUES(77, "포니타", "불꽃"),
(132, "메타몽", "노말"),
(151, "뮤", "에스퍼");

SELECT * FROM mypokemon;
SELECT * FROM mynewpokemon;

USE pokemon;
ALTER TABLE mypokemon RENAME myoldpokemon;
ALTER TABLE myoldpokemon CHANGE COLUMN name eng_name VARCHAR(20);
ALTER TABLE mynewpokemon CHANGE COLUMN 이름 kor_name VARCHAR(20);

DROP TABLE mynewpokemon;
TRUNCATE TABLE myoldpokemon;

DROP DATABASE IF EXISTS pokemon; 
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20), type varchar(20), height float, weight float, attack float, defense float, speed float
);
INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed) VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90), (26, 'raichu', 'electric', 0.8, 30, 90, 55, 110), (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55), (152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);

SELECT 123 * 456;
SELECT 2310 / 30;
SELECT "피카츄" AS "포켓몬";
SELECT *
FROM mypokemon;
SELECT name
FROM mypokemon;
SELECT name, height, weight
FROM mypokemon;
SELECT DISTINCT height
FROM mypokemon;
SELECT height * 2 AS attact2
FROM mypokemon;
SELECT attack * 2 AS attact2
FROM mypokemon;
SELECT name AS 이름
FROM mypokemon;
SELECT attack AS 공격력,
defense AS 방어력
FROM mypokemon;
SELECT height * 100 AS "height(cm)"
FROM mypokemon;
SELECT *
FROM mypokemon
LIMIT 1;
SELECT name AS 영문명,
height AS "키(m)",
weight AS "몸무게(kg)"
FROM mypokemon
LIMIT 2;

SELECT name,
attack + defense + speed AS total
FROM mypokemon;

SELECT name,
weight / height^2 AS "BMI"
FROM mypokemon;

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20), type varchar(20), height float, weight float, attack float, defense float, speed float
);
INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed) VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90), (26, 'raichu', 'electric', 0.8, 30, 90, 55, 110), (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55), (152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);

SELECT type
FROM mypokemon
WHERE name = "eevee";

SELECT attack, defense
FROM mypokemon
WHERE name = "caterpie";

SELECT *
FROM mypokemon
WHERE weight > 6;

SELECT name
FROM mypokemon
WHERE height > 0.5 AND weight >= 6;

SELECT name AS weak_pokemon
FROM mypokemon
WHERE attack < 50 OR defense < 50;

SELECT *
FROM mypokemon
WHERE type != "normal";

SELECT name, type
FROM mypokemon
-- WHERE type = ("normal" OR "fire" OR "water" OR "grass");
WHERE type IN ('normal', 'fire', 'water', 'grass');

SELECT name, attack
FROM mypokemon
WHERE 40 < attack < 60;

SELECT name
FROM mypokemon
WHERE name LIKE '%e%';

SELECT *
FROM mypokemon
WHERE name LIKE "%i%" AND speed <= 50;

SELECT name, height, weight
FROM mypokemon
WHERE name LIKE "%chu";

SELECT name, defense
FROM mypokemon
WHERE name LIKE "%e" AND defense < 50;

SELECT name, attack, defense
FROM mypokemon
-- WHERE attack-defense >= 10 OR defense-attack >= 10;
WHERE abs(attack-defense)>=10;

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20), type VARCHAR(10), attack INT,
defense INT, capture_date DATE
);
INSERT INTO mypokemon (number, name, type, attack, defense, capture_date) VALUES (10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
(25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
(26, 'raichu', 'electric', 90, 55, '2019-05-28'), (125, 'electabuzz', 'electric', 83, 57, '2020-12-29'),
(133, 'eevee', 'normal', 55, 50, '2021-10-03'), (137, 'porygon', 'normal', 60, 70, '2021-01-16'), (152, 'chikoirita', 'grass', 49, 65, '2020-03-05'),
(153, 'bayleef', 'grass', 62, 80, '2022-01-01');



SELECT RIGHT(name,3) AS "last_char"
FROM mypokemon;

SELECT LEFT(name, 2) AS "left2"
FROM mypokemon;

SELECT REPLACE(name, "o", "O") AS "bigO"
FROM mypokemon
WHERE name LIKE "%o%";

SELECT name, UPPER(CONCAT(LEFT(type, 1), RIGHT(type, 1))) AS "type_code"
FROM mypokemon;

SELECT *
FROM mypokemon
WHERE length(name) > 8;

SELECT CEILING(AVG(attack)) AS "avg_of_attack"
FROM mypokemon;

SELECT FLOOR(AVG(defense)) AS "avg_of_defense"
FROM mypokemon;

SELECT name, POWER(attack, 2) AS "attack2"
FROM mypokemon
WHERE length(name) < 8;

SELECT name, MOD(attack, 2) AS "div2"
FROM mypokemon;

SELECT name, ABS(attack - defense) AS "diff"
FROM mypokemon
WHERE attack <= 50;

SELECT CURRENT_DATE() AS now_date,
CURRENT_TIME() AS now_time;

SELECT MONTH(capture_date) AS month_num,
MONTHNAME(capture_date) AS month_eng
FROM mypokemon;

SELECT DAYOFMONTH(capture_date) AS day_num,
DAYNAME(capture_date) AS day_eng
FROM mypokemon;

SELECT YEAR(capture_date) AS "year",
MONTH(capture_date) AS "month",
dayofmonth(capture_date) AS "day"
FROM mypokemon;

DROP DATABASE IF EXISTS pokemon;

CREATE DATABASE pokemon;
USE pokemon;

CREATE TABLE mypokemon (
    number int,
    name varchar(20),
    type varchar(10),
    height float,
    weight float
);

INSERT INTO mypokemon (number, name, type, height, weight)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9),
    (25, 'pikachu', 'electric', 0.4, 6),
    (26, 'raichu', 'electric', 0.8, 30),
    (125, 'electabuzz', 'electric', 1.1, 30),
    (133, 'eevee', 'normal', 0.3, 6.5),
    (137, 'porygon', 'normal', 0.8, 36.5),
    (152, 'chikoirita', 'grass', 0.9, 6.4),
    (153, 'bayleef', 'grass', 1.2, 15.8),
    (172, 'pichu', 'electric', 0.3, 2),
    (470, 'leafeon', 'grass', 1, 25.5); 

SELECT * FROM mypokemon;

-- 1. 포켓몬 테이블에서 평균 키가 0.6 이하인 타입의 타입과 평균 키, 평균 몸무게, 그리고 최고 키, 최대 몸무게를 가져와 주세요. 이 때 키와 몸무게는 소수점 첫째자리까지 반올림해서 가져와 주세요.


SELECT type, ROUND(AVG(height),1) AS avg_h, ROUND(AVG(weight), 1) AS avg_w, MAX(height) AS tallest, MAX(weight) AS heaviest
FROM mypokemon GROUP BY type
HAVING AVG(height) <= 0.6;

-- 2. 포켓몬 테이블에서 이름의 알파벳 갯수가 8개 이상인 포켓몬의 이름과 키, 몸무게를 번호 순서대로 정렬해 가져와 주세요.

SELECT name, height, weight
FROM mypokemon
WHERE LENGTH(name) >= 8
ORDER BY number;

-- 문제3. 포켓몬 테이블에서 포켓몬들의 몸무게의 총합이 제일 큰 타입을 가져와 주세요.

SELECT type, sum(weight) AS total_weight
FROM mypokemon
GROUP BY type
ORDER BY total_weight
LIMIT 5;

-- 문제4. 포켓몬 테이블에서 이름의 길이가 5보다 큰 포켓몬들을 타입을 기준으로 그룹화하고, 몸무게의 평균이 20 이상인 그룹의 타입과, 몸무게의 평균을 가져와 주세요.
-- 이 때, 결과는 몸무게의 평균을 내림차순으로 정렬해 주세요.

SELECT type, AVG(weight)
FROM mypokemon
WHERE length(name) > 5
GROUP BY type
HAVING AVG(weight) >= 20
ORDER BY type desc;

-- 문제5. 포켓몬 테이블에서 번호가 200보다 작은 포켓몬들을 타입을 기준으로 그룹화한 후에,
-- 몸무게의 최댓값이 10보다 크거나 같고 최솟값은 2보다 크거나 같은 그룹의 타입, 키의 최솟값, 최댓값을 가져와 주세요.
-- 이 때, 결과는 키의 최솟값의 내림차순으로 정렬해 주시고, 만약 키의 최솟값이 같다면 키의 최댓값의 내림차순으로 정렬해주세요.

SELECT type, MIN(height), MAX(height)
FROM mypokemon
WHERE number < 200
GROUP BY type
HAVING MAX(weight) >= 10 OR MIN(weight) >= 2
ORDER BY MIN(height),
RANK() OVER(ORDER BY MAX(height) DESC);


DROP DATABASE IF EXISTS pokemon; 
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int, name varchar(20), type varchar(10), height float, weight float
);
INSERT INTO mypokemon (number, name, type, height, weight) VALUES (10, 'caterpie', 'bug', 0.3, 2.9),
(25, 'pikachu', 'electric', 0.4, 6), (26, 'raichu', 'electric', 0.8, 30),
(125, 'electabuzz', 'electric', 1.1, 30), (133, 'eevee', 'normal', 0.3, 6.5),
(137, 'porygon', 'normal', 0.8, 36.5), (152, 'chikoirita', 'grass', 0.9, 6.4),
(153, 'bayleef', 'grass', 1.2, 15.8), (172, 'pichu', 'electric', 0.3, 2), (470, 'leafeon', 'grass', 1, 25.5);

SELECT type, AVG(height)
FROM mypokemon
GROUP BY type;

SELECT type, AVG(weight)
FROM mypokemon
GROUP BY type;

SELECT type, AVG(height), AVG (weight)
FROM mypokemon
GROUP BY type;

SELECT type, AVG(height)
FROM mypokemon
GROUP BY type
HAVING AVG(height) >= 0.5;

SELECT type, AVG(weight)
FROM mypokemon
GROUP BY type
HAVING AVG(weight) >= 20;

SELECT type, SUM(number)
FROM mypokemon
GROUP BY type;

SELECT type, COUNT(height >= 0.5) AS tall_pokemon
FROM mypokemon
GROUP BY type;

SELECT type, MIN(height)
FROM mypokemon
GROUP BY type;

SELECT type, MAX(weight)
FROM mypokemon
GROUP BY type;

SELECT type
FROM mypokemon
GROUP BY type
HAVING MIN(height) > 0.5 AND MAX(weight) < 30;

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20), type varchar(10), attack int, defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense) VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40),
(26, 'raichu', 'electric', 90, 55), (125, 'electabuzz', 'electric', 83, 57),
(133, 'eevee', 'normal', 55, 50), (137, 'porygon', 'normal', 60, 70),
(152, 'chikoirita', 'grass', 49, 65), (153, 'bayleef', 'grass', 62, 80), (172, 'pichu', 'electric', 40, 15), (470, 'leafeon', 'grass', 110, 130);

SELECT name, type,
IF(number < 150, "old", "new") AS age
FROM mypokemon;

SELECT name, type,
IF((attack + defense) < 100, "weak", "strong") AS ability
FROM mypokemon;

SELECT type, IF(AVG(attack) >= 60, "True(1)", "False(0)") AS "is_strong_type"
FROM mypokemon
GROUP BY type;

SELECT name, type, 
IF(attack > 100 AND defense > 100, "TRUE(1)", "FALSE(0)") AS "ace"
FROM mypokemon;

SELECT name, type,
CASE
WHEN number < 100 THEN "< 100"
WHEN number < 200 THEN "< 200"
WHEN number < 500 THEN "< 500"
ELSE null
END AS "number_bin"
FROM mypokemon;

SELECT name,
CASE
WHEN number >= 150 AND attack >= 50 THEN "new_strong"
WHEN number < 150 AND attack >= 50 THEN "old_strong"
WHEN number >= 150 AND attack < 50 THEN "new_weak"
WHEN number < 150 AND attack < 50 THEN "old_weak"
ELSE null
END AS "age_attack"
FROM mypokemon
GROUP BY name, number, attack;

SELECT type,COUNT(type) AS "COUNT",
CASE
WHEN COUNT(type) = 1 THEN "solo"
WHEN COUNT(type) < 3 THEN "minor"
WHEN COUNT(type) >= 3 THEN "major"
ELSE null
END AS "count_by_type"
FROM mypokemon
GROUP BY type;

--

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20), type VARCHAR(10)
);
INSERT INTO mypokemon (number, name, type) VALUES (10, 'caterpie', 'bug'),
(25, 'pikachu', 'electric'), (26, 'raichu', 'electric'), (133, 'eevee', 'normal'), (152, 'chikoirita', 'grass');
CREATE TABLE ability ( number INT,
height FLOAT, weight FLOAT, attack INT, defense INT, speed int
);
INSERT INTO ability (number, height, weight, attack, defense, speed) VALUES (10, 0.3, 2.9, 30, 35, 45),
(25, 0.4, 6, 55, 40, 90), (26, 0.8, 30, 90, 55, 110),
(133, 0.3, 6.5, 55, 50, 55), (137, 0.8, 36.5, 60, 70, 40),
(152, 0.9, 6.4, 49, 65, 45), (153, 1.2, 15.8, 62, 80, 60), (172, 0.3, 2, 40, 15, 60), (470, 1, 25.5, 110, 130, 95);

SELECT type
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY type;

SELECT type, AVG(height)
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY type;

SELECT type, AVG(weight)
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY type;

SELECT type, AVG(height), AVG(weight)
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY type;

SELECT mypokemon.number, name, attack, defense
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
WHERE mypokemon.number >= 100
GROUP BY mypokemon.number, name, attack, defense;

SELECT name, attack + defense AS AD
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY name, attack, defense
ORDER BY (attack+defense) DESC;

SELECT name, speed
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number
GROUP BY name, speed
ORDER BY (speed) DESC
LIMIT 1;

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
           number  INT,
       name        VARCHAR(20),
       type        VARCHAR(10)
);
INSERT INTO mypokemon (number, name, type)
VALUES (10, 'caterpie', 'bug'),
	   (25, 'pikachu', 'electric'),
       (26, 'raichu', 'electric'),
       (133, 'eevee', 'normal'),
       (152, 'chikoirita', 'grass');
CREATE TABLE ability (
           number INT,
       height FLOAT,
       weight FLOAT,
       attack INT,
       defense INT,
       speed int
);
INSERT INTO ability (number, height, weight, attack, defense, speed)
VALUES (10, 0.3, 2.9, 30, 35, 45),
	   (25, 0.4, 6, 55, 40, 90),
       (125, 1.1, 30, 83, 57, 105),
	   (133, 0.3, 6.5, 55, 50, 55),
       (137, 0.8, 36.5, 60, 70, 40),
	   (152, 0.9, 6.4, 49, 65, 45),
       (153, 1.2, 15.8, 62, 80, 60),
       (172, 0.3, 2, 40, 15, 60),
       (470, 1, 25.5, 110, 130, 95);
       
-- 데일리 1

SELECT name, attack, defense
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number;

SELECT mypokemon.number, name
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number;

-- 데일리 2

SELECT IF(mypokemon.number = ability.number, mypokemon.number, mypokemon.number) AS wrong_answer, name
FROM mypokemon
LEFT JOIN ability
ON mypokemon.number = ability.number
GROUP BY mypokemon.number, ability.number, name
UNION
SELECT IF(mypokemon.number = ability.number, mypokemon.number, ability.number) AS wrong_answer, name
FROM mypokemon
RIGHT JOIN ability
ON mypokemon.number = ability.number
GROUP BY mypokemon.number, ability.number, name;

SELECT ability.number, name
FROM mypokemon
RIGHT JOIN ability
ON mypokemon.number = ability.number;

-- 데일리 3

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
           number  INT,
       name        VARCHAR(20)
);
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
           (25, 'pikachu'),
       (26, 'raichu'),
       (133, 'eevee'),
       (152, 'chikoirita');
CREATE TABLE ability (
           number INT,
           type        VARCHAR(10),
       height FLOAT,
       weight FLOAT,
       attack INT,
       defense INT,
       speed int
);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
           (25, 'electric', 0.4, 6, 55, 40, 90),
       (26, 'electric', 0.8, 30, 90, 55, 110),
           (133, 'normal', 0.3, 6.5, 55, 50, 55),
           (152, 'grass', 0.9, 6.4, 49, 65, 45);

SELECT name, height, weight
FROM mypokemon, ability
WHERE mypokemon.number = 133 AND ability.number = 133
GROUP BY name, height, weight;

SELECT number, speed
FROM (SELECT number, speed, RANK() OVER(ORDER BY speed DESC) AS speed_rank FROM ability) AS A
WHERE speed_rank = 2;

SELECT name
FROM mypokemon
WHERE number IN (SELECT number FROM ability WHERE defense > ALL(SELECT defense FROM ability WHERE type = 'electric'));


DROP DATABASE IF EXISTS pokemon; 
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20),
type varchar(10), attack int, defense int
);
CREATE TABLE friendpokemon (
number int,
name varchar(20), type varchar(10), attack int,
defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense) VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40), (26, 'raichu', 'electric', 90, 55),
(133, 'eevee', 'normal', 55, 50), (152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense) VALUES (26, 'raichu', 'electric', 80, 60),
(125, 'electabuzz', 'electric', 83, 57), (137, 'porygon', 'normal', 60, 70), (153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);

SELECT type
FROM mypokemon
UNION
SELECT type
FROM friendpokemon;

SELECT number, name, type
FROM mypokemon
WHERE type = "grass"
UNION ALL
SELECT number, name, type
FROM friendpokemon
WHERE type = "grass";

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number int,
name varchar(20),
type varchar(10), attack int, defense int
);
CREATE TABLE friendpokemon (
number int,
name varchar(20), type varchar(10), attack int,
defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense) VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40), (26, 'raichu', 'electric', 90, 55),
(133, 'eevee', 'normal', 55, 50), (152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense) VALUES (26, 'raichu', 'electric', 80, 60),
(125, 'electabuzz', 'electric', 83, 57), (137, 'porygon', 'normal', 60, 70), (153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);

SELECT my.name
FROM mypokemon as my
INNER JOIN friendpokemon as friend
ON my.name = friend.name;

SELECT my.name
FROM mypokemon as my
LEFT JOIN friendpokemon as friend
ON my.name = friend.name
WHERE friend.name IS NULL;

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
number INT,
name VARCHAR(20)
);
INSERT INTO mypokemon (number, name) VALUES (10, 'caterpie'),
(25, 'pikachu'), (26, 'raichu'), (133, 'eevee'), (152, 'chikoirita');
CREATE TABLE ability ( number INT,
type VARCHAR(10), height FLOAT,
weight FLOAT,
attack INT,
defense INT,
speed int );
INSERT INTO ability (number, type, height, weight, attack, defense, speed) VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'electric', 0.4, 6, 55, 40, 90), (26, 'electric', 0.8, 30, 90, 55, 110),
(133, 'normal', 0.3, 6.5, 55, 50, 55), (152, 'grass', 0.9, 6.4, 49, 65, 45);

SELECT number
FROM ability
WHERE weight = (SELECT MAX(weight) FROM ability);


SELECT number 
FROM ability
WHERE speed < ANY(SELECT attack FROM ability WHERE type = "electric");

SELECT name
FROM mypokemon AS my, ability AS ab
WHERE attack > defense
GROUP BY name;

SELECT name
FROM mypokemon
WHERE EXISTS (SELECT * FROM ability WHERE attack > defense);


SELECT name
FROM mypokemon AS my, ability AS ab
WHERE attack > defense;
-- GROUP BY name

CREATE TABLE T1 (COL1 VARCHAR(20), COL2 INT);
INSERT INTO T1 (COL1, COL2) VALUES('ABCD', 123);
INSERT INTO T1 (COL1, COL2) VALUES('BC', NULL);
INSERT INTO T1 (COL1) VALUES('FFF');
ALTER TABLE T1 ADD COLUMN COL3 FLOAT;
INSERT INTO T1(COL3) VALUES(0.123);
INSERT INTO T1(COL1, COL2, COL3) VALUES('XY', 5, 10.5);
DELETE FROM T1 WHERE COL2 > 10;
SELECT COUNT(COL2) FROM T1;

SELECT 1;
SELECT LOCATE('A', 'ABC');
SELECT LENGTH('A');
SELECT MOD(2, 1);

create table TB (COL1 varchar(20), COL2 INT);
INSERT INTO TB (COL1, COL2) VALUES('ABC', 2);
INSERT INTO TB (COL1, COL2) VALUES('APP', 15);
INSERT INTO TB (COL1, COL2) VALUES('APPLE', 100);
INSERT INTO TB (COL1, COL2) VALUES('ASIA', 75);
INSERT INTO TB (COL1, COL2) VALUES('WAPPEN', 5);

SELECT SUM(COL2)
FROM TB
WHERE COL1 LIKE 'APP%' OR '_A';



