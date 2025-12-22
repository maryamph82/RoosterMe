INSERT INTO users (username, email, password_hash) VALUES
('maryam', 'maryam@example.com', 'hash1'),
('ali', 'ali@example.com', 'hash2'),
('sara', 'sara@example.com', 'hash3'),
('reza', 'reza@example.com', 'hash4'),
('neda', 'neda@example.com', 'hash5');


INSERT INTO challenges (title, description, difficulty_level) VALUES
('Math Puzzle', 'Solve a set of math problems', 3),
('Shake Phone', 'Shake the phone 10 times', 2),
('Trivia Questions', 'Answer 3 trivia questions', 4),
('QR Scan', 'Scan a QR code in the room', 1),
('Tongue Twister', 'Say a tongue twister correctly', 2);



INSERT INTO alarms (user_id, alarm_time, is_active) VALUES
(1, '07:00:00', TRUE),
(1, '08:00:00', FALSE),
(2, '06:30:00', TRUE),
(3, '07:15:00', TRUE),
(4, '09:00:00', FALSE);


INSERT INTO user_challenges (user_id, alarm_id, challenge_id, is_completed, completed_at) VALUES
(1, 1, 1, FALSE, NULL),
(1, 1, 2, FALSE, NULL),
(2, 3, 3, FALSE, NULL),
(3, 4, 4, TRUE, '2025-12-21 07:16:00'),
(4, 5, 5, FALSE, NULL);


INSERT INTO alarm_logs (alarm_id, triggered_at, success) VALUES
(1, '2025-12-21 07:00:00', TRUE),
(1, '2025-12-22 07:00:00', FALSE),
(3, '2025-12-21 06:30:00', TRUE),
(4, '2025-12-21 07:15:00', TRUE),
(5, '2025-12-22 09:00:00', FALSE);


INSERT INTO streaks (user_id, current_streak, last_success_date) VALUES
(1, 3, '2025-12-20'),
(2, 5, '2025-12-21'),
(3, 2, '2025-12-21'),
(4, 0, NULL),
(5, 1, '2025-12-20');