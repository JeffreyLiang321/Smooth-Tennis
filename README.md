# Smooth Tennis

### Sports Social Media App for Players & Coaches

Smooth Tennis is a mobile application that connects tennis players and coaches, enabling users to share gameplay challenges, receive feedback, and improve performance through a collaborative social platform.

---

## Overview

The platform supports two primary user roles:

* **Players**: Share posts about challenges, techniques, or gameplay issues
* **Coaches**: Provide feedback, advice, and solutions to player posts

The goal is to create a community-driven environment where players can improve through expert insights and peer interaction.

---

## Features

* User authentication with Firebase
* Post creation and social feed
* Role-based interaction (players vs coaches)
* Commenting and feedback system
* Real-time data handling via Firestore

---

## Tech Stack

* **Language:** Swift
* **Framework:** iOS (UIKit / Xcode)
* **Backend:** Firebase (Authentication, Firestore)
* **Dependency Management:** CocoaPods

---

## Getting Started

### Prerequisites

* Xcode 14.3.1 or later
* CocoaPods installed (`sudo gem install cocoapods`)

### Installation

1. Clone the repository:

   ```
   git clone https://github.com/yourusername/smooth-tennis.git
   ```

2. Navigate into the project directory:

   ```
   cd smooth-tennis
   ```

3. Install dependencies:

   ```
   pod install
   ```

4. Open the workspace file in Xcode:

   ```
   open SmoothTennis.xcworkspace
   ```

5. Build and run the project using the active scheme

---

## Usage

* Sign up or log in as a player or coach
* Players can create posts describing tennis-related issues
* Coaches can respond with feedback and solutions
* Users can browse and interact with posts in the feed

---

## Architecture

The app follows a client-server model:

* **Frontend (iOS App):** Handles UI, user interaction, and request handling
* **Backend (Firebase):** Manages authentication and real-time database storage

Core components:

* Authentication layer (user roles and login)
* Post and feed system (Firestore collections)
* Interaction system (comments and responses)

---

## Project Structure

```
SmoothTennis/
├── Models/        # Data models (users, posts, comments)
├── Views/         # UI components and screens
├── Controllers/   # View controllers and logic
├── Services/      # Firebase and networking logic
├── Resources/     # Assets and configuration files
```

---

## Testing

Testing support is minimal in this version of the project.
The app was primarily tested through manual interaction in the iOS simulator.

---

## Dependencies

* Firebase Authentication
* Firebase Firestore
* CocoaPods

---

## Notes

This project was built as an early exploration of:

* Mobile app development (iOS)
* Social platform design
* Backend integration using Firebase

---

## Future Improvements

* Add push notifications for responses
* Improve UI/UX design and responsiveness
* Implement ranking/reputation system for coaches
* Add search and filtering for posts

---

## Author

Jeffrey Liang
Brown University — CS & Economics

---

## License

This project is for educational and demonstration purposes.
