# <p align="center"><img src="assets/pennypilot_logo.png" width="100" alt="PennyPilot Logo"><br>PennyPilot</p>

<p align="center">
  <img src="https://img.shields.io/badge/FOSS-Free%20and%20Open%20Source-brightgreen?style=for-the-badge" alt="FOSS">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT">
  <img src="https://img.shields.io/badge/Privacy-100%25%20Local-blue.svg?style=for-the-badge" alt="Privacy: Local">
</p>

---

**PennyPilot** is a sophisticated, privacy-first personal finance application that acts as your personal financial navigator. Unlike traditional apps that require you to manually input every coffee or upload your data to a black-box cloud, PennyPilot brings intelligence directly to your device. 

It automatically scans your inbox (Gmail) for receipts and subscriptions, extracting transaction details locally. **Your emails never leave your device.**

---

## Core Features

| Feature | Description |
| :--- | :--- |
| **Privacy First** | 100% local data processing. No cloud sync, no tracking, no data selling. |
| **Smart Inbox Scan** | Automatically detects receipts from Amazon, Uber, Spotify, and more. |
| **Subscription Tracker** | Intelligent detection of recurring bills with renewal alerts. |
| **Insights & Analytics** | Beautiful charts and spending breakdowns per category. |
| **Local-First Speed** | High-performance transactions using the Isar database. |
| **Material You** | Professional Material 3 UI with adaptive themes and dark mode. |
| **Multi-Platform** | Seamless experience across Android, Linux, and Windows. |

---

## Tech Stack

- **Core**: [Flutter](https://flutter.dev) (The most powerful cross-platform UI toolkit).
- **State Management**: [Riverpod](https://riverpod.dev) (Robust, compile-safe state providers).
- **Storage**: [Isar Database](https://isar.dev) (Ultra-fast local database for Flutter).
- **Authentication**: [Google OAuth 2.0](https://developers.google.com/identity/protocols/oauth2) (Secure access to Gmail scopes).
- **Architecture**: Clean Architecture with a focus on Service-oriented logic.

---

## Getting Started

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured.
- A Google Cloud Project for OAuth credentials.

### 2. Configuration
1.  **OAuth Credentials**:
    - Obtain Client IDs for Android and Desktop from the [Google Cloud Console](https://console.cloud.google.com/).
    - Add `lib/src/config/secrets.dart` (referencing `lib/src/config/secrets.dart.example`).
2.  **Android Setup (Critical)**:
    - To avoid `PlatformException(10)`, ensure your **Debug SHA-1 fingerprint** is registered in the Google Cloud/Firebase console.
    - Package Name: `com.example.pennypilot`

### 3. Build & Run
```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

---

## Privacy & Security

PennyPilot is built on the philosophy that **Financial Data is Private Data**.
1. **No External Servers**: We do not host any back-end servers that store your data.
2. **Local Scanning**: Email content is fetched via IMAP/APIs directly to your device and parsed in memory.
3. **Open Source**: The code is 100% open, allowing the community to audit our privacy claims.

---

## Roadmap

We are constantly evolving. Our current focus includes:
- [ ] **On-Device LLM**: Using Google's Gemini Nano for even smarter merchant extraction.
- [ ] **Biometric Lock**: Securing your data with Fingerprint/FaceID.
- [ ] **Expanded Detectors**: Supporting more languages and international merchants.
- [ ] **Data Portability**: Full JSON/CSV export for manual analysis.

See our [Full Enhancement Plan](docs/pennypilot-enhancement-plan.md) for more.

---

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

---

<p align="center">
  Built with ❤️ by the PennyPilot Community
</p>