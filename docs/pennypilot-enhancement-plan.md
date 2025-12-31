# PennyPilot Enhancement Plan 🚀

This document outlines the roadmap for improving PennyPilot, focusing on stability, privacy-preserving AI, and a premium user experience.

---

## 🟢 Phase 1: Authentication & Stability (Completed)
*Goal: Ensure seamless sign-in across all platforms.*

- [x] **Unified Multi-Account Support**: Refactor `AuthService` into a single, robust transaction-aware service that handles multiple Gmail tokens simultaneously.
- [x] **Android Sign-In Fix**: Verify and document the SHA-1 registration process for debug/release keys.
- [x] **Dynamic Client ID Resolution**: Automatically selects the correct Client ID based on the runtime platform.
- [x] **Token Refresh Logic**: Implement robust background token refreshing.

## 🟢 Phase 2: Intelligence & Extraction (Completed)
*Goal: Improve the "Intelligence" in PennyPilot.*

- [x] **On-Device LLM Integration**: Integrate MediaPipe LLM Inference with Gemma-2b for extracting merchants and amounts.
- [x] **Deterministic Fallbacks**: Improve regex-based extraction for common providers.
- [x] **Subscription Detection**: Logic to categorize recurring transactions and predict billing dates.
- [x] **HTML Cleaning**: Refine HTML-to-Text stripping logic.

## 🟢 Phase 3: Premium UI/UX (Completed)
*Goal: Make the app feel like a top-tier Material 3 application.*

- [x] **Material You (Dynamic Color)**: Full `dynamic_color` implementation.
- [x] **Micro-animations**: Added Lottie animations for scanning and success states.
- [x] **Financial Dashboard**:
    - [x] Spending category breakdown (Pie Charts).
    - [x] Monthly spending trends.
    - [x] "Total Spent This Month" summary widget.
- [x] **Onboarding Flow**: Multi-step onboarding process.

## 🟢 Phase 4: Privacy & Data (Completed)
*Goal: Empower users with their data.*

- [x] **Local-Only Mode**: Toggle to disable external pings.
- [x] **Export/Import**: CSV/JSON export and Isar backup support.
- [x] **Data Wipe**: "Nuclear Option" to wipe local data and revoke tokens.
- [x] **Biometric Lock**: Optional App Lock using Fingerprint/FaceID.

## 🟢 Phase 5: DevOps & Community (Completed)
*Goal: Scale the FOSS project.*

- [x] **GitHub Actions Fix**: Automated `secrets.dart` generation in CI.
- [x] **Automated Testing**: >70% test coverage for core services (`EmailService`, `DatabaseService`, `BudgetService`).
- [x] **Contribution Guide**: Created `CONTRIBUTING.md`.
- [x] **Documentation**: Enhanced `README.md` and created release notes for `v1.0.0-alpha.1.9`.

---

- Signed: GK. (December 2025)