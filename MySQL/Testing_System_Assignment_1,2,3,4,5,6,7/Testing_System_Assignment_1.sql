DROP DATABASE IF EXISTS VIDU2;
CREATE DATABASE VIDU2;
USE VIDU2;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName			NVARCHAR(30) NOT NULL
);
DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,	
	PositionName			ENUM('Dev','Test','Scrum Master','PM') not null
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Email				NVARCHAR(50) NOT NULL UNIQUE KEY ,
    Username			VARCHAR(50) NOT NULL  UNIQUE KEY,
    FullName			VARCHAR(30) NOT NULL,
    DepartmentID		TINYINT UNSIGNED NOT NULL,
    PositionID			TINYINT UNSIGNED NOT NULL,
    CreateDate			DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	GroupName		NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID			TINYINT UNSIGNED NOT NULL,
	AccountID		TINYINT UNSIGNED NOT NULL,
    JoinDate		DATETIME DEFAULT NOW(),
    PRIMARY KEY(GroupID,AccountID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID)
);
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	TypeName		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName	NVARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE,
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId) ON DELETE CASCADE 
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,		
	Content				NVARCHAR(100) NOT NULL,
    QuestionID			TINYINT UNSIGNED NOT NULL,
    isCorrect			BIT DEFAULT 1,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,	
	`Code`			CHAR(10) NOT NULL,
    Title			NVARCHAR(50) NOT NULL,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		NVARCHAR(20) NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID)ON DELETE CASCADE
);
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID			TINYINT UNSIGNED NOT NULL,	
	QuestionID		TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(ExamID,QuestionID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)ON DELETE CASCADE,
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID)ON DELETE CASCADE
);
INSERT INTO Department	(DepartmentName)
VALUES					(N'sale'),
						(N'marketing'),
                        (N'g??am ?????c'),
                        (N'b???o v???'),
                        (N'Dev'),
                        (N'Test'),
                        (N'ch???'),
                        (N'ngh???'),
                        (N'PM'),
                        (N'v??? sinh');
