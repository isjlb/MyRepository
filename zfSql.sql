
DROP DATABASE zufang;

CREATE DATABASE zufang;
USE zufang;

DROP TABLE sys_user;

CREATE TABLE sys_user(
	uid INT PRIMARY KEY AUTO_INCREMENT,
	uName VARCHAR(10) NOT NULL,
	uPassWord VARCHAR(100)
);

INSERT INTO sys_user(uName,uPassWord)
VALUES ('张三','123'),('李四','456'),('王五','456'),('赵六','456'),('张七','456');


CREATE TABLE hos_district(
	did INT PRIMARY KEY AUTO_INCREMENT,
	dName VARCHAR(100) NOT NULL
);

TRUNCATE TABLE hos_district;

INSERT INTO hos_district(dName)
VALUES ('东城区'),('西城区'),('朝阳区'),('海淀区');

DROP TABLE hos_street;
CREATE TABLE hos_street(
	sid INT PRIMARY KEY AUTO_INCREMENT,
	sName VARCHAR(200) NOT NULL,
	sDid INT NOT NULL REFERENCES  hos_district(did)
);

INSERT INTO hos_street(sName,sDid)
VALUES ('中关村',4),('东单',1),('东四',1),('西单',2),('西四',2),('东湖',3),('万泉庄',4),('苏州街',4);

CREATE TABLE hos_type(
	hTid INT PRIMARY KEY AUTO_INCREMENT,
	htName VARCHAR(100) NOT NULL
);

INSERT INTO hos_type(htName)
VALUES ('一室一卫'),('一室一厅'),('两室一卫'),('两室一厅');

CREATE TABLE hos_house(
	hMid INT PRIMARY KEY AUTO_INCREMENT,
	uid INT NOT NULL REFERENCES sys_user(uid),
	sid INT NOT NULL REFERENCES hos_street(sid),
	hTid INT NOT NULL REFERENCES hos_type(hTid),
	price DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	topic VARCHAR(100) NOT NULL,
	contents VARCHAR(200) NOT NULL
);

INSERT INTO hos_house(uid,sid,hTid,price,topic,contents)
VALUES (1,1,1,2000,'中关村','中关村一条街'),
(1,1,2,2500,'中关村','中关村一条街'),
(2,7,1,2000,'万泉庄附近','万泉庄附近一条街'),
(3,2,4,3500,'东单','东单很多美食'),
(4,1,2,2500,'中关村','中关村一条街');


SELECT * FROM hos_district;
SELECT * FROM hos_house;
SELECT * FROM hos_street;
SELECT * FROM hos_type;
SELECT * FROM sys_user;


-- 题目一：
CREATE TABLE tempTab (
	SELECT * FROM hos_house LIMIT 5,5
)

-- 题目二：
CREATE TEMPORARY TABLE tempTab (
	SELECT * FROM hos_house LIMIT 0,6
)

-- 题目三：
SELECT dName,sName,hTid,price,topic,contents FROM hos_house AS hh ,hos_district AS hd ,hos_street AS hs 
WHERE hh.sid=hs.sid AND hs.sDid=hd.did AND hh.uid= (
  SELECT uid FROM sys_user WHERE uName='张三'
)

-- 题目四：
SELECT htName,uName,dName,sName FROM  hos_house AS hh , hos_type AS ht,hos_district AS hd ,hos_street AS hs ,sys_user AS su
WHERE hh.sid=hs.sid AND hs.sDid=hd.did AND hh.hTid=ht.hTid AND su.uid=hh.uid 
AND hs.sDid IN (
	SELECT sDid FROM hos_street 
	GROUP BY sDid HAVING COUNT(sName)>1
)

-- 题目五：
SELECT ' 总计','','',COUNT(hTid) FROM hos_house
UNION
SELECT dName,sName,htName,COUNT(htName) FROM hos_street AS hs , hos_house AS hh,hos_type AS ht ,hos_district AS hd
WHERE hh.sid=hs.sid AND hh.hTid=ht.hTid  AND hs.sDid=hd.did
GROUP BY dName,sName,htName
UNION 
SELECT dName,'小计','',COUNT(htName) FROM hos_street AS hs , hos_house AS hh,hos_type AS ht ,hos_district AS hd
WHERE hh.sid=hs.sid AND hh.hTid=ht.hTid  AND hs.sDid=hd.did
GROUP BY dName 
ORDER BY 1,2,3,4

