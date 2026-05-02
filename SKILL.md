# formrules — Package Skill & Blueprint

> **Purpose:** This document is the single source of truth before any code is written.
> Every contributor (human or AI) must read this before touching the codebase.
> Decisions made here are final for v1.0 unless explicitly revised.

---

## 1. Package Identity

| Field        | Value |
|--------------|-------|
| Package name | `formrules` |
| Pub.dev tag  | Flutter form validation |
| License      | MIT |
| Dart SDK     | `>=3.0.0 <4.0.0` |
| Flutter SDK  | `>=3.10.0` |
| Target       | pub.dev (open source) |

**One-liner description:**
> A fluent, chainable Flutter form validator with a conflict-free static API, built-in rules, full localization support, and zero third-party dependencies.

---

## 2. Core Design Principles

### 2.1 Zero External Dependencies
- `dependencies:` block contains **only** the Flutter SDK.
- No `intl`, no `collection`, no utility packages.
- Everything is written from scratch — regex, parsing, localization delegate.
- Reason: keeps the package lightweight, avoids version conflicts in consumer apps.

### 2.2 Fluent / Builder Pattern
```dart
// This is the ONLY valid public API shape. Never break this.
TextFormField(
  validator: FormRules.required()
    .email()
    .minLength(5)
    .maxLength(50)
    .build(),
)
```
- `FormRules` is a **non-instantiable static gateway** — the sole public entry point.
- Each static method on `FormRules` spins up a fresh internal `Validator` builder and
  adds the first rule, then returns the builder for chaining.
- Every subsequent rule method returns `this` (the same internal `Validator` instance).
- `.build()` is the terminal method — returns `FormFieldValidator<String>`.
- Rules run **in the order they are chained**. First failure wins.

**Why `FormRules` and not `Validator()`:**
- `Validator` is one of the most name-collided classes in the Flutter ecosystem
  (`Dio`, `reactive_forms`, `form_validator`, etc. all define one). `FormRules` is
  unique to this package and never conflicts.
- Brand visibility — every form field in the consumer's codebase reads `FormRules.x()`,
  making the package identity visible in production code.
- IDE discoverability — typing `FormRules.` surfaces every available rule via autocomplete
  without needing to know to instantiate a builder first.

### 2.3 Fail-Fast Validation
- Rules run sequentially; the **first failing rule** stops the chain and returns its message.
- This matches Flutter's native `TextFormField.validator` contract.

### 2.4 Non-Blocking Empty Value Policy
- All rules except `required()` **silently pass** on `null` or empty string.
- Reason: if a field is optional, `email()` alone should not error on empty input.
- `required()` is always the **first rule** in any chain that needs a value.

### 2.5 Immutability of Built Validator
- Once `.build()` is called, the returned closure is a pure function.
- The `Validator` instance itself is mutable during building (builder pattern), but the final validator function must have no side effects.

---

## 3. Package Structure

```
formrules/
├── lib/
│   ├── formrules.dart              ← Single public export barrel
│   └── src/
│       ├── validator.dart          ← Validator builder class (main API)
│       ├── rules/
│       │   ├── rule.dart           ← Abstract ValidationRule base class
│       │   └── rules.dart          ← All built-in rule implementations
│       └── l10n/
│           ├── form_rules_localizations.dart   ← Localization controller
│           └── messages/
│               └── en.dart         ← Default English messages (base class)
├── test/
│   ├── rules/
│   │   ├── required_test.dart
│   │   ├── email_test.dart
│   │   ├── min_length_test.dart
│   │   ├── max_length_test.dart
│   │   ├── url_test.dart
│   │   ├── phone_test.dart
│   │   ├── numeric_test.dart
│   │   ├── regex_test.dart
│   │   ├── match_test.dart
│   │   └── no_special_chars_test.dart
│   ├── validator_chain_test.dart   ← Integration: chaining behavior
│   └── l10n_test.dart              ← Localization override tests
├── example/
│   └── lib/
│       └── main.dart               ← Runnable example app
├── CHANGELOG.md
├── README.md
├── LICENSE
├── analysis_options.yaml
└── pubspec.yaml
```

