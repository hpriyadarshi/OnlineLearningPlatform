-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2020 at 09:23 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online_platform`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_courses` ()  NO SQL
select * from courses$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `password`) VALUES
(1, 'ujjwal', 'ujjwal'),
(2, 'vaibhav', 'vaibhav');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(500) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `video_link` varchar(1000) NOT NULL,
  `rating` float NOT NULL,
  `students_enrolled` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `description`, `tutor_id`, `video_link`, `rating`, `students_enrolled`) VALUES
(2, 'CSS', 'Web Development', 2, 'https://www.youtube.com/embed/yfoY53QXEnI\r\n', 3.9, 13),
(4, 'C Programming', 'Learn C fast and easily', 1, 'https://www.youtube.com/embed/Bjzfag1zZPg', 3.5, 8),
(5, 'Machine Learning & Artificial Intelligence', 'From spam filters and self-driving cars, to cutting edge medical diagnosis and real-time language', 3, 'https://www.youtube.com/embed/z-EtmaFJieY', 4.3, 12),
(12, 'HTML', 'Web Development', 2, 'https://www.youtube.com/embed/UB1O30fR-EE', 4.6, 12),
(18, 'JavaScript', 'Javascript', 2, 'https://www.youtube.com/embed/W6NZfCO5SIk\r\n', 4.8, 7),
(19, 'C Programming', 'Learn C fast and easily', 1, 'https://www.youtube.com/embed/Bjzfag1zZPg', 4.7, 7),
(20, 'Python Tutorial for Beginners - Crash Course 2019 ', 'Learn Python from scratch by building a game in this beginner\'s course - no prior knowledge is required in this Python tutorial!', 4, 'https://www.youtube.com/embed/kDdTgxv2Vv0', 4.2, 19),
(21, 'Introduction to Algorithms', ' This class will give you an introduction to the design and analysis of algorithms, enabling you to analyze networks and discover how individuals are connected. ', 6, 'https://www.youtube.com/embed/0IAPZzGSbME', 3.8, 40),
(23, 'Learn Java', 'Get in depth concepts of Java', 1, 'https://www.youtube.com/embed/UB1O30fR-EE', 3.6, 14);

-- --------------------------------------------------------

--
-- Table structure for table `enrolled_in`
--

CREATE TABLE `enrolled_in` (
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enrolled_in`
--

INSERT INTO `enrolled_in` (`user_id`, `course_id`) VALUES
(1, 2),
(1, 4),
(1, 21),
(2, 5),
(2, 12),
(16, 2),
(16, 12);

--
-- Triggers `enrolled_in`
--
DELIMITER $$
CREATE TRIGGER `decrementor` AFTER DELETE ON `enrolled_in` FOR EACH ROW Update courses c set students_enrolled=students_enrolled-1 where c.course_id=old.course_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `incrementor` AFTER INSERT ON `enrolled_in` FOR EACH ROW Update courses c set students_enrolled=students_enrolled+1 where c.course_id=new.course_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `feedback1`
--

CREATE TABLE `feedback1` (
  `feedback_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `date` date NOT NULL,
  `rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback1`
--

INSERT INTO `feedback1` (`feedback_id`, `user_id`, `course_id`, `comment`, `date`, `rating`) VALUES
(7, 1, 12, 'Good Course', '2019-11-05', 4.3),
(8, 1, 18, 'Course with some good content', '2019-12-17', 4.3),
(11, 17, 18, 'wqewqe', '2019-12-08', 3.4),
(12, 1, 2, 'kuch naya', '2019-12-09', 4.8),
(13, 2, 2, 'qweqwe', '2019-12-04', 3.7);

--
-- Triggers `feedback1`
--
DELIMITER $$
CREATE TRIGGER `course_rating` AFTER INSERT ON `feedback1` FOR EACH ROW Update courses c set c.rating=(select avg(f.rating) from feedback1 f where f.course_id=c.course_id and f.course_id=new.course_id) where c.course_id=new.course_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `course_rating_decrementor` AFTER DELETE ON `feedback1` FOR EACH ROW Update courses c set c.rating=(select avg(f.rating) from feedback1 f where f.course_id=c.course_id and f.course_id=old.course_id) where c.course_id=old.course_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `question_id` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `ques1` varchar(500) NOT NULL,
  `ques2` varchar(500) NOT NULL,
  `ques3` varchar(500) NOT NULL,
  `ques4` varchar(500) NOT NULL,
  `correct_option` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `content`, `quiz_id`, `ques1`, `ques2`, `ques3`, `ques4`, `correct_option`) VALUES
