UPDATE Course
SET Location_ID = (SELECT Location_ID FROM Course_Location WHERE Room_Name = 'K210')
WHERE Course_No = 'A0001' AND Course_name ='微積分';

SELECT course_no As '課號', course_name As '課名', Room_Name As '教室', Room_Build As '系館'
FROM Course JOIN Course_Location ON Course.Location_ID = Course_Location.Location_ID
WHERE Course.Course_name = '微積分'
