# 🚀 TaskFlow - Flutter Todo App

TaskFlow is a modern and elegant task management application built with Flutter. It helps users organize daily activities, manage tasks efficiently, and stay productive with a clean and responsive user interface.

---

## 📱 Features

### ✅ Task Management
- Add new tasks
- Edit existing tasks
- Delete tasks
- Mark tasks as completed/incomplete

### 📂 Task Categories
- Study
- Work
- Personal

### 📅 Due Dates
- Select due dates using Flutter Date Picker
- Display task deadlines

### 🔍 Search Tasks
- Real-time task searching
- Quickly find tasks by title

### 📊 Task Statistics
- Total tasks count
- Completed tasks count
- Remaining tasks count

### 🌙 Dark Mode
- Light/Dark theme toggle
- Theme preference saved locally

### 💾 Local Storage
- Tasks saved using SharedPreferences
- Data persists after app restart

### 👋 Dynamic Greeting
- Good Morning
- Good Afternoon
- Good Evening
- Good Night

---

## 🛠️ Technologies Used

- Flutter
- Dart
- Shared Preferences
- Google Fonts
- Material Design 3
- Intl Package

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^latest
  google_fonts: ^latest
  intl: ^latest
```

---

## 📁 Project Structure

```text
lib/
│
├── main.dart
├── models/
│   └── task.dart
│
└── assets/
```

---

## 🧠 App Workflow

```text
User
  ↓
Add/Edit/Delete Task
  ↓
Task List Updated
  ↓
Save Data Locally
  ↓
Shared Preferences
  ↓
Load Data on App Restart
```

---

## 🎨 UI Highlights

- Material 3 Design
- Responsive Layout
- Gradient Statistics Card
- Modern Task Cards
- Smooth User Experience
- Poppins Font Styling

---

## 📊 Data Model

```dart
Task(
  title: String,
  completed: bool,
  category: String,
  dueDate: String,
)
```

---

## 🔮 Future Improvements

- Firebase Authentication
- Cloud Sync
- Push Notifications
- Task Priority Levels
- Task Reminders
- Calendar View
- Categories Management
- Task Sorting & Filtering

---

## 👨‍💻 Developer

Developed using Flutter & Dart.

**Project Name:** TaskFlow  
**Type:** Todo / Task Management App  
**Developer:** Rasool Bux

---

## 📄 License

This project is open-source and available under the MIT License.

---

⭐ If you like this project, don't forget to star the repository!
