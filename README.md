# PennyPilot

PennyPilot is a privacy-focused, local-first personal finance application designed for automated expense tracking and subscription management. By leveraging on-device processing and localized machine learning, PennyPilot provides a comprehensive financial dashboard without compromising user data sovereignty.

## Project Overview

PennyPilot automates the process of transaction logging by directly interfacing with email providers (via OAuth 2.0) to identify and extract data from digital receipts. All data processing, including OCR and AI-driven analysis, is performed locally on the user's device.

## Core Capabilities

- **Localized Data Sovereignty**: All financial data and processing remain local to the device. No cloud synchronization or external data storage is utilized by default.
- **Automated Receipt Ingestion**: Intelligent scanning of connected email accounts to identify and process receipts from major merchants.
- **Subscription Intelligence**: Automated detection of recurring service charges with proactive monitoring for price adjustments and renewal cycles.
- **Predictive Liquidity (Safe-to-Spend)**: Dynamic calculation of available funds based on budget constraints and projected upcoming obligations.
- **Advanced Analytics**: Granular spending breakdowns and historical trend analysis via an intuitive dashboard.
- **Cross-Platform Compatibility**: Consistent experience across Android, Linux, and Windows environments.

## Technical Architecture

The application is built upon a modern, high-performance tech stack:

- **Framework**: Flutter
- **State Management**: Riverpod
- **Storage Layer**: Isar Database (Wait-free, local-first NoSQL)
- **Security**: Google OAuth 2.0 for secure, scoped data access
- **Intelligence**: MediaPipe and Gemma (local LLM) for advanced extraction
- **Infrastructure**: Biometric authentication via local_auth and standards-based cryptography

## Implementation Guide

### Prerequisites

- Flutter SDK (stable channel)
- Google Cloud Platform project configured for OAuth 2.0

### Configuration

1. **Authentication Secrets**:
   - Initialize `lib/src/config/secrets.dart` with valid Google Client IDs.
2. **Android Integration**:
   - Register the application SHA-1 fingerprint within the Google Cloud Console.
   - Application Identifier: `com.example.pennypilot`

### Local Execution

To initialize the project and execute a development build:

```bash
flutter pub get
flutter run
```

## Security Model

The security architecture of PennyPilot is based on a zero-trust approach regarding external servers:

- **Zero-Cloud Architecture**: No proprietary back-end servers are used for data storage or processing.
- **Scoped Permissions**: Email access is granted via limited OAuth 2.0 scopes, ensuring the application only interacts with relevant financial communications.
- **Encrypted Exports**: Optional AES encryption for data backups and exports.
- **Code Transparency**: The codebase is open for security auditing and community review.

## Contributing

Contributions to the PennyPilot ecosystem are welcome. Please refer to `CONTRIBUTING.md` for detailed information on development standards, pull request processes, and the project's code of conduct.

## License

This project is licensed under the MIT License. See the `LICENSE` file for full details.

---

PennyPilot Project Contributors