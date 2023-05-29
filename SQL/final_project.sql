BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Course_Location" (
	"Location_ID"	INTEGER,
	"Room_Name"	char(255) NOT NULL UNIQUE,
	"Room_Build"	char(255) NOT NULL,
	PRIMARY KEY("Location_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Course_Time" (
	"Time_ID"	INTEGER,
	"Course_No"	char(10) NOT NULL,
	"Week"	INTEGER NOT NULL,
	"Period"	INTEGER NOT NULL,
	PRIMARY KEY("Time_ID" AUTOINCREMENT),
	FOREIGN KEY("Course_No") REFERENCES "Course"("Course_No")
);
CREATE TABLE IF NOT EXISTS "Teacher" (
	"Teacher_ID"	INTEGER,
	"Teacher_Name"	char(255) NOT NULL,
	PRIMARY KEY("Teacher_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Student_Status" (
	"Status_ID"	INTEGER,
	"Status_Name"	char(255) NOT NULL UNIQUE,
	PRIMARY KEY("Status_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Curriculum_Field" (
	"CurriculumField_ID"	INTEGER,
	"CurriculumField_Name"	char(64) NOT NULL UNIQUE,
	PRIMARY KEY("CurriculumField_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Course_Teacher_Record" (
	"CTR_ID"	INTEGER,
	"Teacher_ID"	INTEGER NOT NULL,
	"Course_No"	CHAR(10) NOT NULL,
	PRIMARY KEY("CTR_ID" AUTOINCREMENT),
	FOREIGN KEY("Teacher_ID") REFERENCES "Teacher"("Teacher_ID"),
	FOREIGN KEY("Course_No") REFERENCES "Course"("Course_No")
);
CREATE TABLE IF NOT EXISTS "Course_CurriculumField_Record" (
	"CCFR_ID"	INTEGER,
	"Course_No"	CHAR(10) NOT NULL,
	"CurriculumField_ID"	INTEGER NOT NULL,
	PRIMARY KEY("CCFR_ID" AUTOINCREMENT),
	FOREIGN KEY("CurriculumField_ID") REFERENCES "Curriculum_Field"("CurriculumField_ID"),
	FOREIGN KEY("Course_No") REFERENCES "Course"("Course_No")
);
CREATE TABLE IF NOT EXISTS "Course" (
	"Course_No"	char(10) NOT NULL,
	"Location_ID"	INTEGER NOT NULL,
	"Course_Status_ID"	INTEGER NOT NULL,
	"Course_name"	char(255) NOT NULL,
	"Course_Type"	INTEGER NOT NULL CHECK("Course_Type" BETWEEN 0 AND 1),
	"Course_Credit"	INTEGER NOT NULL,
	"Course_Limit"	INTEGER NOT NULL,
	"Semester"	INTEGER NOT NULL,
	PRIMARY KEY("Course_No"),
	FOREIGN KEY("Course_Status_ID") REFERENCES "Course_Status"("Status_ID"),
	FOREIGN KEY("Location_ID") REFERENCES "Course_Location"("Location_ID")
);
CREATE TABLE IF NOT EXISTS "Course_Status" (
	"Status_ID"	INTEGER,
	"Status_Name"	char(255) NOT NULL UNIQUE,
	PRIMARY KEY("Status_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Student_Course_Record" (
	"SCR_ID"	INTEGER,
	"Student_ID"	INTEGER NOT NULL,
	"Course_No"	CHAR(10) NOT NULL,
	"Select_Result"	INTEGER NOT NULL CHECK("Select_Result" BETWEEN 0 AND 2),
	"Course_Score"	REAL CHECK("Course_Score" BETWEEN 0.0 AND 100.0),
	"Feedback_Rank"	INTEGER CHECK("Feedback_Rank" BETWEEN 1 AND 5),
	PRIMARY KEY("SCR_ID" AUTOINCREMENT),
	FOREIGN KEY("Course_No") REFERENCES "Course"("Course_No"),
	FOREIGN KEY("Student_ID") REFERENCES "Student"("Status_ID")
);
CREATE TABLE IF NOT EXISTS "Student_Dept" (
	"Dept_ID"	INTEGER NOT NULL UNIQUE,
	"Dept_Name"	TEXT NOT NULL,
	"Dept_Degree"	TEXT NOT NULL,
	PRIMARY KEY("Dept_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Student" (
	"Student_ID"	INTEGER,
	"Student_Status_ID"	INTEGER NOT NULL,
	"Student_name"	CHAR(255) NOT NULL,
	"Student_Dept"	INTEGER NOT NULL,
	"Student_Grade"	INTEGER,
	"Student_Class"	CHAR(3) NOT NULL,
	PRIMARY KEY("Student_ID" AUTOINCREMENT),
	FOREIGN KEY("Student_Status_ID") REFERENCES "Student_Status"("Status_ID"),
	FOREIGN KEY("Student_Dept") REFERENCES "Student_Dept"("Dept_ID")
);
INSERT INTO "Course_Location" VALUES (1,'K205','工程一館');
INSERT INTO "Course_Location" VALUES (2,'L102','工程五館');
INSERT INTO "Course_Location" VALUES (3,'M-605','鴻經館');
INSERT INTO "Course_Location" VALUES (4,'K210','工程一館');
INSERT INTO "Course_Time" VALUES (1,'A0001',1,5);
INSERT INTO "Course_Time" VALUES (2,'A0001',1,6);
INSERT INTO "Course_Time" VALUES (3,'A0001',1,7);
INSERT INTO "Course_Time" VALUES (4,'A0002',2,3);
INSERT INTO "Course_Time" VALUES (5,'A0002',2,4);
INSERT INTO "Course_Time" VALUES (6,'A0002',5,4);
INSERT INTO "Course_Time" VALUES (7,'A0003',4,5);
INSERT INTO "Course_Time" VALUES (8,'A0003',4,6);
INSERT INTO "Course_Time" VALUES (9,'A0003',4,7);
INSERT INTO "Teacher" VALUES (1,'岳飛');
INSERT INTO "Teacher" VALUES (2,'陸羽');
INSERT INTO "Teacher" VALUES (3,'劉邦');
INSERT INTO "Teacher" VALUES (4,'項羽');
INSERT INTO "Student_Status" VALUES (1,'在學');
INSERT INTO "Student_Status" VALUES (2,'休學');
INSERT INTO "Student_Status" VALUES (3,'退學');
INSERT INTO "Curriculum_Field" VALUES (1,'理論數學');
INSERT INTO "Curriculum_Field" VALUES (2,'人工智慧');
INSERT INTO "Curriculum_Field" VALUES (3,'基礎知識');
INSERT INTO "Curriculum_Field" VALUES (4,'財務工程');
INSERT INTO "Curriculum_Field" VALUES (5,'統計推論');
INSERT INTO "Course_Teacher_Record" VALUES (1,1,'A0001');
INSERT INTO "Course_Teacher_Record" VALUES (2,2,'A0002');
INSERT INTO "Course_Teacher_Record" VALUES (3,3,'A0003');
INSERT INTO "Course_Teacher_Record" VALUES (4,4,'A0003');
INSERT INTO "Course_CurriculumField_Record" VALUES (1,'A0001',1);
INSERT INTO "Course_CurriculumField_Record" VALUES (2,'A0002',2);
INSERT INTO "Course_CurriculumField_Record" VALUES (3,'A0002',3);
INSERT INTO "Course_CurriculumField_Record" VALUES (4,'A0003',4);
INSERT INTO "Course_CurriculumField_Record" VALUES (5,'A0003',5);
INSERT INTO "Course" VALUES ('A0001',4,1,'微積分',1,2,50,1112);
INSERT INTO "Course" VALUES ('A0002',2,1,'計算機概論',1,3,50,1112);
INSERT INTO "Course" VALUES ('A0003',3,1,'統計學習',0,3,50,1112);
INSERT INTO "Course_Status" VALUES (1,'開課');
INSERT INTO "Course_Status" VALUES (2,'停開');
INSERT INTO "Student_Course_Record" VALUES (1,8,'A0001',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (2,8,'A0002',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (3,8,'A0003',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (4,19,'A0001',1,34.0,3);
INSERT INTO "Student_Course_Record" VALUES (5,19,'A0002',1,44.0,4);
INSERT INTO "Student_Course_Record" VALUES (6,19,'A0003',1,76.0,4);
INSERT INTO "Student_Course_Record" VALUES (7,6,'A0001',1,55.0,5);
INSERT INTO "Student_Course_Record" VALUES (8,6,'A0003',1,87.0,5);
INSERT INTO "Student_Course_Record" VALUES (9,9,'A0002',1,66.0,3);
INSERT INTO "Student_Course_Record" VALUES (10,13,'A0001',1,98.0,4);
INSERT INTO "Student_Course_Record" VALUES (11,13,'A0002',1,49.0,5);
INSERT INTO "Student_Course_Record" VALUES (12,25,'A0003',1,78.0,3);
INSERT INTO "Student_Course_Record" VALUES (13,15,'A0002',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (14,15,'A0003',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (15,16,'A0002',1,74.0,5);
INSERT INTO "Student_Course_Record" VALUES (16,16,'A0003',1,80.0,5);
INSERT INTO "Student_Course_Record" VALUES (17,1,'A0001',1,77.7,1);
INSERT INTO "Student_Course_Record" VALUES (18,1,'A0003',1,46.0,5);
INSERT INTO "Student_Course_Record" VALUES (19,28,'A0003',2,69.0,1);
INSERT INTO "Student_Course_Record" VALUES (20,2,'A0001',1,NULL,NULL);
INSERT INTO "Student_Course_Record" VALUES (21,7,'A0001',1,67.0,2);
INSERT INTO "Student_Course_Record" VALUES (22,7,'A0002',1,78.0,3);
INSERT INTO "Student_Course_Record" VALUES (23,27,'A0003',1,99.0,3);
INSERT INTO "Student_Course_Record" VALUES (24,3,'A0001',1,56.0,2);
INSERT INTO "Student_Course_Record" VALUES (25,3,'A0002',1,93.0,4);
INSERT INTO "Student_Course_Record" VALUES (26,26,'A0003',1,65.0,4);
INSERT INTO "Student_Course_Record" VALUES (27,23,'A0003',1,76.0,4);
INSERT INTO "Student_Course_Record" VALUES (28,21,'A0003',0,NULL,NULL);
INSERT INTO "Student_Dept" VALUES (1,'數學系','學士班');
INSERT INTO "Student_Dept" VALUES (2,'資訊工程系','學士班');
INSERT INTO "Student_Dept" VALUES (3,'資訊工程研究所','碩士班');
INSERT INTO "Student_Dept" VALUES (4,'資訊管理系','學士班');
INSERT INTO "Student_Dept" VALUES (5,'數學系碩士班','碩士班');
INSERT INTO "Student" VALUES (1,1,'張飛',1,1,'A');
INSERT INTO "Student" VALUES (2,2,'孫尚香',1,1,'A');
INSERT INTO "Student" VALUES (3,1,'周瑜',1,1,'A');
INSERT INTO "Student" VALUES (4,1,'黃蓋',1,1,'A');
INSERT INTO "Student" VALUES (6,1,'關興',1,1,'A');
INSERT INTO "Student" VALUES (7,1,'夏侯惇',1,1,'A');
INSERT INTO "Student" VALUES (8,2,'龐統',2,1,'A');
INSERT INTO "Student" VALUES (9,1,'關羽',2,1,'A');
INSERT INTO "Student" VALUES (13,1,'趙雲',1,1,'A');
INSERT INTO "Student" VALUES (15,3,'華雄',3,1,'A');
INSERT INTO "Student" VALUES (16,1,'華陀',3,1,'A');
INSERT INTO "Student" VALUES (19,1,'黃蓋',1,1,'A');
INSERT INTO "Student" VALUES (21,1,'劉備',4,1,'A');
INSERT INTO "Student" VALUES (23,1,'呂布',3,1,'A');
INSERT INTO "Student" VALUES (25,1,'諸葛亮',3,1,'A');
INSERT INTO "Student" VALUES (26,1,'呂蒙',3,1,'A');
INSERT INTO "Student" VALUES (27,1,'圖靈',5,1,'A');
INSERT INTO "Student" VALUES (28,1,'巴斯卡',5,1,'A');
COMMIT;
