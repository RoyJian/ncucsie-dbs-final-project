SELECT
    c."Course_name" AS "課名",
    GROUP_CONCAT(DISTINCT t."Teacher_Name") AS "授課教師",
    COUNT(CASE WHEN (scr."Course_Score" < 60.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '學士班' THEN 1 WHEN (scr."Course_Score" < 70.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '碩士班' THEN 1 END) / COUNT(DISTINCT t."Teacher_Name") AS "不及格人次",
    COUNT(s."Student_ID") / COUNT(DISTINCT t."Teacher_Name") AS "修課人次",
    printf('%.2f',COUNT(CASE WHEN (scr."Course_Score" < 60.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '學士班' THEN 1 WHEN (scr."Course_Score" < 70.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '碩士班' THEN 1 END) * 100.0 / COUNT(s."Student_ID")) AS "不及格比例(%)"
FROM
    "Course" c
    JOIN "Course_Teacher_Record" ctr ON c."Course_No" = ctr."Course_No"
    JOIN "Teacher" t ON ctr."Teacher_ID" = t."Teacher_ID"
    JOIN "Student_Course_Record" scr ON c."Course_No" = scr."Course_No"
    JOIN "Student" s ON scr."Student_ID" = s."Student_ID"
    JOIN "Student_Dept" sd ON sd."Dept_ID" = s."Student_Dept"
WHERE
    scr."select_result" = 0 OR scr."select_result" = 1
GROUP BY c."Course_No";