SELECT *FROM Department;
INSERT INTO Position	(PositionName)
VALUES					('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
SELECT*FROM    Position;
INSERT INTO `Account`	(Email,							Username,				FullName,		DepartmentID,		PositionID)
VALUES					(N'daothanhnam@gmail.com',		'nama',					'daoquanghoa',		1,				2),
						(N'daoquanghoa1@gmail.com',		'an',					'daoquanghan',		2,				2),
                        (N'daoquanghoa2@gmail.com',		'trang',				'daoquanglinh',		3,				4),
                        (N'daoquanghoa3@gmail.com',		'linh',					'daoquangtuan',		10,				3),
						(N'daoquanghoa47@gmail.com',		'lan',					'daoquanglan',		9,				1),
						(N'daoquanghoa53gmail.com',		'liem',					'daoquangliem',		7,				4),
						(N'daoquanghoa39@gmail.com',		'dung',					'daoquangdung',		6,				2),
						(N'daoquanghoa37@gmail.com',		'hai',					'daoquanghai',		8,				3),
						(N'daoquanghoa35@gmail.com',		'nga',					'daoquangnga',		4,					3),
                        (N'daoquanghoa4@gmail.com',		'thanh',				'daoquangthna',		5,				1);
SELECT*FROM `Account`;
INSERT INTO `Group`		(GroupName,				CreatorID,			CreateDate)
VALUES					('Nhom1',				1,					'2020-7-20'),
						('Nhom3',				5,					'2021-7-21'),
                        ('Nhom2',				3,					'2021-7-22'),
                        ('Nhom6',				10,					'2021-7-22'),
                        ('Nhom7',				9,					'2021-7-22'),
                        ('Nhom8',				7,					'2021-7-22'),
                        ('Nhom9',				6,					'2021-7-22'),
                        ('Nhom10',				8,					'2021-7-22'),
                        ('Nhom5',				5,					'2020-7-25'),
                        ('Nhom4',				4,					'2020-7-28');
SELECT*FROM `Group`;
INSERT INTO GroupAccount	(GroupID,		AccountID,			JoinDate)
VALUES						(1,				3,					'2020-7-20'),
							(2,				4,					'2021-7-20'),
                            (5,				1,					'2022-7-20'),
                            (4,				2,					'2023-7-20'),
                            (10,			6,				'2021-7-20'),
                            (9,				8,					'2021-7-20'),
                            (8,				9,					'2021-7-20'),
                            (7,				7,					'2021-7-20'),
                            (6,				4,					'2021-7-20'),
                            (3,				5,					'2024-7-20');
SELECT*FROM GroupAccount;
INSERT INTO TypeQuestion	(TypeName)
VALUES						('Essay'),
							('Multiple-Choice');
SELECT*from TypeQuestion;
INSERT INTO CategoryQuestion	(CategoryName)
VALUES							('Hoi Java'),
								('Hoi .NET'),
                                ('Hoi SQl'),
                                ('Hoi SQl1'),
                                ('Hoi SQl2'),
                                ('Hoi SQl3'),
                                ('Hoi SQl4'),
                                ('Hoi SQ6'),
                                ('Hoi Postman'),
								('Hoi ruby');
                                
SELECT*from CategoryQuestion;
INSERT INTO Question	(Content,				CategoryID,		TypeID,		CreatorID)		
VALUES					('ND cau hoi Java',			1,				1,			3),
						('ND cau hoi .NET',			5,				2,			5),
                        ('ND cau hoi SQl',			4,				1,			1),
                        ('ND cau hoi SQl1',			10,				2,			10),
                        ('ND cau hoi SQl2',			8,				1,			8),
                        ('ND cau hoi SQl3',			9,				2,			7),
                        ('ND cau hoi SQl4',			7,				2,			9),
                        ('ND cau hoi SQl6',			6,				1,			6),
                        ('ND cau hoi Postman',		3,				2,			2),
                        ('ND cau hoi ruby',			2,				1,			4);

SELECT*from Question;
INSERT INTO Answer		(Content,			QuestionID,			isCorrect)
VALUES					(N'c??u trl Java',		1,					0),
						(N'c??u trl .NET',		5,					1),
                        (N'c??u trl SQl',			3,					0),
                        (N'c??u trl SQl1',		4,					1),
                        (N'c??u trl SQl2',		10,					0),
                        (N'c??u trl SQl3',		9,					1),
                        (N'c??u trl SQl4',		7,					0),
                        (N'c??u trl SQl6',		8,					1),
                        (N'c??u trl Postman',		6,					0),
                        (N'c??u trl ruby',		2,					1);
SELECT*from Answer;
INSERT INTO Exam		(`Code`,		Title,				CategoryID,		Duration,	CreatorID)
VALUES					('VTIQ001',		'de thi java',			1,				60,				1),
						('VTIQ002',		'de thi .NET',		2,				60,				2),
                        ('VTIQ003',		'de thi SQl',		5,				120,				4),
                        ('VTIQ004',		'de thi SQl2',		10,				60,				7),
                        ('VTIQ006',		'de thi SQl3',		9,				60,				9),
                        ('VTIQ007',		'de thi SQl4',		8,				120,				8),
                        ('VTIQ008',		'de thiSQl6',		7,				60,				10),
                        ('VTIQ009',		'de thi SQl7',		6,				120,				6),
                        ('VTIQ0010',	'de thi ruby',		4,				60,				5),
                        ('VTIQ005',		'de thi Postman',		3,				120,				3);
SELECT*from Exam;                        
INSERT INTO ExamQuestion	(ExamID,QuestionID)
VALUES						(1,3),	
							(5,4),
                            (8,10),
                            (6,9),
                            (9,8),
                            (7,7),
                            (10,6),
                            (2,5),
                            (4,1),
                            (3,2);
SELECT*from ExamQuestion;


-- / //////////////////////////////////Testing_System_Assignment_3////////////////////////// 
-- Question 2: l???y ra t???t c??? c??c ph??ng ban
SELECT*FROM department; 
-- Question 3: l???y ra id c???a ph??ng ban "Sale"
SELECT DepartmentID FROM department where departmentname=N'sale';
-- Question 4: l???y ra th??ng tin account c?? full name d??i nh???t
SELECT * from `account` where LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`) ORDER BY fullname DESC ;
-- Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3
WITH cte_dep3 AS
(
	SELECT * FROM `Account` WHERE DepartmentID =3
)
SELECT * FROM `cte_dep3` 
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `cte_dep3`) 
ORDER BY Fullname ASC;
-- Question 6: L???y ra t??n group ???? t???o tr?????c ng??y 20/12/2019
SELECT groupname FROM `GROUP` WHERE Createdate<'2019-12-20';
-- Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
-- 1. ?????m s??? c??u tr??? l???i cho t???ng c??u h???i 
-- 2.t??m ra c??u h???i  c?? >=4 c??u tr??? l???i 
select *from answer; 
SELECT a.questionid,q.content ,count(a.questionid) from answer a
INNER join question q ON a.questionid=q.questionid
GROUP BY questionid
HAVING count(a.questionid)>=4;
-- Question 8: L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
SELECT `code` FROM Exam where duration>=60 and createdate<'2019-12-20';
-- Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t
SELECT *from `group` order by createdate DESC LIMIT 5;
-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT departmentID, COUNT(AccountID) AS SL FROM `Account` WHERE DepartmentID = 2;
-- Question 11:L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
SELECT 		Fullname FROM `Account` WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;
-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019 
DELETE from exam WHERE createdate<'2019-12-20';
-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
DELETE FROM `question` WHERE (SUBSTRING_INDEX(Content,' ',2)) ='c??u h???i';
-- Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh: loc.nguyenba@vti.com.vn
UPDATE 		`Account` 
SET 		Fullname 	= 	N'Nguy???n B?? L???c', 
			Email 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;
-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE `groupaccount`
SET groupid=4
where accountid=5;

-- ///////////////////////////// Testing_System_Assignment_4////////////////////////
--  Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???
SELECT 		a.Email, a.Username	, a.FullName, d.DepartmentName
FROM 		`Account` a 
INNER JOIN 	Department d ON 	a.DepartmentID = d.DepartmentID;
-- Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010
SELECT*FROM	`Account` WHERE	CreateDate < '2020-12-20';
-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer
SELECT a.FullName, a.Email, p.PositionName
FROM `Account` a 
INNER JOIN 	Position p ON a.PositionID = p.PositionID
WHERE p.PositionName = 'Dev';
-- Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n
SELECT d.DepartmentName, count(a.DepartmentID)  SL  FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(A.DepartmentID) >3;
-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t
SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues)  maxcountQues FROM (
SELECT COUNT(E.QuestionID)  countQues FROM examquestion E
	GROUP BY E.QuestionID)  countTable);
-- Question 6: Th??ng k?? m???i Category Question ???????c s??? d???ng trong bao nhi??u Question
SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) SL FROM categoryquestion cq 
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;
-- Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam
SELECT q.QuestionID, q.Content , count(eq.QuestionID) SL FROM examquestion eq
RIGHT JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;
-- Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t
SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);
-- Question 9: Th???ng k?? s??? l?????ng account trong m???i group
SELECT		g.GroupID, COUNT(ga.AccountID)  'SO LUONG'
FROM		GroupAccount ga 
JOIN 	`Group` g ON	ga.GroupID = g.GroupID
GROUP BY	g.GroupID
ORDER BY	g.GroupID ASC;
-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t
SELECT a.positionid,count(a.positionid) SL from `account` a 
INNER JOIN position p ON p.positionid =a.positionid
GROUP BY a.positionid
having count(a.positionid)=(select min(SL) from(select count(a1.positionid) as SL from `account` a1 group by a1.positionid) as tmp_1); 
-- Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM
SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) SL FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;
-- Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ???
SELECT q.QuestionID, q.Content NDcauhoi, a.FullName, tq.TypeName typename, ANS.Content NDcautrl FROM question Q
INNER JOIN categoryquestion cq ON q.CategoryID = cq.CategoryID
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
INNER JOIN account a ON a.AccountID = q.CreatorID
INNER JOIN 	Answer AS ANS ON	q.QuestionID = ANS.QuestionID
ORDER BY q.QuestionID ASC;
-- Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m
SELECT tq.TypeID, tq.TypeName, COUNT(q.TypeID)  SL FROM question q
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;
-- Question 14:L???y ra group kh??ng c?? account n??o
SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;
-- Question 15: L???y ra group kh??ng c?? account n??o
SELECT *from groupaccount ga
right join  `group` g on ga.groupid=g.groupid
where ga.groupid is null;
-- Question 16: L???y ra question kh??ng c?? answer n??o
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID 
WHERE a.AnswerID IS NULL; 
-- /////////////////////////Testing_System_Assignment_5//////////////////
-- Question 1: T???o view c?? ch???a danh s??ch nh??n vi??n thu???c ph??ng ban sale
create or replace view vw_listsale as
SELECT a.email,a.fullname, d.departmentname  FROM `account`a
INNER JOIN department d on a.departmentid=d.departmentid
WHERE d.departmentname='sale'; 
-- Question 2: T???o view c?? ch???a th??ng tin c??c account tham gia v??o nhi???u group nh???t 
CREATE OR REPLACE VIEW vw_GetAccount AS
WITH CTE_GetListCountAccount AS(
SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
    GROUP BY GA1.AccountID
    )
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM CTE_GetListCountAccount
);
SELECT * FROM vw_GetAccount;
-- Question 3: T???o view c?? ch???a c??u h???i c?? nh???ng content qu?? d??i (content qu?? 300 t???  ???????c coi l?? qu?? d??i) v?? x??a n?? ??i
create or replace view vw_listquestion as
SELECT*FROM question
where length(content)>14;
DELETE FROM vw_listquestion;
-- Question 4: T???o view c?? ch???a danh s??ch c??c ph??ng ban c?? nhi???u nh??n vi??n nh???t.
CREATE OR REPLACE VIEW vw_MaxNV
AS
SELECT D.DepartmentName, count(A.DepartmentID) AS SL 
FROM account A
INNER JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT MAX(countDEP_ID) AS maxDEP_ID FROM 
(SELECT count(A1.DepartmentID) AS countDEP_ID FROM account A1
GROUP BY A1.DepartmentID) AS TB_countDepID);

SELECT * FROM vw_MaxNV;
-- Question 5: T???o view c?? ch???a t???t c??c c??c c??u h???i do user h??? Nguy???n t???o
CREATE OR REPLACE VIEW vw_Que5
AS
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID 
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguy???n';

SELECT * FROM vw_Que5;
-- /////////////////////////Testing_System_Assignment_6//////////////////
-- question1 
DROP PROCEDURE IF EXISTS sp_GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep(IN namedep VARCHAR(30))
BEGIN
	SELECT a.email,a.fullname, d.departmentname  FROM `account`a
	INNER JOIN department d on a.departmentid=d.departmentid
	WHERE d.departmentname=namedep; 
END$$
DELIMITER ;
call vidu2.sp_GetAccFromDep('marketing');
-- Question 2: T???o store ????? in ra s??? l?????ng account trong m???i group
DROP PROCEDURE IF EXISTS sp_GetCountAccFromGroup;
DELIMITER $$
CREATE PROCEDURE sp_GetCountAccFromGroup(IN in_group_name NVARCHAR(50))
BEGIN
	SELECT g.GroupName, count(ga.AccountID) AS SL FROM groupaccount ga
	INNER JOIN `group` g ON ga.GroupID = g.GroupID
	WHERE g.GroupName = in_group_name;
END$$
DELIMITER ;
Call sp_GetCountAccFromGroup('Testing System');
-- Question 3: T???o store ????? th???ng k?? m???i type question c?? bao nhi??u question ???????c t???o trong th??ng hi???n t???i
DROP PROCEDURE IF EXISTS sp_GetCountTypeInMonth;
DELIMITER $$
CREATE PROCEDURE sp_GetCountTypeInMonth()
BEGIN
SELECT tq.TypeName, count(q.TypeID) FROM question q
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
GROUP BY q.TypeID;
END$$
DELIMITER ;
Call sp_GetCountTypeInMonth();
-- Question 4: T???o store ????? tr??? ra id c???a type question c?? nhi???u c??u h???i nh???t
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE sp_GetCountQuesFromType()
BEGIN
	WITH CTE_MaxTypeID AS(
		SELECT count(q.TypeID) AS SL FROM question q
		GROUP BY q.TypeID	
		)
	SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
	INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
	GROUP BY q.TypeID
    HAVING count(q.TypeID) = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;
Call sp_GetCountQuesFromType();
-- Question 5: S??? d???ng store ??? question 4 ????? t??m ra t??n c???a type question
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
CREATE PROCEDURE sp_GetCountQuesFromType()
BEGIN
	WITH CTE_MaxTypeID AS(
		SELECT count(q.TypeID) AS SL FROM question q
		GROUP BY q.TypeID	
		)
	SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
	INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
	GROUP BY q.TypeID
	HAVING count(q.TypeID) = (SELECT MAX(SL) FROM CTE_MaxTypeID);
END$$
DELIMITER ;

Call sp_GetCountQuesFromType();
SET @ID =0;
Call sp_GetCountQuesFromType(@ID);
SELECT * FROM typequestion WHERE TypeID = @ID;
-- Question 6: Vi???t 1 store cho ph??p ng?????i d??ng nh???p v??o 1 chu???i v?? tr??? v??? group c?? t??n ch???a chu???i c???a ng?????i d??ng nh???p v??o ho???c tr??? v??? user c?? username ch???a chu???i c???a ng?????i d??ng nh???p v??o
DROP PROCEDURE IF EXISTS sp_getNameAccOrNameGroup;
DELIMITER $$
CREATE PROCEDURE sp_getNameAccOrNameGroup
( IN var_String VARCHAR(50)
)
BEGIN
		SELECT g.GroupName FROM `group` g WHERE g.GroupName LIKE CONCAT("%",var_String,"%")
		UNION
		SELECT a.Username FROM `account` a WHERE a.Username LIKE CONCAT("%",var_String,"%");
END$$
DELIMITER ;
Call sp_getNameAccOrNameGroup('s');
-- Question 7: Vi???t 1 store cho ph??p ng?????i d??ng nh???p v??o th??ng tin fullName, email v?? trong store s??? t??? ?????ng g??n:.....
DROP PROCEDURE IF EXISTS sp_insertAccount;
DELIMITER $$
CREATE PROCEDURE sp_insertAccount
(	IN var_Email VARCHAR(50),
	IN var_Fullname VARCHAR(50))
BEGIN
	DECLARE v_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(var_Email, '@', 1);
	DECLARE v_DepartmentID  TINYINT UNSIGNED DEFAULT 11;
	DECLARE v_PositionID TINYINT UNSIGNED DEFAULT 1;
                  DECLARE v_CreateDate DATETIME DEFAULT now();
	INSERT INTO `account` (`Email`,		 `Username`, 	`FullName`, 		`DepartmentID`,			 `PositionID`, 			`CreateDate`) 
	VALUES 				  (var_Email,     v_Username,      var_Fullname,          v_DepartmentID,          v_PositionID,         v_CreateDate);

END$$
DELIMITER ;
Call sp_insertAccount('daonq@viettel.com.vn','Nguyen dao');
-- Question 9: Vi???t 1 store cho ph??p ng?????i d??ng x??a exam d???a v??o ID B???ng Exam c?? li??n k???t kh??a ngo???i ?????n b???ng examquestion v?? v???y tr?????c khi x??a d??? li???u trong b???ng exam c???n x??a d??? li???u trong b???ng examquestion tr?????c
DROP PROCEDURE IF EXISTS sp_DeleteExamWithID;
DELIMITER $$
CREATE PROCEDURE sp_DeleteExamWithID (IN in_ExamID TINYINT UNSIGNED)
BEGIN
	DELETE FROM examquestion WHERE	ExamID = in_ExamID;
	DELETE FROM Exam WHERE	ExamID = in_ExamID;	
END$$
DELIMITER ;
CALL sp_DeleteExamWithID(7);
-- Question 10: T??m ra c??c exam ???????c t???o t??? 3 n??m tr?????c v?? x??a c??c exam ???? ??i (s??? d???ng store ??? c??u 9 ????? x??a)  Sau ???? in s??? l?????ng record ???? remove t??? c??c table li??n quan trong khi removing
-- Question 11: Vi???t store cho ph??p ng?????i d??ng x??a ph??ng ban b???ng c??ch ng?????i d??ng nh???p v??o t??n ph??ng ban v?? c??c account thu???c ph??ng ban ???? s??? ???????c chuy???n v??? ph??ng ban default l?? ph??ng ban ch??? vi???c.
DROP PROCEDURE IF EXISTS SP_DelDepFromName;
DELIMITER $$
CREATE PROCEDURE SP_DelDepFromName(IN var_DepartmentName VARCHAR(30))
BEGIN
	DECLARE v_DepartmentID VARCHAR(30) ;
    SELECT D1.DepartmentID   INTO v_DepartmentID FROM department D1 WHERE D1.DepartmentName = var_DepartmentName;
	UPDATE `account` A SET A.DepartmentID  = '11' WHERE A.DepartmentID = v_DepartmentID;
    
	DELETE FROM department d WHERE d.DepartmentName = var_DepartmentName;
END$$
DELIMITER ;
Call SP_DelDepFromName('Marketing');
-- /////////////////////////Testing_System_Assignment_7//////////////////
-- Question 2:t???o trigger kh??ng cho ph??p ng?????i d??ng th??m b???t k??? user n??o v??o
-- ph??ng "sale" n???a,khi th??m th?? hi???n ra th??ng b??o department
-- 				"sale" can not 
DROP TRIGGER IF EXISTS TrG_NotAddUserToSale;
DELIMITER $$
	CREATE TRIGGER TrG_NotAddUserToSale
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
			DECLARE v_depID TINYINT;
			SELECT d.DepartmentID INTO v_depID FROM department d WHERE d.DepartmentName = 'Sale';
			IF (NEW.DepartmentID = v_depID) THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Cant add more User to Sale Department';
			END IF;
    END$$
DELIMITER ;

INSERT INTO `testingsystem`.`account` (`Email`, `Username`, `FullName`, `DepartmentID`, `PositionID`, `CreateDate`)
								VALUES (1, 		1,		 1, 			2,		 1,		 '2020-11-13 00:00:00');
-- Question 1: T???o trigger kh??ng cho ph??p ng?????i d??ng nh???p v??o Group c?? ng??y t???o 1 n??m tr?????c  
DROP TRIGGER IF EXISTS Trg_CheckInsertGroup;
DELIMITER $$
	CREATE TRIGGER Trg_CheckInsertGroup
   BEFORE INSERT ON `Group`
    FOR EACH ROW
    BEGIN
    DECLARE v_CreateDate DATETIME;
    SET v_CreateDate = DATE_SUB(NOW(), interval 1 year);
		IF (NEW.CreateDate <= v_CreateDate) THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Cant create this group';
			END IF;
    END$$
DELIMITER ;

INSERT INTO `testingsystem`.`group` (`GroupName`, `CreatorID`, `CreateDate`) 
VALUES								 (2, 1, '2018-04-10 00:00:00');
                              
-- l???y ra danh s??ch nh??n vi??n c?? ph??ng ban sale,marketing,...v?? v??? tr?? Dev,Test
DROP PROCEDURE IF EXISTS sp_GetAccFromDep11;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep11(IN namedep Varchar(30),IN namepos varchar(30))
BEGIN
	select *from  `account`a
	inner join position d on a.positionid=d.positionid
	inner join department p on a.departmentid=p.departmentid
	where p.departmentname=namedep and d.positionname=namepos;
END$$
DELIMITER ;
call vidu2.sp_GetAccFromDep11('sale', 'test');
-- nh???p v??o t??n ph??ng ban=>>> l???y ???????c id ph??ng 
SELECT*FROM DEPARTMENT; 
DROP PROCEDURE IF EXISTS sp_GetAccFromDep111;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep111(IN namedep VARCHAR(30),out idDep Tinyint)
BEGIN
	SELECT DEPARTMENTID into idDep FROM DEPARTMENT
    WHERE DEPARTMENTNAME=namedep;
END$$
DELIMITER ;
-- khai bao bien
 SET @v_DepID=0;
call sp_GetAccFromDep111('SALE',@v_DepID);
set @idDep = 0;
-- Question 4: T???o store ????? tr??? ra id c???a type question c?? nhi???u c??u h???i nh???t ass6
WITH CTE_tmp AS (
SELECT COUNT(1) AS SL FROM QUESTION
GROUP BY TYPEID
)
SELECT TYPEID FROM QUESTION
GROUP BY TYPEID
HAVING COUNT(1)=(SELECT max(SL) FROM CTE_tmp);
DROP PROCEDURE IF EXISTS sp_GetAccFromDep1111;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep1111(OUT out_typeid tinyint)
BEGIN
	WITH CTE_tmp AS (
	SELECT COUNT(1) AS SL FROM QUESTION
	GROUP BY TYPEID
	)
	SELECT TYPEID into out_typeid   FROM QUESTION
	GROUP BY TYPEID
	HAVING COUNT(1)=(SELECT max(SL) FROM CTE_tmp);
END$$
DELIMITER ;

SET @v_typeidmax=0;
call sp_GetAccFromDep1111(@v_typeidmax);
-- vi???t procedure t??nh t???ng 2 s??? 
DROP PROCEDURE IF EXISTS sp_sum;
DELIMITER $$
CREATE PROCEDURE sp_sum(IN numInput1 TINYINT,IN numInput2 TINYINT,OUT number3 TINYINT)
BEGIN
	DECLARE sum TINYINT DEFAULT 0;
    SET sum = numInput1 +  numInput2;
    SELECT sum INTO number3;
END$$
DELIMITER ;

SET @sum2Num = 0;
CALL sp_num(10,20,@sum2Num);
SELECT @sum2Num;

-- function 
-- vi???t function ????? t??nh t???ng 2 s??? alter
SET GLOBAL log_bin_trust_function_creators=1;
DROP FUNCTION IF EXISTS fc_sum;
DELIMITER $$
CREATE FUNCTION fc_sum(number1 int,number2 int) returns int
BEGIN
	DECLARE sum INT DEFAULT 0;
    SET sum =number1 +number2;
    RETURN sum;
END$$
DELIMITER ;
SELECT fc_sum(40,40) as sum;

-- vi???t h??m l???y ra username  t??? email c???a account:daonq@gmail.com ==> daonq
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS fc_name;
DELIMITER $$   
CREATE FUNCTION fc_name(emailinput varchar(50)) RETURNS VARCHAR(50)
BEGIN   
	DECLARE username VARCHAR(50) DEFAULT '';
	SELECT substring_index(emailinput,'@',1) INTO username;
RETURN username ;  
END $$

SELECT *FROM account;
SELECT fc_name(Email) from `account`;
SELECT fc_name('daonq@vti.com.vn') AS username;

-- vi???t ra t??n v??n ph??ng ban theo id
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS fc_getnamedepfromid;
DELIMITER $$   
CREATE FUNCTION fc_getnamedepfromid(idDepInput tinyint) RETURNS varchar(50)
BEGIN   
	DECLARE depname varchar(50);
    SELECT d.departmentname INTO depname from department d where d.departmentid=idDepinput ;
RETURN depName ;  
END $$

SELECT fc_getnamedepfromid(6) As depname;

SELECT fc_getnamedepfromid(departmentid) As depname;

-- TRIGGER:vi???t trigger ????? kh??ng cho ph??p gnuoiwf d??ng insert qu?? 20 b???n ghi  v??o department
 DROP TRIGGER IF EXISTS Trg_checkCountDeptable;
DELIMITER $$
CREATE TRIGGER Trg_checkCountDeptable
BEFORE INSERT ON `Department`
FOR EACH ROW
BEGIN		
	DECLARE countDep TINYINT DEFAULT 0;
	SELECT COUNT(1) INTO countDep FROM department d; -- countdep=S??? l?????ng b???n ghi trong b???ng department
-- N???u countdep >20 th?? d??ng ch????ng tr??nh v?? in th??ng b??o:can't add more Department!! 
IF (coutndep > 20) THEN
		SIGNAL SQLSTATE'12345'
        SET MESSAGE_TEXT='cant add m???e department!!';
  END IF;
END$$
 DELIMITER ;
INSERT INTO Department	(DepartmentName)
VALUES					(N'sale');



 

















						