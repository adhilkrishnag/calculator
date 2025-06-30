# Flutter Calculator

A modern, user-friendly calculator application built with Flutter, utilizing the BLoC pattern for state management. This app supports basic arithmetic operations, including addition, subtraction, multiplication, and division, with a clean and responsive UI.

## Features

- Basic arithmetic operations (+, -, \*, /)
- Clear (C) and delete (DEL) functions
- Decimal point support
- Error handling for invalid expressions
- Keyboard input support (regular and numpad keys: numbers, operators, Enter, Backspace, Escape)
- Responsive design for various screen sizes
- BLoC pattern for state management
- Expression evaluation using the `math_expressions` package

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.8.0 or higher)
- A code editor (e.g., [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio))
- A connected device or emulator for testing

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/calculator.git
   cd calculator
   ```

2. **Install dependencies**:
   Run the following command to fetch the required dependencies:

   ```bash
   flutter pub get
   ```

3. **Run the app**:
   Ensure a device or emulator is connected, then run:
   ```bash
   flutter run
   ```

### Dependencies

- `flutter_bloc: ^9.1.1`: For state management
- `cupertino_icons: ^1.0.8`: For iOS-style icons
- `math_expressions: ^2.7.0`: For parsing and evaluating mathematical expressions
- `flutter_lints: ^4.0.0`: For code linting and analysis

## Project Structure

- `lib/`: Contains the main application code
  - `main.dart`: Entry point with the calculator UI
  - `logic/blocs/calculator_bloc/calculator_bloc.dart`: BLoC logic for state management
- `pubspec.yaml`: Dependency configuration file
- `android/`, `ios/`, `web/`: Platform-specific configurations

## Usage

- **Buttons**:
  - Numbers (0-9) and decimal point (.) for input
  - Operators (+, -, \*, /) for arithmetic operations
  - `C` to clear the expression and result
  - `DEL` to remove the last character
  - `=` to evaluate the expression
- **Keyboard Input**:
  - Regular and numpad numbers (0-9) and decimal point (.)
  - Regular and numpad operators (+, -, \*, /)
  - Enter (or Numpad Enter) to evaluate the expression
  - Backspace to delete the last character
  - Escape to clear the expression and result
- The display shows the current expression and the result of the last calculation.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
