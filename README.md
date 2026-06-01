# LaPak Bantul - Flutter App

> Pusat Layanan Pajak Terpadu — Pemerintah Kabupaten Bantul

---

## 📱 Fitur Utama

| Fitur | Keterangan |
|-------|-----------|
| **Splash Screen** | Animasi logo dengan transisi halus |
| **Register** | Form daftar akun baru (Firebase + ReqRes API) |
| **Login** | Masuk dengan NIK atau Email + Password |
| **Bottom Navigation** | Beranda, PBB, Layanan Keliling, Profil |
| **PBB** | Cari objek pajak by NOP, tampil status SPPT |
| **Layanan Keliling** | Jadwal mobil keliling dengan filter tanggal |
| **Profil** | Info akun + logout |

---

## 🛠️ Setup & Instalasi

### 1. Prerequisites
```bash
flutter --version   # >= 3.0.0
dart --version      # >= 3.0.0
```

### 2. Clone & Install dependencies
```bash
cd lapak_bantul
flutter pub get
```

### 3. Setup Firebase (WAJIB)

#### a. Buat Firebase Project
1. Buka https://console.firebase.google.com
2. Klik **Add project** → beri nama `lapak-bantul`
3. Aktifkan **Google Analytics** (opsional)

#### b. Aktifkan Authentication
1. Di Firebase Console → **Authentication** → **Sign-in method**
2. Aktifkan **Email/Password**

#### c. Aktifkan Firestore
1. **Firestore Database** → **Create database**
2. Pilih mode **Production** atau **Test**
3. Pilih region terdekat (asia-southeast2 untuk Indonesia)

#### d. Tambahkan App Android
1. **Project Settings** → **Add app** → Android
2. Package name: `com.lapakbantul.app`
3. Download `google-services.json`
4. Letakkan di `android/app/google-services.json`

#### e. Generate firebase_options.dart (cara termudah)
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Auto-configure (akan overwrite firebase_options.dart)
flutterfire configure --project=NAMA_PROJECT_FIREBASE_ANDA
```

### 4. Update android/app/build.gradle
```gradle
android {
    compileSdkVersion 34
    defaultConfig {
        applicationId "com.lapakbantul.app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

### 5. Update android/build.gradle
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### 6. Update android/app/build.gradle (bottom)
```gradle
apply plugin: 'com.google.gms.google-services'
```

### 7. Run aplikasi
```bash
flutter run
```

---

## 📡 ReqRes API

Aplikasi menggunakan https://reqres.in untuk simulasi autentikasi.

**Email yang didukung ReqRes:**
- `eve.holt@reqres.in` (register)
- `eve.holt@reqres.in` (login)

Untuk akun custom, Firebase Auth tetap bekerja normal. ReqRes hanya sebagai validasi tambahan dan tidak akan memblokir registrasi/login Firebase.

---

## 📁 Struktur Project

```
lib/
├── main.dart
├── firebase_options.dart       ← Generate ulang pakai flutterfire configure
├── theme/
│   └── app_theme.dart          ← Warna & tema global
├── services/
│   ├── auth_service.dart       ← Firebase Auth + Firestore
│   └── reqres_service.dart     ← ReqRes API calls
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── main_screen.dart        ← Bottom Navigation
│   ├── home_screen.dart
│   ├── pbb_screen.dart
│   ├── layanan_keliling_screen.dart
│   └── profile_screen.dart
└── widgets/
    ├── logo_widget.dart
    ├── custom_text_field.dart
    └── primary_button.dart
```

---

## 🔐 Firestore Security Rules

Paste ini di Firestore Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## 🚀 Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# APK tersimpan di:
# build/app/outputs/flutter-apk/app-release.apk
```

---

## 💡 Tips

- Gunakan **eve.holt@reqres.in** / **cityslicka** untuk test login ReqRes
- Untuk testing tanpa Firebase, comment bagian `await Firebase.initializeApp()` di `main.dart` dan gunakan local storage saja
- Minimum SDK Android: 21 (Android 5.0+)

---

© 2024 Pemerintah Kabupaten Bantul. All rights reserved.
