
# Smart Medicare Application

## Overview

Smart Medicare is a Flutter-based healthcare monitoring application that integrates Firebase Realtime Database to collect, store, and display real-time data such as heart rate (BPM), body temperature, SPO2 levels, and health stage. It aims to provide an interactive and efficient user experience for health tracking.

## Features

- **Real-time Health Monitoring:** 
  - Heart rate (BPM)
  - Body temperature
  - SPO2 levels
  - Health stage display
- **User Input:**
  - Collects user details like birth year and gender to calculate age and store health data.
- **Firebase Integration:**
  - Sends and retrieves health data using Firebase Realtime Database.
- **Lottie Animations:**
  - Engaging animations for a better user experience.
- **Responsive Design:**
  - Optimized for various device sizes using `responsive_sizer`.

## Dependencies

The application uses the following Flutter dependencies:
- `firebase_database`
- `google_fonts`
- `lottie`
- `responsive_sizer`
- `intl`

## Getting Started

### Prerequisites
1. Ensure you have Flutter installed.
2. Configure your Firebase project and download the `google-services.json` file.
3. Place the `google-services.json` file in the `android/app` directory of your Flutter project.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/dinethsiriwardana/Smart-Medic.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Usage
1. Input your birth year and select your gender.
2. Click on the "Send Data" button to store your health data in Firebase.
3. Real-time health data updates will be displayed on the home screen.


## License
This project is licensed under the MIT License.

## Acknowledgements
- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Google Fonts](https://fonts.google.com/)
