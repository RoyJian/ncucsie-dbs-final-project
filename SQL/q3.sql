SELECT
    se.Section_No AS "課號",
    c.Course_name AS "課名",
    GROUP_CONCAT(DISTINCT t."Teacher_Name") AS "授課教師",
    COUNT(CASE WHEN (scr."Course_Score" < 60.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '學士班' THEN 1 WHEN (scr."Course_Score" < 70.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '碩士班' THEN 1 END) / COUNT(DISTINCT t."Teacher_Name") AS "不及格人次",
    COUNT(s."Student_ID") / COUNT(DISTINCT t."Teacher_Name") AS "修課人次",
    printf('%.2f',COUNT(CASE WHEN (scr."Course_Score" < 60.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '學士班' THEN 1 WHEN (scr."Course_Score" < 70.0 OR scr."Course_Score" IS NULL ) AND sd."Dept_Degree" = '碩士班' THEN 1 END) * 100.0 / COUNT(s."Student_ID")) AS "不及格比例(%)"
FROM
    Section AS se
    JOIN Course_Teacher_Record AS ctr ON se.Section_No = ctr.Section_No
    JOIN Teacher AS t ON ctr.Teacher_ID = t.Teacher_ID
    JOIN Student_Course_Record AS scr ON se.Section_No = scr.Section_No
    JOIN Student AS s ON scr.Student_ID = s.Student_ID
    JOIN Student_Dept sd ON sd.Dept_ID = s.Student_Dept
    JOIN Course AS c ON se.Course_ID = c.Course_ID
WHERE
    scr."select_result" != 0 AND se.Semester = 1112
GROUP BY c."Course_ID";