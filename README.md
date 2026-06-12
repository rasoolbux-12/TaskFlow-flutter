# 🚀 TaskFlow - Smart Task Management App

TaskFlow is a modern task management application built with **Flutter** and **Firebase Authentication**. It helps users organize daily activities, manage tasks efficiently, and stay productive through a clean and responsive user interface.

---

## ✨ Features

### 🔐 Authentication

* User Registration
* Secure Login with Email & Password
* Auto Login (Persistent Sessions)
* Logout Functionality
* Firebase Authentication Integration

### ✅ Task Management

* Add Tasks
* Edit Tasks
* Delete Tasks
* Mark Tasks as Completed / Incomplete

### 📂 Categories

* Study
* Work
* Personal

### 📅 Due Dates

* Select Due Dates using Flutter Date Picker
* Display Task Deadlines

### 🔍 Search

* Real-time Task Search
* Instantly Filter Tasks by Title

### 📊 Dashboard

* Total Tasks Count
* Completed Tasks Count
* Remaining Tasks Count

### 🌙 Dark Mode

* Light / Dark Theme Toggle
* Theme Preference Saved Locally

### 💾 Local Storage

* Tasks Persisted using SharedPreferences
* Data Remains Available After App Restart

### 👋 Dynamic Greetings

* Good Morning
* Good Afternoon
* Good Evening
* Good Night

---

## 🛠️ Tech Stack

### Frontend

* Flutter
* Dart

### Backend & Authentication

* Firebase Authentication
* Firebase Core

### Local Storage

* SharedPreferences

### UI & Utilities

* Material Design 3
* Google Fonts
* Intl Package

---

## 📱 Screens

* Login Screen
* Registration Screen
* Home Dashboard
* Add Task Dialog
* Edit Task Dialog

---

## 📂 Project Structure

```text
lib/
│
├── main.dart
├── auth_wrapper.dart
│
├── models/
│   └── task.dart
│
├── services/
│   └── auth_service.dart
│
├── screens/
│   ├── login_screen.dart
│   └── register_screen.dart
```

---

## 🔄 Application Flow

```text
App Launch
    ↓
AuthWrapper
    ↓
User Logged In?
    ↓
 ┌───────────┬───────────┐
 │    Yes    │    No     │
 ▼           ▼
Home      Login
Screen    Screen
```

---

## 📊 Task Model

```dart
Task(
  title: String,
  completed: bool,
  category: String,
  dueDate: String,
)
```

---

## 🚀 Future Improvements

* Cloud Task Sync with Firestore
* Google Sign-In
* Email Verification
* Forgot Password
* Push Notifications
* Task Reminders
* Task Priority Levels
* Calendar View
* Task Filtering & Sorting
* User Profiles

---

## 👨‍💻 Developer

**Rasool Bux**

Flutter Developer | Learning Mobile App Development

---

## 📄 License

This project is licensed under the MIT License.

---

⭐ If you found this project useful, consider giving it a star.
