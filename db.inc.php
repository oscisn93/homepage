<?php

    // $servername = "mariadb";
    // $username = "cs332m3";
    // $password = "YSF4EsHY";
    // $database = "cs332m3";

    $servername = "localhost";
    $username = "oscar";
    $password = "oscar";
    $database = "university";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully to ".$database."!";
?>
