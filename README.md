# MultiSelectDropDownPro

MultiSelectDropDown Pro is a Flutter package that provides a customizable and easy-to-use multi-select dropdown widget. It allows users to select multiple items from a list and provides a clean user interface.

## Features

- **Flexible Configuration:** Customize the appearance with various options like primary color, suffix icon, and separator.
- **Easy Integration:** Integrate the multi-select dropdown effortlessly into your Flutter applications.
- **Dynamic Updates:** Real-time updates of selected items with a callback function.

## Getting Started

To use this package, add `multiselect_dropdown_pro` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  multiselect_dropdown_pro: ^1.0.0
```

Then run

```bash
flutter pub get
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:multiselect_dropdown_pro/multiselect_dropdown_pro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MultiSelectDropDown Example'),
        ),
        body: Center(
          child: MultiSelectDropDown(
            title: 'Select Options',
            items: ['Option 1', 'Option 2', 'Option 3'],
            onChanged: (selectedItems) {
              print('Selected Items: $selectedItems');
            },
            value: 'Option 1,,,Option 2', // Initial selected values
            hint: 'Select options',
            primaryColor: Colors.blue, // Customize primary color
            suffixIcon: Icons.arrow_drop_down, // Customize suffix icon
            separator: ',,,', // Customize separator
          ),
        ),
      ),
    );
  }
}
```

## Additional Information

For more information, contributions, and issue reporting, please visit the [GitHub repository]("https://github.com/yuvrajgrover6/multiselect_dropdown").

Feel free to explore and customize the package according to your needs. If you encounter any issues or have suggestions, please don't hesitate to open an issue on GitHub.

Happy coding!
