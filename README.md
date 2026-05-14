# 📋 Task Manager App

A modern and premium Flutter Task Manager App built using Firebase Authentication and Cloud Firestore.

The app allows users to:
- Create tasks
- Edit tasks
- Delete tasks
- Mark tasks as completed
- Manage personal tasks securely
- Login & Signup with Firebase Authentication

Each user can only access their own tasks.

---

# ✨ Features

## 🔐 Authentication
- User Signup
- User Login
- Firebase Authentication
- Auto Login Session

## ✅ Task Management
- Add Task
- Edit Task
- Delete Task
- Complete Task
- Real-time Firestore Updates

## 🎨 Premium UI
- Animated Screens
- Premium Home Screen
- Animated Splash Screen
- Premium Login & Signup Screens
- Premium Profile Screen
- Hero Animations
- Responsive Design

## ☁️ Firebase Integration
- Firebase Authentication
- Cloud Firestore Database
- User-wise Task Storage

---

# 📱 Screens

- Splash Screen
- Login Screen
- Signup Screen
- Home Screen
- Add Task Screen
- Edit Task Screen
- Profile Screen

---

# 🛠️ Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Material UI
- Animations

---

# 📂 Project Structure

lib/
│
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── add_task_screen.dart
│   ├── edit_task_screen.dart
│   └── profile_screen.dart
│
├── services/
│   ├── auth_service.dart
│   ├── firestore_services.dart
│   └── api_service.dart
│
├── utils/
│   └── app_theme.dart
│
└── main.dart

---

# 🔥 Firebase Setup

## 1️⃣ Create Firebase Project
- Open Firebase Console
- Create New Project

## 2️⃣ Add Android App
- Add package name
- Download google-services.json

## 3️⃣ Paste google-services.json
Paste file inside:

android/app/

## 4️⃣ Enable Authentication
Firebase Console →
Authentication →
Enable Email/Password

## 5️⃣ Enable Firestore Database
Firebase Console →
Firestore Database →
Create Database

---

# 📦 Dependencies

Add these in pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  google_fonts: ^6.2.1
