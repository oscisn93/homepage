<?php
    // error_reporting(E_ERROR | E_PARSE);

    // $servername = "mariadb";
    // $username = "cs332m3";
    // $password = "YSF4EsHY";
    // $database = "cs332m3";

    $servername = "localhost";
    $username = "root";
    $password = "";
    $database = "university";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    function getcourses($student_cwid, $conn){
        if(is_numeric($student_cwid) && strlen($student_cwid) == 9){
            $sql_query="SELECT title, grade 
                        FROM enrollment, course 
                        WHERE E_CWID =".$student_cwid." AND 
                        enrollment.E_cno = course.cno;";
            $result = $conn->query($sql_query);
            if($result->num_rows > 0){
                echo '<br /><br />'.
                    '<table class="table table-dark">'.
                        '<thead>'.
                            '<th scope="col">Course Title</th>'.
                            '<th scope="col">Grade</th>'.
                        '</thead>';
                while($row = $result->fetch_assoc()) {
                echo '<tbody>'.
                        '<th scope="row">'.
                            $row["title"].
                        "</th>".
                        "<td>".
                            $row["grade"].
                        '</td>'.
                    '</tbody>';
                }
                echo "</table>";
            } else {
                echo "No records found";
            }
        } else {
            echo "Enter valid CWID";
        }
    }

    function getAllcourses($cno, $conn){
        if(is_numeric($cno) && strlen($cno) == 4){
            $sql_query="SELECT sno, classroom, 
                        meeting_days, start_time, 
                        end_time, E_cwid 
                        FROM section, enrollment 
                        WHERE section.scno = ".$cno." AND 
                        section.scno= enrollment.E_cno AND 
                        section.sno = enrollment.E_sno";
            $result = $conn->query($sql_query);
            if($result->num_rows > 0){
                echo '<br /><br />'.
                    '<table class="table table-dark">'.
                        '<thead>'.
                            '<th scope="col">Section Number</th>'.
                            '<th scope="col">Classroom</th>'.
                            '<th scope="col">Meeting Days</th>'.
                            '<th scope="col">Time</th>'.
                            '<th scope="col">Student CWID</th>'.
                        '</thead>';
                while($row = $result->fetch_assoc()) {
                    echo "<tbody>".
                            "<th scope='row'>".
                                $row["sno"].
                            "</th>".
                            "<td>".
                                $row["classroom"].
                            "</td>".
                            "<td>".
                                $row["meeting_days"].
                            "</td>".
                            "<td>".
                                trim($row["start_time"])." - ".$row["end_time"].
                            "</td>".
                            "<td>".
                                $row["E_cwid"].
                            "</td>".
                        "</tbody>";
                }
                echo "</table>";
            } else {
                echo "No such sections found";
            }
        } else {
            echo "Enter a valid course number!";
        }
    }

    function getProfInfo($ssn, $conn){
        if(is_numeric($ssn) && strlen($ssn) == 9){
            $sql_query="SELECT course.title, classroom, 
                        meeting_days, start_time, end_time 
                        FROM professor, section, course 
                        WHERE professor.ssn = ".$ssn." AND 
                        professor.ssn = section.instructor_ssn AND 
                        section.scno = course.cno";
            $result = $conn->query($sql_query);
            if($result->num_rows > 0){
                echo '<br /><br />'.
                '<table class="table table-dark">'.
                    '<thead>'.
                        '<th scope="col">Course Title</th>'.
                        '<th scope="col">Classroom</th>'.
                        '<th scope="col">Meeting Days</th>'.
                        '<th scope="col">Time</th>'.
                    '</thead>';
                while($row = $result->fetch_assoc()) {
                    echo "<tbody>".
                            "<th scope='row'>".
                                $row["title"].
                            "</th>".
                            "<td>".
                                $row["classroom"].
                            "</td>".
                            "<td>".
                                $row["meeting_days"].
                            "</td>".
                            "<td>".
                                $row["start_time"]." - ".$row["end_time"].
                            "</td>".
                        "</tbody>";
                }
                echo "</table>";
            } else {
                echo "No records found";
            }
        } else {
            echo "Enter a valid SSN";
        }
    }
    
    function getcourseGrades($cno, $sno, $conn){
        $num = $cno.$sno;
        if(is_numeric($num) && strlen($num) == 5){
            $sql_query="SELECT grade, COUNT(*) 
                        FROM enrollment 
                        WHERE E_cno = ".$cno." AND 
                        E_sno = ".$sno." GROUP BY grade";
            $result = $conn->query($sql_query);
            if($result->num_rows > 0){
                echo '<br /><br />'.
                '<table class="table table-dark">'.
                    '<thead>'.
                        '<th scope="col">Grade</th>'.
                        '<th scope="col">Number Received</th>'.
                    '</thead>';
                while($row = $result->fetch_assoc()) {
                    echo "<tbody>".
                            "<th scope='row'>".
                                $row["grade"].
                            "</th>".
                            "<td>".
                                $row["COUNT(*)"].
                            "</td>".
                        "</tbody>";
                }
                echo "</table>";
            } else {
                echo "No records found";
            }
        } else {
            echo "Enter valid course and section numbers!";
        }
    }
?>