# RoosterMe Database

این فولدر شامل تمام فایل‌های SQL مربوط به دیتابیس پروژه **RoosterMe** و تصاویر نتایج اجرای آن‌ها است.  
هدف این فایل‌ها ایجاد دیتابیس، وارد کردن داده‌های نمونه، ایجاد ایندکس‌ها و تست کوئری‌ها می‌باشد.

## ساختار فولدر و فایل‌ها

- **01_create_tables.sql**  
  ایجاد تمام جداول پروژه:
  - `users`
  - `challenges`
  - `alarms`
  - `user_challenges`
  - `alarm_logs`
  - `streaks`
  شامل تمام constraintها و foreign keyها

- **02_insert_data.sql**  
  وارد کردن داده‌های نمونه برای هر جدول

- **03_create_indexes.sql**  
  ایجاد ایندکس‌ها برای افزایش سرعت کوئری‌ها

- **04_sample_queries.sql**  
  نمونه کوئری‌های کاربردی برای بررسی عملکرد دیتابیس

- **execution_results_images/**  
  شامل عکس‌های نتایج اجرای کدها برای هر بخش

## نحوه استفاده

1. وارد محیط PostgreSQL شوید و دیتابیس ایجاد کنید:
```sql
CREATE DATABASE roosterme;
\c roosterme;

-- 1. ساخت جداول
\i 01_create_tables.sql

-- 2. وارد کردن داده‌ها
\i 02_insert_data.sql

-- 3. ایجاد ایندکس‌ها
\i 03_create_indexes.sql

-- 4. اجرای نمونه کوئری‌ها
\i 04_sample_queries.sql
