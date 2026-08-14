# HealthBridge Flutter Mobile Application

**HealthBridge** is a modern, high-performance Flutter mobile application designed for doctor discovery, specialist profiling, and seamless appointment confirmation. 

Built with **Flutter 3.x & Dart**, this application closely replicates the visual aesthetics, layouts, color themes, and component structures of the provided Figma design specs, using local JSON assets for data storage and offline testing.

---

## 🚀 Features

- 🔑 **Authentication & Credential Validation**:
  - Email / Username & Password input fields with validation.
  - Password visibility toggle (show/hide).
  - Validation against offline JSON dataset (`assets/data/users.json`).
  - Error feedback banners for invalid credentials & quick autofill shortcut card.

- 🏥 **Doctor Discovery & Listing (Home Screen)**:
  - Dynamic doctor catalog rendered using Flutter's high-performance `ListView.builder`.
  - Filter chips ("In-Network", "Nearest to Me") for instant listing updates.
  - Real-time search by doctor name, medical specialty, or hospital clinic.
  - Quick Care notice banner for urgent care facility wait times.
  - Interactive doctor cards with rating stars, location distance, accepted insurance status, next available slot banner, and action links.

- 🩺 **Doctor Profile & Details (About Doctor Screen)**:
  - Comprehensive doctor overview: headshot avatar, specialty, years of experience, rating, and review counts.
  - Detailed bio section and accepted insurance tags (e.g. BLUE CROSS, AETNA, UNITEDHEALTH, CIGNA).
  - Interactive day & time slot picker selector matching Figma design.
  - Direct call callout container for front desk contacts.
  - Office location address & clinic details card.
  - Fixed bottom **Book Appointment** primary CTA button.

- ✅ **Appointment Confirmation Screen**:
  - Animated green checkmark icon with circle halo.
  - Booking status header ("Booking Confirmed").
  - Physician summary tile, date/time tile, and location tile.
  - Financial breakdown showing consultation fee, insurance coverage discount, and `$0.00 Total Due` badge (`FULLY COVERED`).
  - Unique Confirmation ID (`HB-992-04X`).
  - Interactive toggles for Google Calendar sync, SMS alerts, and receipt sharing.
  - Primary "Done" action navigating back to Home.

---

## 🛠️ Tech Stack

- **Framework**: Flutter SDK (v3.x)
- **Language**: Dart (Null-Safety)
- **UI Architecture**: Material 3 Design System & Custom HealthBridge Theme
- **State & Data**: Local Asset JSON Files (`rootBundle`), Repository Pattern
- **Navigation**: Named routes with central route generator (`AppRoutes`)

---

## 📁 Project Structure

```text
lib/
├── main.dart                      # Application entry point
├── app/
│   ├── app.dart                   # HealthBridgeApp root widget
│   ├── routes.dart                # Centralized route definitions & generator
│   └── theme.dart                 # Custom Material 3 theme & color palette
├── models/
│   ├── user.dart                  # User credentials model
│   └── doctor.dart                # Doctor profile catalog model
├── services/
│   └── local_data_service.dart    # RootBundle JSON decoder service
├── repositories/
│   ├── auth_repository.dart       # Authentication validation repository
│   └── doctor_repository.dart     # Doctor querying & filtering repository
├── screens/
│   ├── login/
│   │   └── login_screen.dart      # Login & authentication UI
│   ├── home/
│   │   └── home_screen.dart       # Doctor discovery & list view
│   ├── doctor/
│   │   └── about_doctor_screen.dart # Specialist details & slot selector
│   └── appointment/
│       └── appointment_confirmation_screen.dart # Booking success confirmation
└── widgets/
    ├── doctor_card.dart           # Reusable doctor summary card
    ├── custom_text_field.dart     # Styled text field with validation
    ├── primary_button.dart        # Primary button with loading indicator
    ├── rating_widget.dart         # Star rating & distance indicator
    ├── doctor_image.dart          # Image asset with fallback avatar
    ├── slot_picker_widget.dart    # Day & time slot selection component
    ├── insurance_badge.dart       # Insurance provider pill tag
    ├── section_title.dart         # Clean section title widget
    ├── loading_widget.dart        # Progress indicator view
    └── error_message.dart         # Standardized error alert banner
```

---

## 🔑 Test Credentials (Local JSON)

The app validates credentials locally against `assets/data/users.json`:

| Username / Email | Password | Role |
| :--- | :--- | :--- |
| **`test@example.com`** | **`123456`** | Test User (Default) |
| **`admin@healthbridge.com`** | **`admin123`** | Administrator |

*(Note: Tapping the test credential card on the login screen automatically populates these credentials).*

---

## 💻 Setup & Local Run Instructions

1. **Get Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run Analysis & Tests**:
   ```bash
   flutter analyze
   flutter test
   ```

3. **Run on Connected Device / Emulator**:
   ```bash
   flutter run
   ```

---

## 📦 Build Android Release APK

To compile the Android standalone release APK:

```bash
flutter build apk --release
```

The compiled APK file will be generated at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 📝 Assumptions & Design Notes

1. **Figma Fidelity**: UI components, colors (`#4A3EAE` primary indigo), card borders, typography, and layout structure match the provided Figma screens.
2. **Local Data Handling**: Since external backend APIs were disallowed by spec, all doctor data, insurance providers, available slots, and user accounts are served asynchronously via `LocalDataService` from Flutter's `rootBundle` (`assets/data/`).
3. **Responsive Design**: Interfaces use flexible layouts (`ListView.builder`, `SingleChildScrollView`, `Flexible`, `ConstrainedBox`) to eliminate `RenderFlex` overflows on various Android screen densities.
