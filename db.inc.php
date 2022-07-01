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

    function getCourses($student_cwid, $conn){
        echo "<br />";
        $sql_query="SELECT title, grade FROM ENROLLMENT, COURSE WHERE E_CWID =".$student_cwid." AND ENROLLMENT.E_cno = COURSE.cno;";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "title: ".$row["title"]." Grade: ".$row["grade"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }
    function getProfInfo($ssn, $conn){
        echo "<br />";
        $sql_query="SELECT COURSE.title, classroom, meeting_days, start_time, end_time FROM PROFESSOR, SECTION, COURSE WHERE PROFESSOR.ssn = ".$ssn." AND PROFESSOR.ssn = SECTION.instructor_ssn AND SECTION.scno = COURSE.cno";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "title: ".$row["title"]." Class: ".$row["classroom"]." Meeting Days: ".$row["meeting_days"]." Time: ".$row["start_time"]." - ".$row["end_time"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }

    function getAllCourses($cno, $conn){
        echo "<br />";
        $sql_query="SELECT sno, classroom, meeting_days, start_time, end_time,E_cwid FROM SECTION, ENROLLMENT WHERE SECTION.scno = ".$cno." AND SECTION.scno= enrollment.E_cno AND section.sno = enrollment.E_sno";
        $result = $conn->query($sql_query);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                echo "Section Number: ".$row["sno"]." Class: ".$row["classroom"]." Meeting Days: ".$row["meeting_days"]." Time: ".$row["start_time"]." - ".$row["end_time"]." Student CWID: ".$row["E_cwid"]."<br />";
            }
        } else {
            echo "No records found";
        }
    }


function getCourseGrades($cno, $sno, $conn){
    echo "<br />";
    $sql_query="SELECT grade, COUNT(*) FROM ENROLLMENT WHERE E_cno = ".$cno." AND E_sno = ".$sno." GROUP BY grade";
    $result = $conn->query($sql_query);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()) {
            echo "Grader: ".$row["grade"]." Count: ".$row["COUNT(*)"]."<br />";
        }
    } else {
        echo "No records found";
    }
}

    // $conn->close();
?>