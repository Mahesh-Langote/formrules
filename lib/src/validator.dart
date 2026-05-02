import 'package:flutter/widgets.dart';

import 'package:formrules/src/l10n/form_rules_localizations.dart';
import 'package:formrules/src/l10n/messages/en.dart';
import 'package:formrules/src/rules/rule.dart';
import 'package:formrules/src/rules/rules.dart';

/// The primary entry point for all form validation.
///
/// Non-instantiable — every method returns a [Validator] builder
/// with the first rule already applied.
final class FormRules {
  FormRules._();

  /// Ensures the field is not null or empty.
  ///
  /// ```dart
  /// FormRules.required().build()
  /// ```
  static Validator required({String? message}) =>
      Validator._()..required(message: message);

  /// Validates an email address.
  ///
  /// ```dart
  /// FormRules.email().build()
  /// ```
  static Validator email({String? message}) =>
      Validator._()..email(message: message);

  /// Validates a minimum length.
  ///
  /// ```dart
  /// FormRules.minLength(5).build()
  /// ```
  static Validator minLength(int min, {String? message}) =>
      Validator._()..minLength(min, message: message);

  /// Validates a maximum length.
  ///
  /// ```dart
  /// FormRules.maxLength(50).build()
  /// ```
  static Validator maxLength(int max, {String? message}) =>
      Validator._()..maxLength(max, message: message);

  /// Validates a URL.
  ///
  /// ```dart
  /// FormRules.url(requireHttps: true).build()
  /// ```
  static Validator url({bool requireHttps = false, String? message}) =>
      Validator._()..url(requireHttps: requireHttps, message: message);

  /// Validates a phone number, optionally enforcing a specific [country].
  ///
  /// ```dart
  /// FormRules.phone(country: PhoneCountry.us).build()
  /// ```
  static Validator phone(
          {RegExp? pattern, PhoneCountry? country, String? message}) =>
      Validator._()
        ..phone(pattern: pattern, country: country, message: message);

  /// Validates a standard E.164 country dial code.
  ///
  /// ```dart
  /// FormRules.countryCode().build()
  /// ```
  static Validator countryCode({String? message}) =>
      Validator._()..countryCode(message: message);

  /// Validates that the input is numeric.
  ///
  /// ```dart
  /// FormRules.numeric().build()
  /// ```
  static Validator numeric({String? message}) =>
      Validator._()..numeric(message: message);

  /// Validates against a custom regex pattern.
  ///
  /// ```dart
  /// FormRules.regex(RegExp(r'^[a-z]+$'), message: 'Only lowercase').build()
  /// ```
  static Validator regex(RegExp pattern, {required String message}) =>
      Validator._()..regex(pattern, message: message);

  /// Validates that the input matches another field.
  ///
  /// ```dart
  /// FormRules.match(() => passwordController.text).build()
  /// ```
  static Validator match(String? Function() getValue, {String? message}) =>
      Validator._()..match(getValue, message: message);

  /// Ensures there are no special characters.
  ///
  /// ```dart
  /// FormRules.noSpecialChars(allowed: '-_').build()
  /// ```
  static Validator noSpecialChars({String allowed = '', String? message}) =>
      Validator._()..noSpecialChars(allowed: allowed, message: message);

  /// Adds a custom inline validator.
  ///
  /// ```dart
  /// FormRules.custom((val) => val == 'secret' ? null : 'No').build()
  /// ```
  static Validator custom(String? Function(String? value) validator) =>
      Validator._()..custom(validator);

  /// Adds a custom rule class.
  ///
  /// ```dart
  /// FormRules.addRule(MyRule()).build()
  /// ```
  static Validator addRule(ValidationRule rule) => Validator._()..addRule(rule);

  // ── New 21 Rules ──

  /// Ensures the value contains only alphabetic characters.
  static Validator alpha({String? message}) =>
      Validator._()..alpha(message: message);

  /// Ensures the value contains only alphanumeric characters.
  static Validator alphaNumeric({String? message}) =>
      Validator._()..alphaNumeric(message: message);

  /// Ensures the value is strictly lowercase.
  static Validator lowercase({String? message}) =>
      Validator._()..lowercase(message: message);

  /// Ensures the value is strictly uppercase.
  static Validator uppercase({String? message}) =>
      Validator._()..uppercase(message: message);

  /// Ensures the value exactly matches one of the items in the provided list.
  static Validator inList(List<String> values, {String? message}) =>
      Validator._()..inList(values, message: message);

  /// Ensures the value does NOT match any item in the provided list.
  static Validator notInList(List<String> values, {String? message}) =>
      Validator._()..notInList(values, message: message);

  /// Ensures the value exactly equals a hardcoded string.
  static Validator equals(String value, {String? message}) =>
      Validator._()..equals(value, message: message);

