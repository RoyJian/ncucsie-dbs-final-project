SELECT 
	Student.Student_name As "姓名",  Student_Dept.Dept_Name As "科系", 
	Student.Student_Grade As "年級", Student.Student_Class As "班級"
FROM 
    Student, Course, Student_Course_Record, Student_Dept,Section
WHERE Student_Course_Record.Student_ID = Student.Student_ID 
AND Student.Student_Dept=Student_Dept.Dept_ID
AND  Student_Course_Record.Section_No = Section.Section_No
AND Section.Course_ID = Course.Course_ID
AND Section.Section_No='A0002'
AND Student_Course_Record.Select_Result != 0 AND Section.Semester = 1112;