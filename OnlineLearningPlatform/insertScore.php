<?php
include("php/config.php");
include("php/classes/Constants.php");
include("php/classes/Account.php");

include("php/classes/Course.php");
include("php/classes/Tutor.php");
include("php/classes/Feedback.php");
include("php/classes/Quiz.php");

$user = new Account($con);
$course = new Course($con);
$quiz = new Quiz($con);

$users = $user->getUsers();
$quizzes = $quiz->getQuizzes();
echo "<script> const quiz = $quizzes;
               const user = $users;
    </script>";

if(isset($_POST['insert'])) {
    $quiz_id = $_POST['quiz_id'];
    $user_id = $_POST['user_id'];
    $score = $_POST['score'];
    $quiz->insertScore($user_id,$quiz_id,$score);
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
    <link rel="stylesheet" href="css/login.css">

</head>
<body>
<form action="insertScore.php" method="POST">
            <h1 class="display-4 text-center mb-3">INSERT SCORE</h1>
            <div class="form-group">
                <label for="user_id">Choose User</label>
                <select class="form-control" id="user_id" name="user_id" required>
                </select>
            </div>
            <div class="form-group">
                <label for="course_id">Choose Quiz</label>
                <select class="form-control" id="quiz_id" name="quiz_id" required>
                </select>
            </div>
            <div class="form-group">
                <label for="score">Enter Score</label>
                <input type="text" class="form-control" id="score" name="score" required>
                </select>
            </div>
            <button type="submit" class="btn btn-primary btn-block btn-register" name="insert">INSERT</button>
</form>


<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="js/insertScore.js"></script>
</body>
</html>