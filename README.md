# ptcbjahid

A new Flutter project.

## Getting Started

# Parity cube Pvt ltd Assignment - Deals App

This is my submission for the Parity cube Pvt ltd Android/Flutter assignment. It is a robust, functional application that fetches Top, Popular, and Featured deals from the DesiDime API.

I focused on **Clean Architecture**, **User Experience (Edge-to-Edge UI)**, and **Reliability (Offline Caching & Error Handling)**.

## 📱 Features

* **Tabs Navigation:** Seamless switching between Top, Popular, and Featured deals.
* **Infinite Scrolling:** Pagination implemented to load more deals automatically as the user scrolls.
* **Offline Support (Bonus):** Uses **Hive** (NoSQL DB) to cache the first page of deals. If the user opens the app without internet, it loads from the local database instantly.
* **Robust Error Handling:**
    * Friendly UI messages for network errors (timeouts, 404s).
    * "Retry" mechanism for failed loads.
* **Modern UI:**
    * **Material 3** design system.
    * **Edge-to-Edge** support (Transparent status bar & navigation bar handling for Android 15).
    * Shimmer/Loading indicators.

## 🛠️ Tech Stack & Libraries

I selected libraries that ensure scalability and industry-standard maintainability:

* **Architecture:** MVVM (Model-View-ViewModel) using Clean Architecture principles.
* **State Management:** `flutter_bloc` (Separates business logic from UI).
* **Networking:** `retrofit` & `dio` (Type-safe HTTP client with interceptors).
* **Local Database:** `hive` & `hive_flutter` (Lightweight, fast NoSQL database for caching).
* **Image Loading:** `cached_network_image`.
* **Code Generation:** `build_runner`, `json_serializable`, `mock_gen`.
* **Testing:** `mockito` & `bloc_test`.

## 🏗️ Project Structure

The project follows a feature-first / clean structure:

```text
lib/
├── core/             # Constants, Error Handlers (Failures)
├── data/
│   ├── network/      # Retrofit API Client
│   ├── localDB/      # Hive Data Source
│   ├── models/       # Data Models (JSON & Hive Annotations)
│   └── repositories/ # DealRepository (Handles API + Cache logic)
├── logic/
│   └── deals/        # BLoC (State Management)
├── presentation/
│   ├── screens/      # UI Screens
│   └── widgets/      # Reusable Widgets
└── main.dart         # Entry point & App Config

👨‍💻 About the Developer
Name: Jahid khan Role: Flutter Developer Project: DesiDime Mobile Assignment  Email: developer.jahidkhan@gmail.com Portfolio/GitHub: neollm.tech

Thank you for reviewing my submission. I look forward to your feedback!