**Rule:** Every `src/` file is private. Nothing is imported from `src/` directly by consumers — only via `formrules.dart`.

---

## 4. Public API Contract

### 4.0 FormRules — Static Gateway (Primary Entry Point)

```dart
/// The primary entry point for all form validation.
/// Non-instantiable — every method returns a [Validator] builder
/// with the first rule already applied.
final class FormRules {
  FormRules._();

  static Validator required({String? message}) =>
      Validator._()..required(message: message);
  static Validator email({String? message}) =>
      Validator._()..email(message: message);
  static Validator minLength(int min, {String? message}) =>
      Validator._()..minLength(min, message: message);
  static Validator maxLength(int max, {String? message}) =>
      Validator._()..maxLength(max, message: message);
  static Validator url({bool requireHttps = false, String? message}) =>
      Validator._()..url(requireHttps: requireHttps, message: message);
  static Validator phone({RegExp? pattern, String? message}) =>
      Validator._()..phone(pattern: pattern, message: message);
  static Validator numeric({String? message}) =>
      Validator._()..numeric(message: message);
  static Validator regex(RegExp pattern, {required String message}) =>
      Validator._()..regex(pattern, message: message);
  static Validator match(String? Function() getValue, {String? message}) =>
      Validator._()..match(getValue, message: message);
  static Validator noSpecialChars({String allowed = '', String? message}) =>
      Validator._()..noSpecialChars(allowed: allowed, message: message);
  static Validator custom(String? Function(String? value) validator) =>
      Validator._()..custom(validator);
  static Validator addRule(ValidationRule rule) =>
      Validator._()..addRule(rule);
}
```

**Rules for `FormRules`:**
- `final class` — cannot be extended or mixed in.
- Private constructor `FormRules._()` — cannot be instantiated.
- Every static method mirrors a `Validator` instance method 1-to-1.
- Adding a new built-in rule requires a matching static method here **and** on `Validator`.

### 4.1 Validator Class (Internal Builder)

```dart
/// Internal builder — consumers should not instantiate this directly.
/// Use [FormRules] static methods as the entry point instead.
class Validator {
  // Private constructor — only FormRules and Validator's own chain methods
  // should create instances.
  Validator._({FormRulesMessagesEn? messages});

  // ── Built-in rules ──────────────────────────────────────────
  Validator required({String? message});
  Validator email({String? message});
  Validator minLength(int min, {String? message});
  Validator maxLength(int max, {String? message});
  Validator url({bool requireHttps = false, String? message});
  Validator phone({RegExp? pattern, String? message});
  Validator numeric({String? message});
  Validator regex(RegExp pattern, {required String message});
  Validator match(String? Function() getValue, {String? message});
  Validator noSpecialChars({String allowed = '', String? message});

  // ── Extensibility ───────────────────────────────────────────
  Validator custom(String? Function(String? value) validator);
  Validator addRule(ValidationRule rule);   // for class-based custom rules

  // ── Terminal ────────────────────────────────────────────────
  FormFieldValidator<String> build();
}
```

**Breaking change rules:**
- No parameter can be removed in a minor version.
- New optional named parameters are non-breaking.
- `build()` return type must never change.

### 4.2 ValidationRule (Extension Point)

```dart
abstract class ValidationRule {
  const ValidationRule();
  String? validate(String? value);
}
```

Users extend this to build their own reusable rule classes, then inject via `.addRule()`.

### 4.3 Localization

```dart
// Base message class — consumers extend this to add their language
class FormRulesMessagesEn {
  const FormRulesMessagesEn();

  String get required     => 'This field is required.';
  String get email        => 'Enter a valid email address.';
  String minLength(int n) => 'Must be at least $n characters.';
  String maxLength(int n) => 'Must be no more than $n characters.';
  String get url          => 'Enter a valid URL.';
  String get urlHttps     => 'URL must use HTTPS.';
  String get phone        => 'Enter a valid phone number.';
  String get numeric      => 'Only numbers are allowed.';
  String get regex        => 'Invalid format.';
  String get match        => 'Fields do not match.';
  String get noSpecialChars => 'Special characters are not allowed.';
}

// Global override (set once in main())
FormRulesLocalizations.current = MyArabicMessages();

// Per-instance override — pass messages through FormRules static call
// Note: for per-instance overrides, construct the Validator directly
// (the one place where direct instantiation is permitted):
Validator._(messages: MyArabicMessages()).required().build()
```

