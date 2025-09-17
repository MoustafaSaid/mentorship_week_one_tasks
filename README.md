# Smart Ahwa Manager - Flutter Order Management System

A comprehensive Flutter application designed to demonstrate Object-Oriented Programming (OOP) principles and SOLID design patterns through a real-world coffee shop order management system.




https://github.com/user-attachments/assets/762d3798-8297-4625-8857-899dc9a048b6





## 🎯 Project Overview

The Smart Ahwa Manager is a mobile application that helps coffee shop owners manage their daily operations, including:
- **Order Management**: Create, track, and complete customer orders
- **Inventory Tracking**: Manage drink menu and pricing
- **Analytics & Reporting**: View sales statistics and performance metrics
- **Real-time Updates**: Track pending and completed orders

## 🏗️ Architecture & Design Decisions

### Clean Architecture
The application follows Clean Architecture principles with clear separation of concerns:

```
┌─────────────────────────────────────┐
│        Presentation Layer           │
│    (Screens, Widgets, UI)          │
│    app/presentation/                │
├─────────────────────────────────────┤
│         Domain Layer                │
│    (Services, Repositories)         │
│    app/domain/                      │
├─────────────────────────────────────┤
│      Infrastructure Layer           │
│    (Models, Hive Database)         │
│    app/data/              │
├─────────────────────────────────────┤
│           Core Layer                │
│    (Shared utilities, constants)    │
│    app/core/                        │
└─────────────────────────────────────┘
```

### Key Architectural Decisions

1. **Clean Architecture Structure**
   - **Presentation Layer** (`app/presentation/`): UI screens and widgets
   - **Domain Layer** (`app/domain/`): Business logic, services, and repositories
   - **Infrastructure Layer** (`app/infrastructure/`): Models and data persistence
   - **Core Layer** (`app/core/`): Shared utilities and constants
   - Clear separation of concerns with unidirectional dependencies

2. **Repository Pattern Implementation**
   - Abstracted data access through `IOrderRepository` interface
   - Concrete implementation with `OrderRepository` using Hive database
   - Enables easy switching between different data sources (Hive, SQLite, API)

3. **Service Layer for Business Logic**
   - `OrderService` encapsulates all business rules and validation
   - Separates business logic from data access and presentation
   - Makes the code more testable and maintainable

4. **Model-Driven Design**
   - Rich domain models (`Order`, `Drink`) with business logic
   - Immutable data structures with `copyWith` methods
   - Type-safe enums for order status management

5. **Dependency Injection**
   - Services depend on abstractions, not concrete implementations
   - Easy to mock for unit testing
   - Flexible and loosely coupled design

## 🎨 Object-Oriented Programming Principles

### 1. Encapsulation
- **Private fields** in services and models hide internal implementation
- **Public methods** provide controlled access to functionality
- **Data models** encapsulate their properties and behaviors

```dart
class Order {
  final String id;
  final String customerName;
  final Drink drink;
  final OrderStatus status;
  
  // Encapsulated business logic
  bool get isPending => status == OrderStatus.pending;
  bool get isCompleted => status == OrderStatus.completed;
}
```

### 2. Inheritance
- Models extend `HiveObject` for database persistence capabilities
- Shared behavior through base classes
- Type-safe status management with enums

### 3. Polymorphism
- Interface-based programming with `IOrderRepository`
- Different implementations can be swapped without changing client code
- Enum-based status handling provides polymorphic behavior

### 4. Abstraction
- Complex data operations abstracted through repository pattern
- Business logic abstracted through service layer
- UI components abstracted through Flutter widgets

## 🔧 SOLID Principles Implementation

### 1. Single Responsibility Principle (SRP)
Each class has one reason to change:

- **`OrderService`**: Handles only order-related business logic
- **`HiveService`**: Manages only data persistence operations
- **`OrderRepository`**: Handles only data access abstraction
- **`Drink` & `Order` models**: Represent only their specific data structures

### 2. Open/Closed Principle (OCP)
System is open for extension, closed for modification:

- **`IOrderRepository` interface**: Allows new storage implementations without changing existing code
- **`OrderService`**: Can be extended with new business rules without modification
- **Data models**: Can be extended with new properties without breaking existing functionality

### 3. Dependency Inversion Principle (DIP)
High-level modules don't depend on low-level modules:

- **`OrderService`** depends on **`IOrderRepository`** (abstraction)
- **UI screens** depend on **`OrderService`** (abstraction)
- **`HiveService`** is injected through the repository pattern

## 📱 Features & Functionality

### Core Features
- ✅ **Order Creation**: Create new orders with customer details and drink selection
- ✅ **Order Management**: View, update, and complete orders
- ✅ **Real-time Tracking**: Monitor pending and completed orders
- ✅ **Analytics Dashboard**: View sales statistics and performance metrics
- ✅ **Drink Management**: Manage menu items and pricing
- ✅ **Table Management**: Track orders by table number

### Technical Features
- ✅ **Local Database**: Hive database for offline data persistence
- ✅ **Type Safety**: Strong typing with Dart's type system
- ✅ **Error Handling**: Comprehensive error handling and validation
- ✅ **Responsive UI**: Material Design 3 with modern Flutter widgets
- ✅ **State Management**: Efficient state management with StatefulWidget

## 🛠️ Technology Stack

- **Framework**: Flutter 3.5.3+
- **Language**: Dart
- **Database**: Hive (NoSQL local database)
- **State Management**: Flutter's built-in state management
- **UI**: Material Design 3
- **Architecture**: Clean Architecture with Repository Pattern

## 📦 Project Structure

```
lib/
├── app/
│   ├── data/
│   │   └── models/       # Data models
│   │       ├── drink.dart
│   │       └── order.dart
│   ├── domain/
│   │   ├── repositories/ # Data access layer
│   │   │   └── order_repository.dart
│   │   └── services/     # Business logic layer
│   │       ├── hive_service.dart
│   │       └── order_service.dart
│   ├── presentation/
│   │   ├── screens/      # UI screens
│   │   │   ├── new_order.dart
│   │   │   ├── orders_screen.dart
│   │   │   ├── pending_orders.dart
│   │   │   └── reports_screen.dart
│   │   └── widgets/      # Reusable UI components
│   │       └── bottom_nav_bar.dart
│   └── core/             # Shared utilities
├── questions/            # Mentorship tasks
└── main.dart            # Application entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.5.3 or higher
- Dart SDK
- Android Studio or VS Code with Flutter extensions

### Installation
1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate Hive adapters:
   ```bash
   flutter packages pub run build_runner build
   ```
5. Run the application:
   ```bash
   flutter run
   ```

## 📚 Learning Outcomes

This project demonstrates:

1. **Clean Architecture**: How to structure a Flutter app for maintainability
2. **SOLID Principles**: Practical application of software design principles
3. **OOP Concepts**: Real-world implementation of object-oriented programming
4. **Design Patterns**: Repository pattern, Service layer, and Dependency Injection
5. **Flutter Best Practices**: State management, navigation, and UI design
6. **Database Integration**: Local data persistence with Hive
7. **Error Handling**: Robust error handling and user feedback
