# AI Quiz App 🧠✨

## Generate, Practice, Master!

The AI Quiz App is your personal study companion, powered by Google Gemini AI. Simply tell it what topic you want to learn or review, and it will generate a custom quiz for you to test your knowledge and track your progress.

### Prerequisites

Before you begin, ensure you have the following installed:

*   **Flutter SDK:** [Install Flutter](https://flutter.dev/docs/get-started/install)
*   **Google Gemini API Key:** You'll need an API key from [Google AI Studio](https://aistudio.google.com/).
*   **IDE:** Visual Studio Code or Android Studio with Flutter plugin.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/ai_quiz.git
    cd ai_quiz
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

### API Key Setup

This app relies on the Google Gemini API to generate quizzes. You must provide your API key.

1.  **Obtain your API Key:** If you haven't already, get your Google Gemini API key from [Google AI Studio](https://aistudio.google.com/).

2.  **Add your API key:**
    Open `lib/constants/gemini_constants.dart` and add your API key in the following format:

    ```dart
    // lib/constants/gemini_constants.dart
    const String API_KEY = 'YOUR_API_KEY_HERE';
    ```
    **Important:** Replace `'YOUR_API_KEY_HERE'` with your actual API key. For security, never commit your API key directly to a public repository. Consider using environment variables for production builds.

### Running the App

After setting up your API key, you can run the app:

1.  **Connect a device or start an emulator:** Ensure you have an Android or iOS device connected, or an emulator/simulator running.
2.  **Run the app:**

    ```bash
    flutter run
    ```

---

## YouTube Explanation

If you're interested in how this app was built or want to learn more about Flutter and Gemini AI integration, check out the full tutorial series:

[AI Quiz App with Flutter & Gemini AI Playlist](https://www.youtube.com/watch?v=6pQa4MUyZbM&list=PLroN0GR-vmwC--Py1S73DjW6LqxTblZm_)

---

## Contributing

Contributions are welcome! If you have suggestions for improvements, find a bug, or want to add a new feature, please feel free to:

1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/your-feature`).
3.  Make your changes.
4.  Commit your changes (`git commit -m 'Add some feature'`).
5.  Push to the branch (`git push origin feature/your-feature`).
6.  Open a Pull Request.

---