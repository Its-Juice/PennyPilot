# PennyPilot v1.0.0-alpha.1.10 🚀

## Overview
This release focuses on global accessibility and significant optimization of the application footprint. We've introduced a personalized first-launch experience and overhauled our build pipeline to ensure PennyPilot remains the lightest, local-first finance tracker available.

## 🌍 Internationalization
- **First Launch Experience**: Users are now greeted with a graceful, full-screen language selection screen on their first start.
- **Language Switcher**: Added a dedicated Language section in Settings allowing for real-time UI updates (no restart required).
- **Supported Languages**:
  - 🇺🇸 **English**
  - 🇩🇪 **Deutsch**
  - 🇫🇷 **Français**
  - 🇬🇷 **Ελληνικά**
- **Robust Persistence**: Language preferences are stored locally and respect privacy-first principles.

## 📉 Optimization & Size Reduction
- **Split APKs**: Implementation of ABI splitting ensures users only download code compatible with their specific phone (ARMv7/ARMv8).
- **App Bundle Support**: Now distributing via `.aab` for the smallest possible Play Store footprint.
- **Dependency Pruning**: Removed unused packages (`cupertino_icons`, `uuid`, `flutter_dotenv`) and large redundant assets.
- **Advanced Shrinking**: Enabled R8 Full Mode and icon tree-shaking to strip away every unused byte of code and font data.

## 🛠️ Technical Improvements
- **Localization Fix**: Resolved persistent `flutter_gen` resolution issues by moving to a fixed generation path.
- **CI/CD Overhaul**: Updated GitHub Actions to automatically produce production-grade, obfuscated split binaries.
- **Native Efficiency**: Optimized native library handling and enabled non-transitive R classes.

---
*PennyPilot is and will always be free, open-source, and local-first.*
