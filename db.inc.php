<?php

    $servername = "mariadb";
    $username = "cs332m3";
    $password = "YSF4EsHY";
    $database = "cs332m3";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    function getcourses($student_cwid, $conn){
        echo "<br />";
        $sql_query="SELECT title, grade FROM enrollment, course WHERE E_CWID =".$student_cwid." AND enrollment.E_cno = course.cno;";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "title: ".$row["title"]." Grade: ".$row["grade"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }
    function getAllcourses($cno, $conn){
        echo "<br />";
        $sql_query="SELECT sno, classroom, meeting_days, start_time, end_time,E_cwid FROM section, enrollment WHERE section.scno = ".$cno." AND section.scno= enrollment.E_cno AND section.sno = enrollment.E_sno";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "section Number: ".$row["sno"]." Class: ".$row["classroom"]." Meeting Days: ".$row["meeting_days"]." Time: ".$row["start_time"]." - ".$row["end_time"]." Student CWID: ".$row["E_cwid"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }
    function getProfInfo($ssn, $conn){
        echo "<br />";
        $sql_query="SELECT course.title, classroom, meeting_days, start_time, end_time FROM professor, section, course WHERE professor.ssn = ".$ssn." AND professor.ssn = section.instructor_ssn AND section.scno = course.cno";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "title: ".$row["title"]." Class: ".$row["classroom"]." Meeting Days: ".$row["meeting_days"]." Time: ".$row["start_time"]." - ".$row["end_time"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }
    function getcourseGrades($cno, $sno, $conn){
        echo "<br />";
        $sql_query="SELECT grade, COUNT(*) FROM enrollment WHERE E_cno = ".$cno." AND E_sno = ".$sno." GROUP BY grade";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "Grader: ".$row["grade"]." Count: ".$row["COUNT(*)"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }
    $conn->close();
?>