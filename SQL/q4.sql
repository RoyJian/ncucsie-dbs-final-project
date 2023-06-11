with
T As (
    SELECT Dept_Name, CurriculumField_Name
    FROM Student_Dept As sd1
        LEFT JOIN Student s1 ON sd1.Dept_ID = s1.Student_Dept
        LEFT JOIN Student_Course_Record R ON s1.Student_ID = R.Student_ID
        LEFT JOIN Section se ON se.Section_No = R.Section_No
        LEFT JOIN Course c ON se.Course_ID = c.Course_ID
        LEFT JOIN Course_CurriculumField_Record CCFR2 on c.Course_ID = CCFR2.Course_ID
        LEFT JOIN Curriculum_Field F on CCFR2.CurriculumField_ID = F.CurriculumField_ID
    WHERE R.Select_Result != 0 AND se.Semester =1112
),
T2 As(
    SELECT Student_Dept.Dept_Name, COUNT(*) AS total
    FROM Student_Dept
    JOIN Student ON Student_Dept.Dept_ID = Student.Student_Dept
    GROUP BY Student_Dept.Dept_Name
),
T3 As(
    SELECT Student_Dept.Dept_Name,
           Curriculum_Field.CurriculumField_Name,
           COUNT(CASE WHEN T.Dept_Name=Student_Dept.Dept_Name AND T.CurriculumField_Name = Curriculum_Field.CurriculumField_Name THEN  1 END )  As total
    FROM Student_Dept,Curriculum_Field,T
    GROUP BY Student_Dept.Dept_Name, Curriculum_Field.CurriculumField_Name
)
SELECT T3.Dept_Name As '學生系所',
       T3.CurriculumField_Name As '課程領域',
       T3.total AS '人次',
       printf('%.2f', (T3.total * 100.0 / T2.total * 1.0)) AS '佔比(%)'
FROM T3,T2
WHERE T3.Dept_Name=T2.Dept_Name