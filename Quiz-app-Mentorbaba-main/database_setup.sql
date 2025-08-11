-- Quiz App Database Setup for AWS RDS
CREATE DATABASE IF NOT EXISTS quizdb;
USE quizdb;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Questions table
CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    answer VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample questions
INSERT INTO questions (question, option1, option2, option3, option4, answer) VALUES
('What does AI stand for?', 'Artificial Intelligence', 'Automated Intelligence', 'Advanced Intelligence', 'Applied Intelligence', 'Artificial Intelligence'),
('Who is known as the father of AI?', 'Alan Turing', 'John McCarthy', 'Marvin Minsky', 'Herbert Simon', 'John McCarthy'),
('Which is an application of AI?', 'Face Recognition', 'Data Entry', 'File Management', 'Text Editing', 'Face Recognition'),
('Which programming language is commonly used for AI?', 'Java', 'C++', 'Python', 'JavaScript', 'Python'),
('What type of learning involves rewards and punishments?', 'Supervised Learning', 'Unsupervised Learning', 'Reinforcement Learning', 'Deep Learning', 'Reinforcement Learning'),
('What is the subset of AI that uses neural networks?', 'Machine Learning', 'Data Science', 'Statistics', 'Programming', 'Machine Learning'),
('What type of memory does AI use for learning?', 'Supervised Memory', 'Random Memory', 'Cache Memory', 'Virtual Memory', 'Supervised Memory'),
('AI is widely used in which industry?', 'Agriculture', 'Gaming', 'Textile', 'Mining', 'Gaming'),
('What does AI try to simulate?', 'AI Intelligence', 'Computer Intelligence', 'Robot Intelligence', 'Digital Intelligence', 'AI Intelligence'),
('What is ChatGPT an example of?', 'AI Assistant', 'Database', 'Operating System', 'Web Browser', 'AI Assistant');