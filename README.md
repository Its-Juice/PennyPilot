# <p align="center"><img src="assets/pennypilot_logo.png" width="100" alt="PennyPilot Logo"><br>PennyPilot</p>

<p align="center">
  <img src="https://img.shields.io/badge/FOSS-Free%20and%20Open%20Source-brightgreen?style=for-the-badge" alt="FOSS">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT">
  <img src="https://img.shields.io/badge/Privacy-100%25%20Local-blue.svg?style=for-the-badge" alt="Privacy: Local">
</p>

---

**PennyPilot** is a sophisticated, privacy-first personal finance application that acts as your personal financial navigator. Unlike traditional apps that require you to manually input every coffee or upload your data to a black-box cloud, PennyPilot brings intelligence directly to your device.

It automatically scans your inbox (Gmail) for receipts and subscriptions, extracting transaction details locally. **Your emails never leave your device ecosystem.**

---

## Core Features

| Feature | Description |
| :--- | :--- |
| **Privacy First** | 100% local data processing. No cloud sync, no tracking, no data selling. |
| **Smart Inbox Scan** | Automatically detects receipts from Amazon, Uber, Spotify, and more. |
| **Subscription Tracker** | Intelligent detection of recurring bills with renewal alerts and price hike detection. |
| **Safe-to-Spend** | Calculates how much you can spend per day based on your budget and upcoming bills. |
| **Insights & Analytics** | Beautiful charts and spending breakdowns per category. |
| **Material You** | Professional Material 3 UI with adaptive themes, dark mode, and Lottie animations. |
| **Multi-Platform** | Seamless experience across Android, Linux, and Windows. |

---

## Tech Stack

- **Core**: [Flutter](https://flutter.dev)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Database**: [Isar](https://isar.dev) (Ultra-fast, local-first)
- **Authentication**: [Google OAuth 2.0](https://developers.google.com/identity/protocols/oauth2)
- **Local AI**: [MediaPipe](https://developers.google.com/mediapipe) & [Gemma](https://github.com/google-deepmind/gemma) (Experimental)
- **Security**: [local_auth](https://pub.dev/packages/local_auth) & [cryptography](https://pub.dev/packages/cryptography)

---

## Getting Started

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- A Google Cloud Project for OAuth credentials.

### 2. Configuration
1.  **OAuth Credentials**:
    - Add `lib/src/config/secrets.dart` with your Google Client IDs.
2.  **Android Setup**:
    - Follow the [Detailed Android Setup Guide](docs/android-setup.md) to register your SHA-1.
    - Package Name: `com.example.pennypilot`

### 3. Build & Run
```bash
flutter pub get
flutter run
```

---

## Privacy & Security

PennyPilot is built on the philosophy that **Financial Data is Private Data**.
1. **No External Servers**: We do not host any back-end servers that store your data.
2. **Local Scanning**: Email content is fetched via OAuth2 directly to your device and parsed in memory.
3. **Encrypted Backups**: Optional passphrase protection for your data exports.
4. **Open Source**: Audit our code anytime.

---

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for setup instructions and coding standards.

---

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

---

<p align="center">
  Built with ❤️ by the PennyPilot Community
</p>