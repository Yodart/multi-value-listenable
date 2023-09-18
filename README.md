# Multi Value Listenable

![Pub Version](https://img.shields.io/pub/v/multi_value_listenable)
![GitHub](https://img.shields.io/github/license/your-username/multi_value_listenable)

**Multi Value Listenable** is a Flutter package that provides a flexible widget for listening to multiple [ValueListenable]s and rebuilding your UI when any of them change. This makes it easier to manage complex UIs that depend on multiple data sources.

## Key Features

- **Listen to Multiple Values**: Effortlessly listen to changes in multiple [ValueListenable]s.
- **Customizable Builders**: Define your own widget tree based on the values.
- **Efficient Updates**: Rebuild your UI only when the values change, optimizing performance.
- **Synchronization**: Keep your UI in sync with various data sources with ease.

## Getting Started

1. **Installation**: Add the `multi_value_listenable` package to your `pubspec.yaml`:

```yaml
dependencies:
  multi_value_listenable: ^1.0.0  # Replace with the latest version
```

2. **Import**: Import the package in your Dart code

```dart
import 'package:multi_value_listenable/multi_value_listenable.dart';
```

3. **Usage**: 

```dart
final list = ValueNotifier<List<int>>([1, 2, 3]);
final count = ValueNotifier<int>(3);

// Create a MultiValueListenableBuilder
final builder = MultiValueListenableBuilder(
  valueListenables: [list, count],
  builder: (context, values, child) {
    final list = values[0] as List<int>;
    final count = values[1] as int;
    return Text('List: $list, Count: $count');
  },
);
```

## Example
Here's a simple example demonstrating how to use MultiValueListenableBuilder:

```dart
import 'package:flutter/material.dart';
import 'package:multi_value_listenable/multi_value_listenable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = ValueNotifier<List<int>>([1, 2, 3]);
    final count = ValueNotifier<int>(3);

    final builder = MultiValueListenableBuilder(
      valueListenables: [list, count],
      builder: (context, values, child) {
        final list = values[0] as List<int>;
        final count = values[1] as int;
        return Text('List: $list, Count: $count');
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multi Value Listenable Example'),
        ),
        body: Center(
          child: builder,
        ),
      ),
    );
  }
}
```


