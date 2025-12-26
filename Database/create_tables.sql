CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE challenges (
    challenge_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    difficulty_level INTEGER CHECK (difficulty_level BETWEEN 1 AND 5)
);




CREATE TABLE alarms (
    alarm_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    alarm_time TIME NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alarm_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);




CREATE TABLE user_challenges (
    user_challenge_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    alarm_id INTEGER NOT NULL,
    challenge_id INTEGER NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    CONSTRAINT fk_uc_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_uc_alarm
        FOREIGN KEY (alarm_id)
        REFERENCES alarms(alarm_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_uc_challenge
        FOREIGN KEY (challenge_id)
        REFERENCES challenges(challenge_id)
);




CREATE TABLE alarm_logs (
    log_id SERIAL PRIMARY KEY,
    alarm_id INTEGER NOT NULL,
    triggered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    success BOOLEAN NOT NULL,
    CONSTRAINT fk_log_alarm
        FOREIGN KEY (alarm_id)
        REFERENCES alarms(alarm_id)
        ON DELETE CASCADE
);




CREATE TABLE streaks (
    streak_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    current_streak INTEGER DEFAULT 0,
    last_success_date DATE,
    CONSTRAINT fk_streak_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

