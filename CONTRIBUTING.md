# Contributing to PennyPilot

Thank you for your interest in contributing to PennyPilot! We welcome all kinds of contributions, from bug reports to new features and documentation improvements.

## Code of Conduct

Please be respectful and professional in all your interactions within the project.

## How Can I Contribute?

### Reporting Bugs
- Search existing issues to see if the bug has already been reported.
- If not, create a new issue. Provide as much detail as possible, including steps to reproduce, expected behavior, and actual behavior. Screenshots are very helpful!

### Suggesting Enhancements
- Check existing issues to see if the feature has already been suggested.
- If not, open a new issue and describe the enhancement you'd like to see. Explain why it would be useful.

### Pull Requests
1. **Fork the repository** and create your branch from `main`.
2. **Install dependencies**: Run `flutter pub get`.
3. **Make your changes**: Ensure your code follows the existing style and is well-documented.
4. **Run tests**: Make sure all tests pass by running `flutter test`.
5. **Run analyzer**: Ensure there are no static analysis issues by running `flutter analyze`.
6. **Submit a Pull Request**: Provide a clear description of your changes and link to any related issues.

## Development Setup

1. **Prerequisites**: Ensure you have the Flutter SDK installed on your machine.
2. **Clone the repo**: `git clone https://github.com/GP-Its-Juice/PennyPilot.git`
3. **Setup Secrets**: PennyPilot uses Google OAuth. You will need to set up your own Google Cloud project and create a `lib/src/config/secrets.dart` file (based on `secrets.dart.example` if available, otherwise check `lib/src/config/google_oauth_config.dart` for required fields).

## Local Privacy First

When contributing features, always keep in mind our core value: **Local-First Privacy**.
- Prefer local processing (ML Kit, MediaPipe) over external APIs.
- Ensure all user data is stored locally using Isar.
- Respect the "Local-Only Mode" setting.

## Community

Join our discussions in the GitHub Issues or Discussions tab!

---
- GK (Lead Developer)
