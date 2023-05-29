SELECT Student.Student_name As "姓名",  Student_Dept.Dept_Name As "科系", Student.Student_Grade As "年級", Student.Student_Class As "班級"
FROM Student, Course, Student_Course_Record, Student_Dept
WHERE Student_Course_Record.Student_ID = Student.Student_ID AND Student.Student_Dept =Student_Dept.Dept_ID
AND  Student_Course_Record.Course_No = Course.Course_No AND Course.Course_name = '計算機概論'  AND Semester = 1112;