  /// Ensures the value does NOT equal a hardcoded string.
  static Validator notEquals(String value, {String? message}) =>
      Validator._()..notEquals(value, message: message);

  /// Ensures the value contains a specific substring.
  static Validator contains(String substring, {String? message}) =>
      Validator._()..contains(substring, message: message);

  /// Ensures the value starts with a specific prefix.
  static Validator startsWith(String prefix, {String? message}) =>
      Validator._()..startsWith(prefix, message: message);

  /// Ensures the value ends with a specific suffix.
  static Validator endsWith(String suffix, {String? message}) =>
      Validator._()..endsWith(suffix, message: message);

  /// Validates standard IPv4 and/or IPv6 addresses.
  static Validator ipAddress(
          {bool v4Only = false, bool v6Only = false, String? message}) =>
      Validator._()
        ..ipAddress(v4Only: v4Only, v6Only: v6Only, message: message);

  /// Validates a standard MAC address.
  static Validator macAddress({String? message}) =>
      Validator._()..macAddress(message: message);

  /// Validates credit card numbers using the standard Luhn algorithm.
  static Validator creditCard({String? message}) =>
      Validator._()..creditCard(message: message);

  /// Validates that the input is a valid date.
  static Validator date({String? message}) =>
      Validator._()..date(message: message);

  /// Validates a standard UUID.
  static Validator uuid({String? message}) =>
      Validator._()..uuid(message: message);

  /// Validates a standard hex color string.
  static Validator hexColor({String? message}) =>
      Validator._()..hexColor(message: message);

  /// Validates that the string is properly Base64 encoded.
  static Validator base64({String? message}) =>
      Validator._()..base64(message: message);

  /// Validates that the string is valid JSON.
  static Validator json({String? message}) =>
      Validator._()..json(message: message);

  /// Validates a URL-friendly slug.
  static Validator slug({String? message}) =>
      Validator._()..slug(message: message);

  /// An all-in-one strong password validator rule.
  static Validator password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialChar = true,
    String? message,
  }) =>
      Validator._()
        ..password(
          minLength: minLength,
          requireUppercase: requireUppercase,
          requireLowercase: requireLowercase,
          requireNumber: requireNumber,
          requireSpecialChar: requireSpecialChar,
          message: message,
        );
}

/// Internal builder — consumers should not instantiate this directly.
///
/// Use [FormRules] static methods as the entry point instead.
class Validator {
  final FormRulesMessagesEn _messages;
  final List<ValidationRule> _rules = [];

  /// Private constructor — only FormRules and Validator's own chain methods
  /// should create instances.
  Validator._({FormRulesMessagesEn? messages})
      : _messages = messages ?? FormRulesLocalizations.current;

  /// Ensures the field is not null or empty.
  Validator required({String? message}) {
    _rules.add(RequiredRule(message ?? _messages.required));
    return this;
  }

  /// Validates an email address.
  Validator email({String? message}) {
    _rules.add(EmailRule(message ?? _messages.email));
    return this;
  }

  /// Validates a minimum length.
  Validator minLength(int min, {String? message}) {
    _rules.add(MinLengthRule(min, message ?? _messages.minLength(min)));
    return this;
  }

  /// Validates a maximum length.
  Validator maxLength(int max, {String? message}) {
    _rules.add(MaxLengthRule(max, message ?? _messages.maxLength(max)));
    return this;
  }

  /// Validates a URL.
  Validator url({bool requireHttps = false, String? message}) {
    _rules.add(
      UrlRule(
        message ?? (requireHttps ? _messages.urlHttps : _messages.url),
        requireHttps: requireHttps,
      ),
    );
    return this;
  }

  /// Validates a phone number, optionally enforcing a specific [country].
  Validator phone({RegExp? pattern, PhoneCountry? country, String? message}) {
    _rules.add(PhoneRule(message ?? _messages.phone,
        pattern: pattern, country: country));
    return this;
  }

  /// Validates a standard E.164 country dial code.
  Validator countryCode({String? message}) {
    _rules.add(CountryCodeRule(message ?? _messages.countryCode));
    return this;
  }

  /// Validates that the input is numeric.
  Validator numeric({String? message}) {
    _rules.add(NumericRule(message ?? _messages.numeric));
    return this;
  }

  /// Validates against a custom regex pattern.
  Validator regex(RegExp pattern, {required String message}) {
    _rules.add(RegexRule(pattern, message));
    return this;
  }

  /// Validates that the input matches another field.
  Validator match(String? Function() getValue, {String? message}) {
    _rules.add(MatchRule(getValue, message ?? _messages.match));
    return this;
  }

