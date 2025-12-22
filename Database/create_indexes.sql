CREATE INDEX idx_alarms_user_id
ON alarms(user_id);

CREATE INDEX idx_alarms_is_active
ON alarms(is_active);

CREATE INDEX idx_alarms_time_active
ON alarms(alarm_time, is_active);

CREATE INDEX idx_user_challenges_user_id
ON user_challenges(user_id);

CREATE INDEX idx_user_challenges_alarm_id
ON user_challenges(alarm_id);

CREATE INDEX idx_user_challenges_is_completed
ON user_challenges(is_completed);

CREATE INDEX idx_alarm_logs_alarm_id
ON alarm_logs(alarm_id);

CREATE INDEX idx_alarm_logs_triggered_at
ON alarm_logs(triggered_at);

CREATE INDEX idx_streaks_user_id
ON streaks(user_id);