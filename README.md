# FakeStore Flutter App

This Flutter application demonstrates the usage of the [FakeStore API](https://fakestoreapi.com/). It showcases fetching products, viewing product details and basic CRUD operations using **BLoC** for state management and a simple Clean Architecture approach.

## Structure
- `lib/features` contains feature folders following a clean architecture pattern.
- `lib/main.dart` wires repositories, use cases and blocs together.

## Getting Started
Make sure you have Flutter installed. Then run:

```bash
flutter pub get
flutter run
```

The home screen loads products from the FakeStore API. Tap a product to view details. Pull to refresh using the floating action button.
