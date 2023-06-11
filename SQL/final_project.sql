BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Section_Location_Time" (
    "CLT_ID"    INTEGER,
    "Section_No"    char(10)    NOT NULL,
    "Room_Name"     char(255),
    "Room_Building" char(255),
    "Week"      INTEGER,
    "Period"    INTEGER,
    PRIMARY KEY("CLT_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Teacher" (
	"Teacher_ID"	INTEGER,
	"Teacher_Name"	char(255) NOT NULL,
	PRIMARY KEY("Teacher_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Curriculum_Field" (
	"CurriculumField_ID"	INTEGER,
	"CurriculumField_Name"	char(64) NOT NULL UNIQUE,
	PRIMARY KEY("CurriculumField_ID" AUTOINCREMENT)
);


CREATE TABLE IF NOT EXISTS "Course" (
    "Course_ID" INTEGER NOT NULL,
    "Course_Name"   CHAR(128),
    PRIMARY KEY("Course_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Section" (
	"Section_No"	char(10) NOT NULL,
    "Course_ID"     INTEGER  NOT NULL,
	"Section_Status" INTEGER NOT NULL,
	"Course_Type"	INTEGER NOT NULL CHECK("Course_Type" BETWEEN 0 AND 1),
	"Course_Credit"	INTEGER NOT NULL,
	"Course_Limit"	INTEGER NOT NULL,
	"Semester"	INTEGER NOT NULL,
	PRIMARY KEY("Section_No" ),
	FOREIGN KEY("Course_ID") REFERENCES "Course"("Course_ID")
);
CREATE TABLE IF NOT EXISTS "Course_CurriculumField_Record" (
	"CCFR_ID"	INTEGER,
	"Course_ID"	INTEGER NOT NULL,
	"CurriculumField_ID"	INTEGER NOT NULL,
	PRIMARY KEY("CCFR_ID" AUTOINCREMENT),
	FOREIGN KEY("CurriculumField_ID") REFERENCES "Curriculum_Field"("CurriculumField_ID"),
	FOREIGN KEY("Course_ID") REFERENCES "Course"("Course_ID")
);

CREATE TABLE IF NOT EXISTS "Curriculum_Teacher_Record" (
    "CTR_ID" INTEGER  NOT NULL,
    "CurriculumField_ID" INTEGER,
    "Teacher_ID" INTEGER,
    PRIMARY KEY("CTR_ID" AUTOINCREMENT)
    FOREIGN KEY("CurriculumField_ID") REFERENCES "Curriculum_Field"("CurriculumField_ID")
);

CREATE TABLE IF NOT EXISTS "Select_Result" (
    "SR_ID" INTEGER  NOT NULL,
    "SR_Name" CHAR(16),
    PRIMARY KEY("SR_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Student_Dept"(
    "Dept_ID" INTEGER  NOT NULL,
    "Dept_Name" CHAR(128),
    "Dept_Degree" CHAR(128),
    PRIMARY KEY("Dept_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Student" (
	"Student_ID"	INTEGER NOT NULL,
    "Student_Status" INTEGER NOT NULL,
    "Student_Name"	CHAR(255) NOT NULL,
    "Student_Dept"	INTEGER NOT NULL,
	"Student_Grade"	INTEGER,
	"Student_Class"	CHAR(32) NOT NULL,
	PRIMARY KEY("Student_ID" AUTOINCREMENT),
	FOREIGN KEY("Student_Dept") REFERENCES "Student_Dept"("Dept_ID")
);

CREATE TABLE IF NOT EXISTS "Student_Course_Record" (
	"SCR_ID"	INTEGER  NOT NULL,
	"Student_ID"	INTEGER NOT NULL,
	"Section_No"	CHAR(10) NOT NULL,
	"Select_Result"	INTEGER NOT NULL CHECK("Select_Result" BETWEEN 0 AND 2),
	"Course_Score"	REAL CHECK("Course_Score" BETWEEN 0.0 AND 100.0),
	"Feedback_Rank"	INTEGER CHECK("Feedback_Rank" BETWEEN 1 AND 5),
	PRIMARY KEY("SCR_ID" AUTOINCREMENT),
	FOREIGN KEY("Section_No") REFERENCES "Section"("Section_No"),
	FOREIGN KEY("Student_ID") REFERENCES "Student"("Student_ID")
);

CREATE TABLE IF NOT EXISTS "Course_Teacher_Record" (
	"CTR_ID"	INTEGER  NOT NULL,
	"Teacher_ID"	INTEGER NOT NULL,
	"Section_No"	CHAR(10) NOT NULL,
	PRIMARY KEY("CTR_ID" AUTOINCREMENT),
	FOREIGN KEY("Teacher_ID") REFERENCES "Teacher"("Teacher_ID"),
	FOREIGN KEY("Section_No") REFERENCES "Section"("Section_No")
);


INSERT INTO "Section_Location_Time" VALUES (1,'A0001','K205','工程一館',1,5);
INSERT INTO "Section_Location_Time" VALUES (2,'A0001','K205','工程一館',1,6);
INSERT INTO "Section_Location_Time" VALUES (3,'A0001','K205','工程一館',1,7);
INSERT INTO "Section_Location_Time" VALUES (4,'A0002','L102','工程五館',2,3);
INSERT INTO "Section_Location_Time" VALUES (5,'A0002','L102','工程五館',2,4);
INSERT INTO "Section_Location_Time" VALUES (6,'A0002','L102','工程五館',5,4);
INSERT INTO "Section_Location_Time" VALUES (7,'A0003','L102','工程五館',4,5);
INSERT INTO "Section_Location_Time" VALUES (8,'A0003','L102','工程五館',4,6);
INSERT INTO "Section_Location_Time" VALUES (9,'A0003','L102','工程五館',4,7);

INSERT INTO "Teacher" VALUES (1,'岳飛');
INSERT INTO "Teacher" VALUES (2,'陸羽');
INSERT INTO "Teacher" VALUES (3,'劉邦');
INSERT INTO "Teacher" VALUES (4,'項羽');

INSERT INTO "Curriculum_Field" VALUES (1,'理論數學');
INSERT INTO "Curriculum_Field" VALUES (2,'人工智慧');
INSERT INTO "Curriculum_Field" VALUES (3,'基礎知識');
INSERT INTO "Curriculum_Field" VALUES (4,'財務工程');
INSERT INTO "Curriculum_Field" VALUES (5,'統計推論');

INSERT INTO "Course" VALUES (1,'微積分');
INSERT INTO "Course" VALUES (2,'計算機概論');
INSERT INTO "Course" VALUES (3,'統計學習');


INSERT INTO "Course_CurriculumField_Record" VALUES (1,1,1);
INSERT INTO "Course_CurriculumField_Record" VALUES (2,2,2);
INSERT INTO "Course_CurriculumField_Record" VALUES (3,2,3);
INSERT INTO "Course_CurriculumField_Record" VALUES (4,3,4);
INSERT INTO "Course_CurriculumField_Record" VALUES (5,3,5);

INSERT INTO "Section" VALUES ('A0001',1,1,1,2,50,1112);
INSERT INTO "Section" VALUES ('A0002',2,1,1,3,50,1112);
INSERT INTO "Section" VALUES ('A0003',3,1,0,3,50,1112);

INSERT INTO "Course_Teacher_Record" VALUES (1,1,'A0001');
INSERT INTO "Course_Teacher_Record" VALUES (2,2,'A0002');
INSERT INTO "Course_Teacher_Record" VALUES (3,3,'A0003');
INSERT INTO "Course_Teacher_Record" VALUES (4,4,'A0003');


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
COMMIT;