# formrules

[![Pub Version](https://img.shields.io/pub/v/formrules?color=blue)](https://pub.dev/packages/formrules)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)]()
[![Flutter](https://img.shields.io/badge/Flutter-%E2%9D%A4-red.svg)]()
[![Live Demo](https://img.shields.io/badge/demo-live-brightgreen.svg)](https://formrules.vercel.app)

A comprehensive, zero-dependency, fail-fast, fluent validation library for Flutter `TextFormField`.

## Why `formrules`?

1. **Zero External Dependencies**: Pure Dart. No `intl`, no bloat.
2. **Fail-Fast**: Stops checking the moment a rule fails, returning the exact error message.
3. **Fluent Chainable API**: Beautiful readable builder syntax.
4. **Graceful Optionals**: By design, all rules (except `required`) pass silently if the input is `null` or empty, making optional fields a breeze.
5. **Highly Extensible**: Easily add inline closures or full custom rule classes.

## Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/Mahesh-Langote/formrules/main/screenshots/home_screen.png" width="800" alt="Home Screen Showcase">
  <br>
  <em>Rule Showcase Gallery</em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mahesh-Langote/formrules/main/screenshots/registration_form.png" width="800" alt="Registration Form Demo">
  <br>
  <em>Comprehensive Registration Form Demo</em>
</p>

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  formrules: ^1.0.0
```

## Basic Usage

Simply use `FormRules.<rule>()...build()` directly inside the `validator` parameter of a `TextFormField`.

```dart
TextFormField(
  decoration: const InputDecoration(labelText: 'Email Address'),
  validator: FormRules.required(message: 'Email is required')
      .email(message: 'Please enter a valid email address')
      .build(),
),
```

> **Note:** The `.build()` call at the end of the chain is required. It converts the fluent builder into the `String? Function(String?)` closure expected by Flutter.

## All 31 Built-in Rules

| Rule | Description |
|------|-------------|
| `required` | Ensures the field is not null or empty. |
| `email` | Validates an email address. |
| `minLength(n)` | Validates a minimum length. |
| `maxLength(n)` | Validates a maximum length. |
| `url` | Validates a URL. |
| `phone` | Validates a phone number. |
| `numeric` | Validates that the input is numeric. |
| `regex(pattern)` | Validates against a custom regex pattern. |
| `match(getValue)` | Validates that the input matches another field. |
| `noSpecialChars` | Ensures there are no special characters. |
| `alpha` | Ensures the value contains only alphabetic characters. |
| `alphaNumeric` | Ensures the value contains only alphanumeric characters. |
| `lowercase` | Ensures the value is strictly lowercase. |
| `uppercase` | Ensures the value is strictly uppercase. |
| `inList(values)` | Ensures the value matches one of the items in the list. |
| `notInList(values)` | Ensures the value does NOT match any item in the list. |
| `equals(value)` | Ensures the value exactly equals a hardcoded string. |
| `notEquals(value)` | Ensures the value does NOT equal a hardcoded string. |
| `contains(substring)` | Ensures the value contains a specific substring. |
| `startsWith(prefix)` | Ensures the value starts with a specific prefix. |
| `endsWith(suffix)` | Ensures the value ends with a specific suffix. |
| `ipAddress` | Validates standard IPv4 and/or IPv6 addresses. |
| `macAddress` | Validates a standard MAC address. |
| `creditCard` | Validates credit card numbers (Luhn algorithm). |
| `date` | Validates that the input is a valid date (ISO-8601). |
| `uuid` | Validates a standard UUID. |
| `hexColor` | Validates a standard hex color string. |
| `base64` | Validates that the string is properly Base64 encoded. |
| `json` | Validates that the string is valid JSON. |
| `slug` | Validates a URL-friendly slug. |
| `password` | An all-in-one strong password validator rule. |
| `custom(fn)` | Add a custom inline validator. |
| `addRule(rule)` | Add a custom rule class. |

## Advanced Customization

### Inline Custom Validation
If you need a quick custom check, use `.custom()`:

```dart
TextFormField(
  validator: FormRules.required()
      .custom((value) {
        if (value != 'secret') return 'Wrong secret word!';
        return null; // pass
      })
      .build(),
)
```

### Custom Rule Classes
For reusable custom logic, extend `ValidationRule` and add it via `.addRule()`:

```dart
class AsyncLookaheadRule extends ValidationRule {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!value.startsWith('A')) return 'Must start with A';
    return null;
  }
}

// Usage:
TextFormField(
  validator: FormRules.required().addRule(AsyncLookaheadRule()).build(),
)
```

## Global Localization

You can easily provide your own error messages globally for the entire app by overriding the default messages class:

```dart
class CustomMessages extends FormRulesMessagesEn {
  @override
  String get required => 'Este campo es obligatorio.';
  
  @override
  String get email => 'Correo electrónico inválido.';
}

void main() {
  FormRules.setMessages(CustomMessages());
  runApp(const MyApp());
}
```

## Contributing

See our [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to add new rules to this package. We strictly maintain 100% test coverage and zero dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
