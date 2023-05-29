SELECT  
    Course_name As '課名',
    GROUP_CONCAT(DISTINCT t."Teacher_Name") AS "授課教師",
    SUM(scr.Feedback_Rank) / COUNT(DISTINCT t."Teacher_Name") AS '教學評量總分',
    printf('%.2f',ROUND(SUM(scr.Feedback_Rank) / COUNT(DISTINCT t."Teacher_Name") )
        / (COUNT(s."Student_ID") / COUNT(DISTINCT t."Teacher_Name"))) As '教學評量平均分數'
FROM
    "Course" c
    JOIN "Course_Teacher_Record" ctr ON c."Course_No" = ctr."Course_No"
    JOIN "Teacher" t ON ctr."Teacher_ID" = t."Teacher_ID"
    JOIN "Student_Course_Record" scr ON c."Course_No" = scr."Course_No"
    JOIN "Student" s ON scr."Student_ID" = s."Student_ID"
    JOIN "Student_Dept" sd ON sd."Dept_ID" = s."Student_Dept"
WHERE
    scr."select_result" != 0 AND scr.Feedback_Rank not null AND
    c.Semester = 1112
GROUP BY c."Course_No";