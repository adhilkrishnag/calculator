# Flutter Calculator

A modern, user-friendly calculator application built with Flutter, utilizing the BLoC pattern for state management. This app supports basic arithmetic operations (addition, subtraction, multiplication, division) and includes both on-screen button and keyboard input support, making it versatile for mobile, desktop, and web platforms. The app features a clean, responsive UI and robust error handling for invalid expressions.

## Features
- **Arithmetic Operations**: Supports addition (+), subtraction (-), multiplication (*), and division (/).
- **Clear and Delete**: Clear (C) resets the expression and result; Delete (DEL) removes the last character.
- **Decimal Support**: Handles decimal numbers for precise calculations.
- **Keyboard Input**: Supports regular and numpad keys (0-9, operators, Enter, Backspace, Escape).
- **Error Handling**: Displays "Error" for invalid expressions (e.g., division by zero).
- **Responsive Design**: Adapts to various screen sizes across mobile, desktop, and web.
- **State Management**: Uses the BLoC pattern for efficient and maintainable state handling.
- **Expression Evaluation**: Leverages the `math_expressions` package for accurate calculations.

## Demo
![Calculator Screenshot](code/assets/screenshot.png)

Watch the app in action:

<!-- Embed video using HTML (replace with your raw URL after committing the asset) -->
<video width="640" height="360" controls>
  <source src="https://raw.githubusercontent.com/adhilkrishnag/calculator/main/assets/videos/recordings.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

<!-- Fallback link if embedding doesn't work -->
[Download Video](code/assets/videos/recordings.mp4)

*(Note: The video must be committed to the repository in the `assets/videos/` folder, and the raw URL updated above. For better playback, consider hosting on YouTube or Vimeo and using their embed code.)*

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.8.0 or higher)
- A code editor (e.g., [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio))
- A connected device, emulator, or web browser for testing

### Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/adhilkrishnag/calculator.git
   cd calculator