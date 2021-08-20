<?php
include("php/config.php");
include("php/classes/Course.php");
include("php/classes/Tutor.php");
include("php/classes/Feedback.php");
include("php/classes/QUiz.php");

$feedback = new Feedback($con);
$courses = new Course($con);
$user_name = $_SESSION['userLoggedIn'];



if(isset($_GET['id'])) {
    $course = $courses->getCourseById($_GET['id']);
    $courses->enroll($user_name,$_GET['id']);
    echo "<script>
            const course = $course;
        </script>
    ";
    $_SESSION['course_id'] = $_GET['id'];
    $date = date("Y/m/d");
}

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Online Learning Platform</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <link rel="stylesheet" href="css/courseContent.css">
</head>
<body>
    <div class="main">
    <div class="courseContent mt-5">
    
    </div>

    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="js/courseContent.js"></script>
</body>
</html>
