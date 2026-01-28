<img src="assets/pennypilot%20banner.svg" width="100%" alt="PennyPilot Banner" />

<div align="center">

**Sovereign Personal Finance. Powered by Local AI.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Built%20with-Flutter-02569B.svg)](https://flutter.dev)
[![Local First](https://img.shields.io/badge/Architecture-Local--First-success)](https://isar.dev)

</div>

---

## 🛡️ Our Ethos

In an era where personal data has become the currency of the internet, PennyPilot was born from a simple, non-negotiable principle: **Your financial life belongs to you, and you alone.**

We believe that managing your wealth shouldn't require surrendering your privacy. Traditional finance apps often trade convenience for surveillance, uploading your transaction history to third-party clouds for aggregation and analysis. PennyPilot rejects this trade-off.

We have engineered a system that brings state-of-the-art Artificial Intelligence *to your data*, rather than sending your data to the AI. By leveraging powerful on-device processing units in modern smartphones, we deliver intelligent automation—receipt scanning, categorization, and predictive insights—completely offline.

**No tracking. No selling data. No cloud sync. Just you and your finances, flying safely.**

---

## ✨ Features

### � On-Device Intelligence
PennyPilot pushes the boundaries of what local-first apps can do. We utilize **Google's MediaPipe** and **ML Kit** to run Large Language Models (LLMs) and Optical Character Recognition (OCR) directly on your device hardware.
*   **Smart Receipt Extraction:** Snap a photo of a receipt, and our local AI extracts the merchant, date, totals, and line items instantly.
*   **Privacy-Preserving Email Scanning:** Connect your email via direct IMAP. Our engine downloads emails to memory, scans them for transaction patterns locally, and discards the rest. Your credentials and emails never leave your device.

### 🔒 Sovereign Data Architecture
*   **Local-First Encryption:** All data is stored in a high-performance **Isar** database on your device's encrypted storage.
*   **Nuclear Option:** A dedicated "Danger Zone" allowing you to instantly wipe all cryptographic keys and data from the device, ensuring total data destruction if needed.
*   **Biometric Sentinel:** Optional biometric authentication (FaceID/Fingerprint) acts as a second layer of defense for app access.

### 🌍 Global Financial Fluency
*   **Real-Time Currency Normalization:** Spend in Yen, tracking in Dollars. PennyPilot fetches daily exchange rates to normalize your foreign spending into your primary currency automatically.
*   **"Safe to Spend" Analytics:** Our algorithms analyze your recurring fixed costs (subscriptions, rent, bills) against your income to calculate a daily "safe" spending limit, preventing lifestyle creep before it happens.

### 🎨 Human-Centric Design
*   **Dynamic UI:** We use deterministic color generation algorithms to create unique, recognizable pastel brands for every merchant you interact with.
*   **Subscription Intelligence:** The app identifies "Zombie Subscriptions"—services that have significantly hiked their prices or those you've stopped using but keep paying for.

---

## 🛠 Technology Stack

This project is a showcase of modern, performant mobile engineering.

| Component | Technology | Description |
|-----------|------------|-------------|
| **Core Framework** | Flutter | Cross-platform UI toolkit for crafting beautiful, native interfaces. |
| **Language** | Dart | Optimized for UI logic and high-performance async operations. |
| **State Management** | Riverpod | Compile-safe dependency injection and state management. |
| **Database** | Isar | Ultra-fast, ACID-compliant local NoSQL database. |
| **Edge AI** | MediaPipe & MLKit | On-device LLM inference and text recognition. |

---

## 🤝 Contributing

We are building the future of privacy-first finance, and we need your help. PennyPilot is an open-source project, and we welcome contributions from developers, designers, and privacy advocates.

### How to Contribute

1.  **Fork the Repository**
    Click the "Fork" button on the top right of this page to create your own copy of the repository.

2.  **Create a Feature Branch**
    Your branch name should be descriptive (e.g., `feat/biometric-enhancement` or `fix/currency-rounding`).
    ```bash
    git checkout -b feat/YourFeatureName
    ```

3.  **Local Development**
    Ensure you have the Flutter SDK (3.2.0+) installed.
    ```bash
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Codestyle & Linting**
    We adhere strictly to the `flutter_lints` package. Before committing, please ensure your code is clean.
    ```bash
    flutter analyze
    ```
    *   **Commit Messages:** Please use Conventional Commits (e.g., `feat: add new chart`, `fix: crash on launch`).

5.  **Submit a Pull Request**
    Push your changes to your fork and submit a PR to our `main` branch. Provide a clear description of the problem you solved or the feature you added. Including screenshots for UI changes is highly encouraged.

### Areas We Need Help With
*   **Localization:** Translating the app into more languages (currently supports EN, DE, FR, EL).
*   **Bank Import Parsers:** writing regex/logic for CSV imports from major international banks.
*   **AI Model Optimization:** Improving the efficiency of our local LLM prompts.

---

## 📄 License

PennyPilot is proudly open-source software distributed under the **MIT License**.
You are free to use, modify, and distribute this software, provided the original copyright notice is retained.

---

<div align="center">
  <p><i>Fly your finances safely.</i></p>
</div>
