# PennyPilot

PennyPilot is a local-first personal finance tracker built with Flutter. It reads receipts from your email inbox and automatically categorizes spending, detects subscriptions, and generates dashboards.

## Features

- **Local-First**: All data is processed and stored locally on your device.
- **Email Integration**: Connect Gmail, Outlook, or iCloud to scan receipts.
- **Smart Categorization**: Automatically detects merchant names and categories.
- **Subscription Tracking**: Keeps track of recurring payments and renewal dates.
- **Dashboards**: Visualize your spending habits.

## Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Dart SDK

### Installation

1.  **Initialize Platform Files** (if missing):
    ```bash
    flutter create . --org com.pennypilot --project-name pennypilot
    ```
    *Note: This will generate the android/ios folders. It will not overwrite your lib/ code.*

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate Code** (for Isar and Riverpod):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**:
    ```bash
    flutter run
    ```

## Project Structure

- `lib/src/data`: Data layer (Models, Repositories, Data Sources)
- `lib/src/domain`: Domain layer (Entities, Use Cases)
- `lib/src/presentation`: UI layer (Screens, Widgets, Providers)
- `lib/src/core`: Core utilities (Theme, Constants)

## Mock Data Mode

If you don't want to connect your email, you can use the "Demo Mode" available on the "Connect Email" screen to explore the app with mock data.
