# Flutter Project Setup Guide

This guide will help you set up a Flutter project from scratch, including downloading the Flutter SDK and running the project on both Windows and Mac.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Downloading the Flutter SDK](#downloading-the-flutter-sdk)
   - [Windows](#windows)
   - [Mac](#mac)
3. [Setting Up Your Development Environment](#setting-up-your-development-environment)
   - [Windows](#windows-1)
   - [Mac](#mac-1)
4. [Running the Flutter Project](#running-the-flutter-project)
5. [Additional Resources](#additional-resources)

## Prerequisites

- A computer running Windows or MacOS
- Git installed on your system (optional but recommended for version control)
- An IDE or code editor (Visual Studio Code with Flutter and Dart plugins, or Android Studio)

## Downloading the Flutter SDK

### Windows

1. Go to the [Flutter SDK releases](https://docs.flutter.dev/get-started/install/windows#download-the-flutter-sdk) page.
2. Download the latest stable release ZIP file.
3. Extract the ZIP file to a location of your choice (e.g., `C:\src\flutter`).

### Mac

1. Go to the [Flutter SDK releases](https://docs.flutter.dev/get-started/install/macos#download-the-flutter-sdk) page.
2. Download the latest stable release ZIP file.
3. Extract the ZIP file to a location of your choice (e.g., `~/development/flutter`).

## Setting Up Your Development Environment

### Windows

1. **Update your system's PATH:**
   - Open the Start Search, type in "env", and select "Edit the system environment variables".
   - In the System Properties window, click on the "Environment Variables" button.
   - Under "System variables", find the `Path` variable, select it, and click "Edit".
   - Click "New" and add the path to the `flutter\bin` directory (e.g., `C:\src\flutter\bin`).
   - Click "OK" to close all the windows.

2. **Install required dependencies:**
   - Open a command prompt and run `flutter doctor`.
   - Follow the instructions to install any missing dependencies, such as the Android SDK, if required.

### Mac

1. **Update your system's PATH:**
   - Open a terminal.
   - Open (or create) the `.zshrc` file in your home directory:
     ```bash
     nano ~/.zshrc
     ```
   - Add the following line at the end of the file:
     ```bash
     export PATH="$PATH:`flutter_sdk_path`/flutter/bin"
     ```
     Replace `flutter_sdk_path` with the path where you extracted Flutter.
   - Save the file and run:
     ```bash
     source ~/.zshrc
     ```

2. **Install required dependencies:**
   - Run `flutter doctor` in the terminal.
   - Follow the instructions to install any missing dependencies, such as Xcode or Android Studio, if required.

## Running the Flutter Project

1. **Clone the project repository (if applicable):**
   ```bash
   git clone https://github.com/your-username/your-flutter-project.git
   cd your-flutter-project
