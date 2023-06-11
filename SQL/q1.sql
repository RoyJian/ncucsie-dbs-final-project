UPDATE Section_Location_Time
SET Room_Name = 'K210'
WHERE Section_No = 'A0001' AND Semester = 1112;

SELECT 
    Section_Location_Time.Section_No  As '課號', 
    Course_Name As '課名',
    Section_Location_Time.Week As '星期',
    Section_Location_Time.Period As '節次',
    Room_Name As '教室',
    Room_Building As '系館'
FROM 
    Section 
    JOIN Section_Location_Time ON Section."Section_No" = Section_Location_Time."Section_No"
	JOIN Course ON Section."Course_ID" = Course."Course_ID"
WHERE Section_Location_Time.Section_No = 'A0001' AND Section_Location_Time.Semester= 1112;

