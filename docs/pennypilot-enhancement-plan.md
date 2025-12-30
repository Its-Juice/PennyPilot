# PennyPilot Enhancement Plan 🚀

This document outlines the roadmap for improving PennyPilot, focusing on stability, privacy-preserving AI, and a premium user experience.

---

## 🟢 Phase 1: Authentication & Stability (Immediate)
*Goal: Ensure seamless sign-in across all platforms.*

- [x] **Unified Multi-Account Support**: Refactor `AuthService` and `AdvancedAuthService` into a single, robust transaction-aware service that handles multiple Gmail tokens simultaneously.
- [x] **Android Sign-In Fix**: Verify and document the SHA-1 registration process for debug/release keys to eliminate `PlatformException(10)`.
- [x] **Dynamic Client ID Resolution**: Implement a service that automatically selects the correct Client ID based on the runtime platform without manual constructor injection.
- [x] **Token Refresh Logic**: Implement robust background token refreshing to prevent session expiration during long-running email scans.

## � Phase 2: Intelligence & Extraction (Completed)
*Goal: Improve the "Intelligence" in PennyPilot.*

- [x] **On-Device LLM Integration**: Integrate a lightweight, on-device model (e.g., MediaPipe LLM Inference with Gemma-2b) for extracting merchants and amounts from email bodies.
- [x] **Deterministic Fallbacks**: Improve the regex-based extraction for common providers (Uber, Amazon, Netflix) to ensure 100% accuracy for major merchants.
- [x] **Subscription Detection**: Implement logic to categorize recurring transactions and predict next billing dates.
- [x] **HTML Cleaning**: Refine the HTML-to-Text stripping logic to handle complex email layouts (tables, nested divs) more reliably.

## � Phase 3: Premium UI/UX (Completed)
*Goal: Make the app feel like a top-tier Material 3 application.*

- [x] **Material You (Dynamic Color)**: Fully implement `dynamic_color` so the app theme matches the user's wallpaper on Android 12+.
- [x] **Micro-animations**: Add subtle Lottie or Rive animations for "Email Scanning" and "Transaction Success" states.
- [x] **Financial Dashboard**:
    - [x] Add spending category breakdown (Pie Charts via `fl_chart`).
    - [x] Add monthly spending trends (Line/Bar Charts).
    - [x] Create a "Net Worth" or "Total Spent This Month" summary widget.
- [x] **Onboarding Flow**: Build a premium multi-step onboarding process explaining local-first privacy.

## � Phase 4: Privacy & Data (Completed)
*Goal: Empower users with their data.*

- [x] **Local-Only Mode**: A toggle to completely disable any external pings (except for OAuth).
- [x] **Export/Import**: Support exporting data to CSV/JSON and importing Isar backups.
- [x] **Data Wipe**: A "Nuclear Option" to instantly delete all local data and revoke OAuth tokens.
- [x] **Biometric Lock**: Optional App Lock using Fingerprint/FaceID.

## 🟠 Phase 5: DevOps & Community (Growth)
*Goal: Scale the FOSS project.*

- [ ] **GitHub Actions Fix**: Solve the `secrets.dart` missing issue in CI by using GitHub Secrets and a shell script to generate the file during build.
- [ ] **Automated Testing**: Achieve >70% test coverage for the `EmailService` and `DatabaseService`.
- [ ] **Contribution Guide**: Create `CONTRIBUTING.md` to help the community join the project.

---

## 🛠 Active Task List
1. [x] Fix Android `clientId` mismatch.
2. [x] Add `INTERNET` permission to Manifest.
3. [x] Create comprehensive `README.md` and `LICENSE`.
4. [ ] Implement multi-account persistence in `AuthService`.
5. [ ] Integrate `fl_chart` for dashboard visuals.

---

- Signed: GK.