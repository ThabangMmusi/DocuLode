# 📚 Supabase Database Schema – DocuLode Platform

This document describes the current schema and relationships used for **DocuLode**, a student-focused academic platform that organizes users, their academic profiles, modules, and courses efficiently.

---

## 🧩 Overview

The database is designed with **normalized relational structure**, ensuring clean separation of data and proper relationships between:

- Users and their academic profiles  
- Courses and modules  
- Profiles and the modules a user is studying  
- Semester and year information per course-module pairing  

---

## 🗂️ Tables

### 1. `users`
Public user information, directly linked to Supabase Auth.

| Column       | Type  | Nullable | Description                  |
|--------------|-------|----------|------------------------------|
| id           | UUID  | ❌       | Supabase Auth UID (PK)       |
| first_name   | TEXT  | ❌       | User's first name            |
| last_name    | TEXT  | ❌       | User's last name             |
| email        | TEXT  | ❌       | Email (unique)               |
| photo_url    | TEXT  | ✅       | Optional profile photo URL   |

---

### 2. `user_profiles`
Private academic profile per user (1-to-1 with users).

| Column      | Type  | Nullable | Description                        |
|-------------|-------|----------|------------------------------------|
| id          | UUID  | ❌       | FK to `users.id` (PK)              |
| course_id   | UUID  | ✅       | FK to `courses.id`                 |
| level       | INT   | ❌       | Current academic level/year        |

---

### 3. `courses`
List of academic programs or degrees.

| Column       | Type  | Nullable | Description        |
|--------------|-------|----------|--------------------|
| id           | UUID  | ❌       | Primary key        |
| course_name  | TEXT  | ❌       | Name of the course |

---

### 4. `modules`
List of academic modules.

| Column       | Type  | Nullable | Description         |
|--------------|-------|----------|---------------------|
| id           | UUID  | ❌       | Primary key         |
| module_name  | TEXT  | ❌       | Name of the module  |

---

### 5. `course_modules`
Defines which modules belong to which course **and in which year/semester**.

| Column     | Type  | Nullable | Description                         |
|------------|-------|----------|-------------------------------------|
| id         | UUID  | ❌       | Primary key                         |
| course_id  | UUID  | ❌       | FK to `courses.id`                  |
| module_id  | UUID  | ❌       | FK to `modules.id`                  |
| year       | INT   | ❌       | Academic year for this module       |
| semester   | INT   | ❌       | Semester (e.g. 1 or 2)              |

> 🔐 Unique: `(course_id, module_id, year, semester)`

---

### 6. `profile_modules`
Many-to-many relationship between `user_profiles` and `modules`.

| Column      | Type  | Nullable | Description                         |
|-------------|-------|----------|-------------------------------------|
| profile_id  | UUID  | ❌       | FK to `user_profiles.id`            |
| module_id   | UUID  | ❌       | FK to `modules.id`                  |

> 🔐 Primary key: `(profile_id, module_id)`

---

## 🧮 Entity-Relationship Diagram (ERD)

[users] ────┐
            │
            ▼
[user_profiles]───┬──────────────┐
                  │              │
                  ▼              ▼
         [profile_modules]   [courses]
                  │              │
                  ▼              ▼
              [modules]   [course_modules]
                  │
                  ▼
              [modules]


---

## 🔗 Relationships Summary

| Relationship                      | Type                | Notes                                 |
|----------------------------------|---------------------|---------------------------------------|
| `users` → `user_profiles`        | One-to-One          | Same ID (auth ID = profile ID)        |
| `user_profiles` → `courses`      | Many-to-One         | A profile is tied to one course       |
| `user_profiles` → `modules`      | Many-to-Many        | Via `profile_modules` table           |
| `courses` → `modules`            | Many-to-Many        | Via `course_modules` with year/sem    |

---

## 🔐 RLS & Security

Enable RLS (Row-Level Security) for all user-private tables:

```sql
alter table user_profiles enable row level security;
alter table profile_modules enable row level security;
alter table users enable row level security;

## 🧠 Notes
level is an integer indicating the academic year.

course_modules is important to define contextual structure (e.g., semester/year of a module in a specific course).

Module reuse across different courses is fully supported.