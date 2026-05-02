# Dermalyze

**Dermalyze** is a mobile solution developed with Flutter that utilizes Deep Learning models for skin lesion screening and analysis. The goal is to provide a clinical decision support tool, facilitating the triage of suspicious cases in primary care settings.

## 🚀 Prerequisites
Before you begin, ensure you have the following installed:
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version).
*   [Dart SDK](https://dart.dev/get-dart).
*   **VS Code** with *Flutter* and *Dart* extensions.
*   An Android/iOS emulator or a configured physical device.

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

## 📚 Research & Publications

The development of **Dermalyze** is backed by academic research conducted at the **Laboratório de Inteligência Artificial em Saúde (LIFE/UFES)**. 

If you use this work or find it helpful for your research, please cite our paper:

*   **Dermalyze: uma aplicação para auxílio à triagem de lesões de pele baseado em aprendizado profundo**  
    *Published at the 31st Brazilian Symposium on Multimedia and the Web (WebMedia 2025)*  
    [Read the full paper here](https://sol.sbc.org.br/index.php/webmedia/article/view/37961)

## 📄 License
This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.