(1, 'What does HTML stand for?', 11, 'Hyper Text Markup Language', 'Hypertext and Links Markup Language', 'Home Tool Markup Language', 'None of these', 'Hyper Text Markup Language'),
(2, 'Who is making the Web standards?', 11, 'Mozilla', 'Microsoft', 'The World Wide Web Consortium', 'None of these', 'The World Wide Web Consortium'),
(3, 'Which attribute is used to provide an advisory text about an element or its contents?', 11, 'tooltip', 'dir', 'title', 'head', 'title'),
(4, ' Which attribute specifies a unique alphanumeric identifier to be associated with an element?', 11, 'class', 'id', 'article', 'html', 'id'),
(5, 'Choose the correct HTML tag for the largest heading.', 11, 'head', 'h1', 'h6', 'header', 'h1');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `quiz_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `no_of_questions` int(11) NOT NULL,
  `students_participated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`quiz_id`, `course_id`, `no_of_questions`, `students_participated`) VALUES
(4, 4, 13, 6),
(11, 12, 5, 5),
(12, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `score_in`
--

CREATE TABLE `score_in` (
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `score_in`
--

INSERT INTO `score_in` (`user_id`, `quiz_id`, `score`) VALUES
(1, 4, 8),
(1, 11, 4),
(2, 4, 11);

-- --------------------------------------------------------

--
-- Table structure for table `tutors`
--

CREATE TABLE `tutors` (
  `tutor_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `tutor_name` varchar(100) NOT NULL,
  `qualification` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tutors`
--

INSERT INTO `tutors` (`tutor_id`, `course_id`, `tutor_name`, `qualification`) VALUES
(1, 1, 'Saurabh Shukla', 'PhD'),
(2, 2, 'Rakesh Kumar', 'MCA'),
(3, 3, 'Priyansh Singh', 'Mtech'),
(4, 7, 'Abdul Bari', 'PhD'),
(6, 6, 'Prakash Kumar', 'MCA');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`) VALUES
(1, 'ujjwal', '5d9a1838e802c365706b6a183b62a74b', 'ujjwal@gmail.com'),
(2, 'vaibhav', '5d9a1838e802c365706b6a183b62a74b', 'vaibhav@gmail.com'),
(3, 'yash', '5d9a1838e802c365706b6a183b62a74b', 'yash@gmail.com'),
(16, 'prince', '5d9a1838e802c365706b6a183b62a74b', 'prince@gmail.com'),
(17, 'sagar', '5d9a1838e802c365706b6a183b62a74b', 'sagar@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `courses_ibfk_1` (`tutor_id`);

--
-- Indexes for table `enrolled_in`
--
ALTER TABLE `enrolled_in`
  ADD PRIMARY KEY (`user_id`,`course_id`),
  ADD KEY `enrolled_in_ibfk_2` (`course_id`);

--
-- Indexes for table `feedback1`
--
ALTER TABLE `feedback1`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `feedback1_ibfk_1` (`user_id`),
  ADD KEY `feedback1_ibfk_2` (`course_id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `question_ibfk_1` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `quizzes_ibfk_1` (`course_id`);

--
-- Indexes for table `score_in`
--
ALTER TABLE `score_in`
  ADD PRIMARY KEY (`user_id`,`quiz_id`),
  ADD KEY `score_in_ibfk_2` (`quiz_id`);

--
-- Indexes for table `tutors`
--
ALTER TABLE `tutors`
  ADD PRIMARY KEY (`tutor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `feedback1`
--
ALTER TABLE `feedback1`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tutors`
--
ALTER TABLE `tutors`
  MODIFY `tutor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `tutors` (`tutor_id`) ON DELETE CASCADE;

--
-- Constraints for table `enrolled_in`
--
ALTER TABLE `enrolled_in`
  ADD CONSTRAINT `enrolled_in_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrolled_in_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback1`
--
ALTER TABLE `feedback1`
  ADD CONSTRAINT `feedback1_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback1_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `score_in`
--
ALTER TABLE `score_in`
  ADD CONSTRAINT `score_in_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `score_in_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `score_in_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