**Localization pattern:** Subclass `FormRulesMessagesEn`, override only what you need. This avoids breaking consumers when new messages are added (they inherit the English default).

---

## 5. All Built-in Rules — Behavior Specification

All rules are accessible via `FormRules.x()` static methods. When starting a chain
with a rule other than `required`, the field is treated as optional — empty input
silently passes all non-required rules.

| Rule | Passes on empty? | Key behavior |
|------|-----------------|--------------|
| `required` | ❌ No | Fails on `null`, `''`, or whitespace-only |
| `email` | ✅ Yes | RFC-5322 simplified regex |
| `minLength(n)` | ✅ Yes | `value.length >= n` |
| `maxLength(n)` | ✅ Yes | `value.length <= n` |
| `url` | ✅ Yes | Valid URI with `http` or `https` scheme |
| `url(requireHttps: true)` | ✅ Yes | Only `https` scheme accepted |
| `phone` | ✅ Yes | `+?[0-9\s\-().]{7,20}` by default; overridable |
| `numeric` | ✅ Yes | `num.tryParse(value) != null` |
| `regex(pattern)` | ✅ Yes | `pattern.hasMatch(value)` |
| `match(getValue)` | ✅ Yes | `value == getValue()` — use for confirm password |
| `noSpecialChars` | ✅ Yes | Blocks `[^a-zA-Z0-9\s]`; `allowed` param whitelist |
| `custom(fn)` | User-defined | Full control via lambda |
| `addRule(rule)` | User-defined | Full control via class |

---

## 6. Linting & Code Style

### 6.1 analysis_options.yaml (strict)

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  language:
    strict-casts: true
    strict-raw-types: true
    strict-inference: true
  errors:
    missing_required_param: error
    missing_return: error
    dead_code: warning
    unused_import: error
    unused_element: warning

linter:
  rules:
    - always_declare_return_types
    - always_use_package_imports
    - avoid_dynamic_calls
    - avoid_print
    - avoid_redundant_argument_values
    - avoid_relative_lib_imports
    - avoid_returning_null_for_void
    - avoid_shadowing_type_parameters
    - avoid_types_as_parameter_names
    - cancel_subscriptions
    - comment_references
    - directives_ordering
    - document_ignores
    - eol_at_end_of_file
    - exhaustive_cases
    - file_names
    - flutter_style_todos
    - no_duplicate_case_values
    - no_logic_in_create_state
    - package_api_docs         # every public symbol must have a doc comment
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_fields
    - prefer_final_locals
    - prefer_single_quotes
    - sort_pub_dependencies
    - unawaited_futures
    - unnecessary_breaks
    - use_if_null_to_convert_nulls_to_bools
    - use_string_buffers
```

### 6.2 Naming Conventions

| Thing | Convention | Example |
|-------|-----------|---------|
| Files | `snake_case` | `form_rules_localizations.dart` |
| Classes | `PascalCase` | `FormRulesMessagesEn` |
| Rule classes | `<Name>Rule` | `EmailRule`, `MinLengthRule` |
| Private fields | `_camelCase` | `_rules`, `_messages` |
| Test files | `<subject>_test.dart` | `email_test.dart` |

### 6.3 Formatting
- `dart format .` must produce **zero diff** before every commit.
- Line length: **80 characters** (Dart default).
- Trailing commas on all multi-line function calls and parameter lists.

---

## 7. Documentation Standards

### 7.1 Every Public Symbol Needs a Doc Comment

```dart
/// Validates that the field is not null, empty, or whitespace-only.
///
/// ```dart
/// Validator().required().build()
/// ```
Validator required({String? message}) { ... }
```

- Use `///` (triple slash), never `//` or `/* */` for public APIs.
- Include a one-line summary, then a blank `///` line, then details or example.
- Dartdoc code samples must be valid and runnable.

