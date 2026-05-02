# Contributing to formrules

First off, thank you for considering contributing to `formrules`! It's people like you that make open source tools great.

## Core Architecture Rules

Before you submit a pull request, please make sure your changes strictly adhere to the following package principles:

### 1. Zero Dependencies
This package must remain 100% dependency-free (other than the Flutter SDK). We do not accept PRs that add external packages to `pubspec.yaml` under dependencies.

### 2. Fail-Fast Validation
All validators execute sequentially. If a validator fails, it must immediately return its error message and halt execution of the remaining rules.

### 3. Graceful Empty Handling
Except for the `required` rule, all other rules **must** pass silently if the input is `null` or empty (`''`). This allows rules to be used on optional fields without inadvertently making them mandatory.

### 4. Fluent API
All rules are added via method chaining on the `Validator` builder class. The final `.build()` call is mandatory to yield the `FormFieldValidator<String>` closure.

---

## How to Add a New Rule

If you are adding a new built-in rule, you must follow these 4 steps:

### Step 1: Create the Rule Class
Add a new class extending `ValidationRule` in `lib/src/rules/rules.dart`.
```dart
class MyNewRule extends ValidationRule {
  final String message;
  const MyNewRule(this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null; // Graceful empty handling
    if (/* validation fails */) return message;
    return null;
  }
}
```

### Step 2: Add Default Localization
Add the default English error message for your rule in `lib/src/l10n/messages/en.dart`.

### Step 3: Add the Builder Method
Add the method to the `Validator` class inside `lib/src/validator.dart`.
```dart
Validator myNewRule({String? message}) {
  _rules.add(MyNewRule(message ?? _messages.myNewRule));
  return this;
}
```

### Step 4: Add the Static Gateway
Add the static method to the `FormRules` class inside `lib/src/validator.dart`.
```dart
static Validator myNewRule({String? message}) => Validator._()..myNewRule(message: message);
```

---

## Testing Your Changes

We maintain a strict **100% test coverage** requirement. Any new rule must have a corresponding test file in `test/rules/`.

Before submitting a PR, ensure that:
1. `dart format .` runs cleanly (no changes required).
2. `dart analyze` reports `No issues found!`.
3. `flutter test --coverage` passes with 100% coverage.

## Opening a Pull Request
- Use a clear, descriptive title.
- Link to any related issues.
- Provide a summary of the changes and why they are necessary.
