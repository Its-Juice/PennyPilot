<p align="center">
  <img src="assets/pennypilot_logo.png" width="150" alt="PennyPilot Logo">
</p>

# PennyPilot 💸

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/FOSS-Free%20and%20Open%20Source-brightgreen?style=for-the-badge" alt="FOSS"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT"></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter"></a>
</p>

PennyPilot is a **100% Free and Open Source (FOSS)**, local-first, privacy-focused personal finance tracker built with Flutter. It automatically scans your emails (Gmail, etc.) for receipts and subscriptions, extracting financial data locally on your device without ever sending your sensitive email content to a cloud server.


## ✨ Features

- **Privacy First**: All email scanning and data extraction happen locally on your device.
- **Smart Scanning**: Automatically detects receipts and recurring subscriptions from your inbox.
- **Multi-Platform**: Supports Android and Desktop (Linux/Windows).
- **Material You**: Beautiful, adaptive UI using Material 3 and Dynamic Color.
- **Local Database**: High-performance local storage using Isar.

---

## 🚀 Getting Started

To get the project up and running locally, follow these guides:

### 1. Installation & Environment Setup
Ensure you have the Flutter SDK installed and configured for your target platform.
- [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- [Project Configuration (`lib/src/config/google_oauth_config.dart`)](./lib/src/config/google_oauth_config.dart)

### 2. Secrets & API Keys
This project requires Google OAuth credentials to access Gmail APIs.
- Copy `lib/src/config/secrets.dart.example` to `lib/src/config/secrets.dart`.
- Fill in your Client IDs and Secrets from the [Google Cloud Console](https://console.cloud.google.com/).
- See [secrets.dart.example](./lib/src/config/secrets.dart.example) for the required format.

### 3. Build Instructions
To build the application for your specific platform:
- **Android**: `flutter build apk --release`
- **Linux**: `flutter build linux --release`
- **Development**: `flutter run`

---

## 🛠 Project Structure

- `lib/src/presentation/`: UI components, screens, and Riverpod providers.
- `lib/src/services/`: Core logic for Authentication, Email Scanning, and Database management.
- `lib/src/models/`: Data models for transactions, receipts, and accounts.
- `lib/src/config/`: OAuth configuration and app-wide constants.

---

## 🗺 Roadmap

For our long-term vision and upcoming features, check out the [PennyPilot Enhancement Plan](docs/pennypilot-enhancement-plan.md).

## 🆙 Development Workflows

We use specific workflows for deployment and internal processes:
- **GitHub Actions**: Automated builds and CI/CD.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⚠️ Internal Notes for Developers
- Your Android Package Name: `com.example.pennypilot`
- Ensure you register your debug SHA-1 fingerprint in the Google Cloud Console to avoid `PlatformException(10)`