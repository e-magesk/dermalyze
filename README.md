# Dermalyze

**Dermalyze** is a mobile solution developed with Flutter that utilizes Deep Learning models for skin lesion screening and analysis. The goal is to provide a clinical decision support tool, facilitating the triage of suspicious cases in primary care settings.

## 🚀 Prerequisites
Before you begin, ensure you have the following installed:

### Core Development
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version).
*   [Dart SDK](https://dart.dev/get-dart).
*   **VS Code** with *Flutter* and *Dart* extensions.
*   An Android/iOS emulator or a configured physical device.

### Firebase & Cloud Infrastructure

*   [Node.js & npm] (required to run Firebae CLI)
*   **Firebase CLI:** Install globally via npm:
```bash
npm install -g firebase-tools
```
*   **FlutterFire CLI**: Install via Dart:
```bash
dart pub global activate flutterfire_cli
```

--- 

### Project Setup & Configuration

#### 1. Firebase Authentication
This project uses Firebase for secure user authentication and session management.
1.  Log in to Firebase:
    ```bash
    firebase login
    ```
2.  Configure FlutterFire (this will generate `firebase_options.dart`):
    ```bash
    flutterfire configure
    ```

#### 2. Local Backend (Research Server)
The **Dermalyze** hybrid architecture connects to a local server for image and clinical data storage.
*   Ensure your local backend is running. Access [https://github.com/e-magesk/dermalyze-backend.git](https://github.com/e-magesk/dermalyze-backend.git) to more information.

## 🛠️ How to Run the Project
1.  Clone this repository:
    ```bash
    git clone [https://github.com/e-magesk/dermalyze.git](https://github.com/e-magesk/dermalyze.git)
    ```
2.  Navigate to the project folder:
    ```bash
    cd dermalyze
    ```
3.  Install the dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the application:
    ```bash
    flutter run
    ```

## 📂 Project Structure
The project follows a modular architecture to ensure separation of concerns:
*   `lib/src/modules`: Contains features (screens, controllers, and feature-specific widgets).
*   `lib/src/core`: Global constants, themes, and utilities.
*   `lib/src/shared`: Reusable components shared across multiple modules.
*   

## ⚙️ Development Tips

### Localization (l10n)
This project uses the official `flutter_gen` package to manage multiple languages. To add new strings to the application, follow these steps:

#### 1. Add the key to the ARB files
Locate the files in `lib/src/core/l10n/` and add the new key to both files (Portuguese and English):

*   `app_pt.arb`:

```JSON
"myNewString": "Texto em Português"
```

*   `app_en.arb`:

```JSON
"myNewString": "Text in English"
```

#### 2. Generate the Dart code
After saving the files, run the command below in your terminal so Flutter can generate the automatic methods:

```bash
flutter gen-l10n
```

## 📚 Research & Publications

The development of **Dermalyze** is backed by academic research conducted at the **Laboratório de Inteligência Artificial em Saúde (LIFE/UFES)**. 

If you use this work or find it helpful for your research, please cite our paper:

*   **Dermalyze: uma aplicação para auxílio à triagem de lesões de pele baseado em aprendizado profundo**  
    *Published at the 31st Brazilian Symposium on Multimedia and the Web (WebMedia 2025)*  
    [Read the full paper here](https://sol.sbc.org.br/index.php/webmedia/article/view/37961)

## 📄 License
This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.