  /// Ensures there are no special characters.
  Validator noSpecialChars({String allowed = '', String? message}) {
    _rules.add(
      NoSpecialCharsRule(message ?? _messages.noSpecialChars, allowed: allowed),
    );
    return this;
  }

  /// Adds a custom inline validator.
  Validator custom(String? Function(String? value) validator) {
    _rules.add(CustomRule(validator));
    return this;
  }

  /// Adds a custom rule class.
  Validator addRule(ValidationRule rule) {
    _rules.add(rule);
    return this;
  }

  // ── New 21 Rules ──

  /// Ensures the value contains only alphabetic characters.
  Validator alpha({String? message}) {
    _rules.add(AlphaRule(message ?? _messages.alpha));
    return this;
  }

  /// Ensures the value contains only alphanumeric characters.
  Validator alphaNumeric({String? message}) {
    _rules.add(AlphaNumericRule(message ?? _messages.alphaNumeric));
    return this;
  }

  /// Ensures the value is strictly lowercase.
  Validator lowercase({String? message}) {
    _rules.add(LowercaseRule(message ?? _messages.lowercase));
    return this;
  }

  /// Ensures the value is strictly uppercase.
  Validator uppercase({String? message}) {
    _rules.add(UppercaseRule(message ?? _messages.uppercase));
    return this;
  }

  /// Ensures the value exactly matches one of the items in the provided list.
  Validator inList(List<String> values, {String? message}) {
    _rules.add(InListRule(values, message ?? _messages.inList));
    return this;
  }

  /// Ensures the value does NOT match any item in the provided list.
  Validator notInList(List<String> values, {String? message}) {
    _rules.add(NotInListRule(values, message ?? _messages.notInList));
    return this;
  }

  /// Ensures the value exactly equals a hardcoded string.
  Validator equals(String value, {String? message}) {
    _rules.add(EqualsRule(value, message ?? _messages.equals));
    return this;
  }

  /// Ensures the value does NOT equal a hardcoded string.
  Validator notEquals(String value, {String? message}) {
    _rules.add(NotEqualsRule(value, message ?? _messages.notEquals));
    return this;
  }

  /// Ensures the value contains a specific substring.
  Validator contains(String substring, {String? message}) {
    _rules.add(ContainsRule(substring, message ?? _messages.contains));
    return this;
  }

  /// Ensures the value starts with a specific prefix.
  Validator startsWith(String prefix, {String? message}) {
    _rules.add(StartsWithRule(prefix, message ?? _messages.startsWith));
    return this;
  }

  /// Ensures the value ends with a specific suffix.
  Validator endsWith(String suffix, {String? message}) {
    _rules.add(EndsWithRule(suffix, message ?? _messages.endsWith));
    return this;
  }

  /// Validates standard IPv4 and/or IPv6 addresses.
  Validator ipAddress(
      {bool v4Only = false, bool v6Only = false, String? message}) {
    _rules.add(IpAddressRule(message ?? _messages.ipAddress,
        v4Only: v4Only, v6Only: v6Only));
    return this;
  }

  /// Validates a standard MAC address.
  Validator macAddress({String? message}) {
    _rules.add(MacAddressRule(message ?? _messages.macAddress));
    return this;
  }

  /// Validates credit card numbers using the standard Luhn algorithm.
  Validator creditCard({String? message}) {
    _rules.add(CreditCardRule(message ?? _messages.creditCard));
    return this;
  }

  /// Validates that the input is a valid date.
  Validator date({String? message}) {
    _rules.add(DateRule(message ?? _messages.date));
    return this;
  }

  /// Validates a standard UUID.
  Validator uuid({String? message}) {
    _rules.add(UuidRule(message ?? _messages.uuid));
    return this;
  }

  /// Validates a standard hex color string.
  Validator hexColor({String? message}) {
    _rules.add(HexColorRule(message ?? _messages.hexColor));
    return this;
  }

  /// Validates that the string is properly Base64 encoded.
  Validator base64({String? message}) {
    _rules.add(Base64Rule(message ?? _messages.base64));
    return this;
  }

  /// Validates that the string is valid JSON.
  Validator json({String? message}) {
    _rules.add(JsonRule(message ?? _messages.json));
    return this;
  }

  /// Validates a URL-friendly slug.
  Validator slug({String? message}) {
    _rules.add(SlugRule(message ?? _messages.slug));
    return this;
  }

  /// An all-in-one strong password validator rule.
  Validator password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialChar = true,
    String? message,
  }) {
    _rules.add(PasswordRule(
      message ?? _messages.password,
      minLength: minLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireNumber: requireNumber,
      requireSpecialChar: requireSpecialChar,
    ));
    return this;
  }

  /// Builds the final validator function.
  FormFieldValidator<String> build() {
    return (String? value) {
      for (final rule in _rules) {
        final error = rule.validate(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