### 7.2 README.md Sections (mandatory)

```
# formrules

[pub badge] [license badge] [dart badge]

One-paragraph description.

## Features
## Installation
## Quick Start
## All Rules (table)
## Localization
## Custom Rules
## Contributing
## License
```

### 7.3 CHANGELOG.md Format (Keep a Changelog)

```md
## [1.0.0] - YYYY-MM-DD
### Added
- Initial release with 10 built-in rules
- Full localization support via FormRulesMessagesEn
- Custom rule support via Validator.custom() and Validator.addRule()
```

---

## 8. Testing Standards

- **Every rule** has its own `_test.dart` file.
- Each test file covers: ✅ valid input, ❌ invalid input, ✅ empty input (should pass for non-required), edge cases.
- `validator_chain_test.dart` tests: rule ordering, fail-fast, multiple rules on one field.
- `l10n_test.dart` tests: global override, per-instance override, fallback to English.
- Target: **100% line coverage** on `lib/src/`.
- Use `flutter test --coverage` and `lcov` to verify before publishing.

### Test Template

```dart
void main() {
  group('EmailRule', () {
    test('passes on valid email', () {
      final rule = EmailRule('Invalid email');
      expect(rule.validate('user@example.com'), isNull);
    });

    test('fails on missing @', () {
      final rule = EmailRule('Invalid email');
      expect(rule.validate('notanemail'), 'Invalid email');
    });

    test('passes silently on empty string', () {
      final rule = EmailRule('Invalid email');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      final rule = EmailRule('Invalid email');
      expect(rule.validate(null), isNull);
    });
  });
}
```

---

## 9. Versioning & Publishing Checklist

### Semantic Versioning Rules
| Change | Version bump |
|--------|-------------|
| New rule added | `minor` (1.1.0) |
| Bug fix in existing rule | `patch` (1.0.1) |
| Rename/remove public API | `major` (2.0.0) |
| New optional parameter | `minor` |

### Pre-publish Checklist
```
[ ] dart format . → zero diff
[ ] dart analyze → zero issues
[ ] flutter test --coverage → 100% on lib/src/
[ ] dart pub publish --dry-run → no errors
[ ] README badges are up to date
[ ] CHANGELOG.md has entry for this version
[ ] pubspec.yaml version bumped correctly
[ ] example/lib/main.dart runs without errors
[ ] All public symbols have /// doc comments
```

---

## 10. What v1.0 Does NOT Include (Deferred to v1.1+)

| Feature | Reason deferred |
|---------|----------------|
| ARB / Flutter gen-l10n integration | Adds complexity; subclass pattern is sufficient for v1 |
| Async validators | Changes `FormFieldValidator<String>` return type contract |
| Cross-field validation context | Needs form-level access; out of scope for field-level API |
| Pre-built Spanish / Arabic / Hindi messages | Community contribution welcome post-launch |
| `.and()` / `.or()` logical combinators | API design needs more thought |

---

## 11. AI Coding Instructions (for Claude or Copilot)

When generating code for this package, always:

1. Read this SKILL.md first and follow every constraint.
2. **The public entry point is always `FormRules.x()` — never `Validator()`.** Consumer-facing
   code examples must use `FormRules`, not `Validator` directly.
3. Every new rule added to `Validator` must have a matching static method on `FormRules`.
4. `FormRules` is `final class` with a private constructor — never make it instantiable.
5. Never add a dependency to `pubspec.yaml` without explicit approval.
6. Every new public method must have a `///` doc comment with an example.
7. Every new rule must have a corresponding `_test.dart` file.
8. Run the linting checklist mentally before outputting code.
9. Prefer `const` constructors wherever possible.
10. Use `prefer_single_quotes` everywhere.
11. Never use `dynamic` — all types must be explicit.
12. The `build()` return type is always `FormFieldValidator<String>` — never change it.
13. Rules must never throw exceptions — return a message string or `null` only.
