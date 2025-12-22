-- نمایش تمام آلارم‌های فعال یک کاربر مشخص
SELECT a.alarm_id, a.alarm_time, a.is_active
FROM alarms a
JOIN users u ON u.user_id = a.user_id
WHERE u.username = 'maryam' AND a.is_active = TRUE
ORDER BY a.alarm_time;



-- شمارش تعداد آلارم‌های هر کاربر
SELECT u.username, COUNT(a.alarm_id) AS alarm_count
FROM users u
LEFT JOIN alarms a ON a.user_id = u.user_id
GROUP BY u.username
ORDER BY alarm_count DESC;


-- پیدا کردن آلارم‌های بعد از ساعت مشخص (مثلاً 07:00)
SELECT alarm_id, user_id, alarm_time
FROM alarms
WHERE alarm_time > '07:00:00'
ORDER BY alarm_time;


--  نمایش چالش‌های کاربر همراه با وضعیت انجام
SELECT uc.user_id, c.title, uc.is_completed, uc.completed_at
FROM user_challenges uc
JOIN challenges c ON c.challenge_id = uc.challenge_id
WHERE uc.user_id = 1;


-- تعداد چالش‌های تکمیل‌شده و نشده برای هر کاربر
SELECT uc.user_id,
       SUM(CASE WHEN uc.is_completed THEN 1 ELSE 0 END) AS completed_count,
       SUM(CASE WHEN NOT uc.is_completed THEN 1 ELSE 0 END) AS pending_count
FROM user_challenges uc
GROUP BY uc.user_id
ORDER BY completed_count DESC;


-- چالش‌های سطح سختی بالاتر از 3
SELECT challenge_id, title, difficulty_level
FROM challenges
WHERE difficulty_level > 3
ORDER BY difficulty_level DESC;


-- تعداد موفقیت و شکست هر آلارم
SELECT alarm_id,
       SUM(CASE WHEN success THEN 1 ELSE 0 END) AS success_count,
       SUM(CASE WHEN NOT success THEN 1 ELSE 0 END) AS fail_count
FROM alarm_logs
GROUP BY alarm_id
ORDER BY success_count DESC;


-- آخرین موفقیت هر آلارم
SELECT alarm_id, MAX(triggered_at) AS last_success
FROM alarm_logs
WHERE success = TRUE
GROUP BY alarm_id;


-- نمایش کاربران با طولانی‌ترین استریک
SELECT u.username, s.current_streak, s.last_success_date
FROM streaks s
JOIN users u ON u.user_id = s.user_id
ORDER BY s.current_streak DESC
LIMIT 5;


-- کاربران با استریک صفر (هیچ موفقیتی نداشتند)
SELECT u.username
FROM streaks s
JOIN users u ON u.user_id = s.user_id
WHERE s.current_streak = 0;


-- نمایش تمام اطلاعات آلارم، کاربر و چالش‌های مربوطه
SELECT u.username, a.alarm_time, c.title, uc.is_completed
FROM user_challenges uc
JOIN users u ON u.user_id = uc.user_id
JOIN alarms a ON a.alarm_id = uc.alarm_id
JOIN challenges c ON c.challenge_id = uc.challenge_id
ORDER BY u.username, a.alarm_time;


-- پیدا کردن کاربرانی که همه چالش‌های آلارمشون تکمیل شده
SELECT u.username
FROM users u
JOIN user_challenges uc ON uc.user_id = u.user_id
GROUP BY u.user_id, u.username
HAVING SUM(CASE WHEN uc.is_completed THEN 0 ELSE 1 END) = 0;



-- میانگین سختی چالش‌های تکمیل‌شده توسط هر کاربر
SELECT u.username, AVG(c.difficulty_level) AS avg_completed_difficulty
FROM user_challenges uc
JOIN users u ON u.user_id = uc.user_id
JOIN challenges c ON c.challenge_id = uc.challenge_id
WHERE uc.is_completed = TRUE
GROUP BY u.user_id, u.username;


