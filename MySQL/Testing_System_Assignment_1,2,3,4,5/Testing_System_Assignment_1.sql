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
                        (N'gíam đốc'),
                        (N'bảo vệ'),
                        (N'Dev'),
                        (N'Test'),
                        (N'chờ'),
                        (N'nghỉ'),
                        (N'PM'),
                        (N'vệ sinh');
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
VALUES					(N'câu trl Java',		1,					0),
						(N'câu trl .NET',		5,					1),
                        (N'câu trl SQl',			3,					0),
                        (N'câu trl SQl1',		4,					1),
                        (N'câu trl SQl2',		10,					0),
                        (N'câu trl SQl3',		9,					1),
                        (N'câu trl SQl4',		7,					0),
                        (N'câu trl SQl6',		8,					1),
                        (N'câu trl Postman',		6,					0),
                        (N'câu trl ruby',		2,					1);
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
-- Question 2: lấy ra tất cả các phòng ban
SELECT*FROM department; 
-- Question 3: lấy ra id của phòng ban "Sale"
SELECT DepartmentID FROM department where departmentname=N'sale';
-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT * from `account` where LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`) ORDER BY fullname DESC ;
-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
WITH cte_dep3 AS
(
	SELECT * FROM `Account` WHERE DepartmentID =3
)
SELECT * FROM `cte_dep3` 
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `cte_dep3`) 
ORDER BY Fullname ASC;
-- Question 6: Lấy ra tên group đã tạo trước ngày 20/12/2019
SELECT groupname FROM `GROUP` WHERE Createdate<'2019-12-20';
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
-- 1. đếm số câu trả lời cho từng câu hỏi 
-- 2.tìm ra câu hỏi  có >=4 câu trả lời 
select *from answer; 
SELECT a.questionid,q.content ,count(a.questionid) from answer a
INNER join question q ON a.questionid=q.questionid
GROUP BY questionid
HAVING count(a.questionid)>=4;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code` FROM Exam where duration>=60 and createdate<'2019-12-20';
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *from `group` order by createdate DESC LIMIT 5;
-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT departmentID, COUNT(AccountID) AS SL FROM `Account` WHERE DepartmentID = 2;
-- Question 11:Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 		Fullname FROM `Account` WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019 
DELETE from exam WHERE createdate<'2019-12-20';
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM `question` WHERE (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi';
-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành: loc.nguyenba@vti.com.vn
UPDATE 		`Account` 
SET 		Fullname 	= 	N'Nguyễn Bá Lộc', 
			Email 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;
-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE `groupaccount`
SET groupid=4
where accountid=5;

-- ///////////////////////////// Testing_System_Assignment_4////////////////////////
--  Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 		a.Email, a.Username	, a.FullName, d.DepartmentName
FROM 		`Account` a 
INNER JOIN 	Department d ON 	a.DepartmentID = d.DepartmentID;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT*FROM	`Account` WHERE	CreateDate < '2020-12-20';
-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT a.FullName, a.Email, p.PositionName
FROM `Account` a 
INNER JOIN 	Position p ON a.PositionID = p.PositionID
WHERE p.PositionName = 'Dev';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentName, count(a.DepartmentID)  SL  FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(A.DepartmentID) >3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues)  maxcountQues FROM (
SELECT COUNT(E.QuestionID)  countQues FROM examquestion E
	GROUP BY E.QuestionID)  countTable);
-- Question 6: Thông kê mỗi Category Question được sử dụng trong bao nhiêu Question
SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) SL FROM categoryquestion cq 
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID, q.Content , count(eq.QuestionID) SL FROM examquestion eq
RIGHT JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT		g.GroupID, COUNT(ga.AccountID)  'SO LUONG'
FROM		GroupAccount ga 
JOIN 	`Group` g ON	ga.GroupID = g.GroupID
GROUP BY	g.GroupID
ORDER BY	g.GroupID ASC;
-- Question 10: Tìm chức vụ có ít người nhất
SELECT a.positionid,count(a.positionid) SL from `account` a 
INNER JOIN position p ON p.positionid =a.positionid
GROUP BY a.positionid
having count(a.positionid)=(select min(SL) from(select count(a1.positionid) as SL from `account` a1 group by a1.positionid) as tmp_1); 
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) SL FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT q.QuestionID, q.Content NDcauhoi, a.FullName, tq.TypeName typename, ANS.Content NDcautrl FROM question Q
INNER JOIN categoryquestion cq ON q.CategoryID = cq.CategoryID
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
INNER JOIN account a ON a.AccountID = q.CreatorID
INNER JOIN 	Answer AS ANS ON	q.QuestionID = ANS.QuestionID
ORDER BY q.QuestionID ASC;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.TypeID, tq.TypeName, COUNT(q.TypeID)  SL FROM question q
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;
-- Question 14:Lấy ra group không có account nào
SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;
-- Question 15: Lấy ra group không có account nào
SELECT *from groupaccount ga
right join  `group` g on ga.groupid=g.groupid
where ga.groupid is null;
-- Question 16: Lấy ra question không có answer nào
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID 
WHERE a.AnswerID IS NULL; 
-- /////////////////////////Testing_System_Assignment_5//////////////////
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale



















							
