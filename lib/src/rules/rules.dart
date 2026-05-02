import 'dart:convert';

import 'package:formrules/src/rules/rule.dart';

/// Rule that ensures a value is not null, empty, or whitespace-only.
class RequiredRule extends ValidationRule {
  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [RequiredRule] with the given [message].
  const RequiredRule(this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is a valid email address.
class EmailRule extends ValidationRule {
  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [EmailRule] with the given [message].
  const EmailRule(this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is at least a certain length.
class MinLengthRule extends ValidationRule {
  /// The minimum length required.
  final int min;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [MinLengthRule] with the given [min] and [message].
  const MinLengthRule(this.min, this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < min) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is no more than a certain length.
class MaxLengthRule extends ValidationRule {
  /// The maximum length allowed.
  final int max;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [MaxLengthRule] with the given [max] and [message].
  const MaxLengthRule(this.max, this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length > max) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is a valid URL.
class UrlRule extends ValidationRule {
  /// Whether the URL must use the HTTPS scheme.
  final bool requireHttps;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [UrlRule] with the given [message] and optional [requireHttps].
  const UrlRule(this.message, {this.requireHttps = false});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return message;
    }
    if (requireHttps && uri.scheme != 'https') {
      return message;
    }
    final allowedSchemes = ['http', 'https'];
    if (!allowedSchemes.contains(uri.scheme)) {
      return message;
    }
    return null;
  }
}

/// Represents supported countries for strict phone validation.
enum PhoneCountry {
  /// United States / Canada
  us,

  /// United Kingdom
  uk,

  /// India
  india,

  /// Australia
  australia,

  /// Brazil
  brazil,

  /// Germany
  germany,

  /// France
  france,

  /// Japan
  japan,

  /// China
  china,
}

/// Rule that ensures a value is a valid phone number.
class PhoneRule extends ValidationRule {
  /// The optional specific country to validate against.
  final PhoneCountry? country;

  /// The regex pattern to validate the phone number against (overrides country logic if provided).
  final RegExp? pattern;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [PhoneRule] with the given [message] and optional [pattern] or [country].
  const PhoneRule(this.message, {this.pattern, this.country});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;

    RegExp regex;
    if (pattern != null) {
      regex = pattern!;
    } else if (country != null) {
      regex = switch (country!) {
        PhoneCountry.us => RegExp(r'^\+?1?\s*\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$'),
        PhoneCountry.uk => RegExp(r'^\+?44[\s.-]?\d{10}$'),
        PhoneCountry.india => RegExp(r'^\+?91[\s.-]?\d{10}$'),
        PhoneCountry.australia => RegExp(r'^\+?61[\s.-]?\d{9}$'),
        PhoneCountry.brazil => RegExp(r'^\+?55[\s.-]?\d{10,11}$'),
        PhoneCountry.germany => RegExp(r'^\+?49[\s.-]?\d{10,11}$'),
        PhoneCountry.france => RegExp(r'^\+?33[\s.-]?\d{9}$'),
        PhoneCountry.japan => RegExp(r'^\+?81[\s.-]?\d{10}$'),
        PhoneCountry.china => RegExp(r'^\+?86[\s.-]?\d{11}$'),
      };
    } else {
      // Generic international fallback
      regex = RegExp(r'^\+?[0-9\s\-().]{7,20}$');
    }

    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is a valid E.164 country dial code.
class CountryCodeRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [CountryCodeRule].
  const CountryCodeRule(this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    // Standard ITU-T E.164 country code: starts with '+', then 1 to 3 (or 4) digits.
    if (!RegExp(r'^\+[1-9]\d{0,3}$').hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is numeric.
class NumericRule extends ValidationRule {
  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [NumericRule] with the given [message].
  const NumericRule(this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (num.tryParse(value) == null) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value matches a custom regex pattern.
class RegexRule extends ValidationRule {
  /// The regex pattern to match against.
  final RegExp pattern;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [RegexRule] with the given [pattern] and [message].
  const RegexRule(this.pattern, this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!pattern.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value matches another value.
class MatchRule extends ValidationRule {
  /// A function that returns the value to match against.
  final String? Function() getValue;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [MatchRule] with the given [getValue] and [message].
  const MatchRule(this.getValue, this.message);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value != getValue()) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value contains no special characters.
class NoSpecialCharsRule extends ValidationRule {
  /// A string of allowed special characters.
  final String allowed;

  /// The error message to return if validation fails.
  final String message;

  /// Creates a new [NoSpecialCharsRule] with the given [message] and [allowed].
  const NoSpecialCharsRule(this.message, {this.allowed = ''});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    final escapedAllowed = RegExp.escape(allowed);
    // Actually, we want to fail if it *contains* any character not in [a-zA-Z0-9\s] + allowed
    final regex = RegExp('[^a-zA-Z0-9\\s$escapedAllowed]');
    if (regex.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// A custom rule built from a user-provided function.
class CustomRule extends ValidationRule {
  /// The custom validation function.
  final String? Function(String? value) validator;

  /// Creates a new [CustomRule] with the given [validator] function.
  const CustomRule(this.validator);

  @override
  String? validate(String? value) {
    return validator(value);
  }
}

// ── New 21 Rules ──

/// Rule that ensures a value contains only alphabetic characters.
class AlphaRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [AlphaRule].
  const AlphaRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) return message;
    return null;
  }
}

/// Rule that ensures a value contains only alphanumeric characters.
class AlphaNumericRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [AlphaNumericRule].
  const AlphaNumericRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) return message;
    return null;
  }
}

/// Rule that ensures a value is strictly lowercase.
class LowercaseRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [LowercaseRule].
  const LowercaseRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value != value.toLowerCase()) return message;
    return null;
  }
}

/// Rule that ensures a value is strictly uppercase.
class UppercaseRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [UppercaseRule].
  const UppercaseRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value != value.toUpperCase()) return message;
    return null;
  }
}

/// Rule that ensures a value is exactly in a list of allowed values.
class InListRule extends ValidationRule {
  /// The allowed values.
  final List<String> values;

  /// The error message.
  final String message;

  /// Creates a new [InListRule].
  const InListRule(this.values, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!values.contains(value)) return message;
    return null;
  }
}

/// Rule that ensures a value is not in a list of restricted values.
class NotInListRule extends ValidationRule {
  /// The restricted values.
  final List<String> values;

  /// The error message.
  final String message;

  /// Creates a new [NotInListRule].
  const NotInListRule(this.values, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (values.contains(value)) return message;
    return null;
  }
}

/// Rule that ensures a value exactly matches a given string.
class EqualsRule extends ValidationRule {
  /// The required string.
  final String target;

  /// The error message.
  final String message;

  /// Creates a new [EqualsRule].
  const EqualsRule(this.target, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value != target) return message;
    return null;
  }
}

/// Rule that ensures a value does not match a given string.
class NotEqualsRule extends ValidationRule {
  /// The restricted string.
  final String target;

  /// The error message.
  final String message;

  /// Creates a new [NotEqualsRule].
  const NotEqualsRule(this.target, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value == target) return message;
    return null;
  }
}

/// Rule that ensures a value contains a specific substring.
class ContainsRule extends ValidationRule {
  /// The required substring.
  final String substring;

  /// The error message.
  final String message;

  /// Creates a new [ContainsRule].
  const ContainsRule(this.substring, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!value.contains(substring)) return message;
    return null;
  }
}

/// Rule that ensures a value starts with a specific prefix.
class StartsWithRule extends ValidationRule {
  /// The prefix.
  final String prefix;

  /// The error message.
  final String message;

  /// Creates a new [StartsWithRule].
  const StartsWithRule(this.prefix, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!value.startsWith(prefix)) return message;
    return null;
  }
}

/// Rule that ensures a value ends with a specific suffix.
class EndsWithRule extends ValidationRule {
  /// The suffix.
  final String suffix;

  /// The error message.
  final String message;

  /// Creates a new [EndsWithRule].
  const EndsWithRule(this.suffix, this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!value.endsWith(suffix)) return message;
    return null;
  }
}

/// Rule that ensures a value is a valid IP address.
class IpAddressRule extends ValidationRule {
  /// If true, requires IPv4.
  final bool v4Only;

  /// If true, requires IPv6.
  final bool v6Only;

  /// The error message.
  final String message;

  /// Creates a new [IpAddressRule].
  const IpAddressRule(this.message, {this.v4Only = false, this.v6Only = false});
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;

    final isV4 = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$').hasMatch(value);
    // Note: A full IPv6 regex is very complex, this catches basic fully expanded ones.
    // For a robust implementation without dependencies, `Uri.parseIPv6Address` could be used
    // but it throws. We'll use a better regex or `InternetAddress` if available, but
    // `dart:io` isn't recommended for pure Dart packages if web support is needed.
    // We will stick to a moderately robust regex for v6:
    final robustV6 = RegExp(
            r'^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$')
        .hasMatch(value);

    if (v4Only && !isV4) return message;
    if (v6Only && !robustV6) return message;
    if (!v4Only && !v6Only && !isV4 && !robustV6) return message;

    // Extra v4 block check to ensure segments <= 255
    if (isV4) {
      final parts = value.split('.');
      for (final part in parts) {
        if ((int.tryParse(part) ?? 256) > 255) return message;
      }
    }

    return null;
  }
}

/// Rule that ensures a value is a valid MAC address.
class MacAddressRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [MacAddressRule].
  const MacAddressRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is a valid credit card using the Luhn algorithm.
class CreditCardRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [CreditCardRule].
  const CreditCardRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    final sanitized = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (!RegExp(r'^\d+$').hasMatch(sanitized)) return message;

    int sum = 0;
    bool alternate = false;
    for (int i = sanitized.length - 1; i >= 0; i--) {
      int n = int.parse(sanitized[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    if (sum % 10 != 0) return message;
    return null;
  }
}

/// Rule that ensures a value is a valid ISO-8601 date.
class DateRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [DateRule].
  const DateRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (DateTime.tryParse(value) == null) return message;
    return null;
  }
}

/// Rule that ensures a value is a valid UUID.
class UuidRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [UuidRule].
  const UuidRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(
            r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')
        .hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is a valid Hex Color.
class HexColorRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [HexColorRule].
  const HexColorRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(
            r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$')
        .hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a value is valid Base64.
class Base64Rule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [Base64Rule].
  const Base64Rule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      base64Decode(value);
      return null;
    } catch (_) {
      return message;
    }
  }
}

/// Rule that ensures a value is valid JSON.
class JsonRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [JsonRule].
  const JsonRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      jsonDecode(value);
      return null;
    } catch (_) {
      return message;
    }
  }
}

/// Rule that ensures a value is a valid URL slug.
class SlugRule extends ValidationRule {
  /// The error message.
  final String message;

  /// Creates a new [SlugRule].
  const SlugRule(this.message);
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Rule that ensures a password meets strength requirements.
class PasswordRule extends ValidationRule {
  /// Minimum required length.
  final int minLength;

  /// If true, requires an uppercase letter.
  final bool requireUppercase;

  /// If true, requires a lowercase letter.
  final bool requireLowercase;

  /// If true, requires a number.
  final bool requireNumber;

  /// If true, requires a special character.
  final bool requireSpecialChar;

  /// The error message.
  final String message;

  /// Creates a new [PasswordRule].
  const PasswordRule(
    this.message, {
    this.minLength = 8,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireNumber = true,
    this.requireSpecialChar = true,
  });

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < minLength) return message;
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) return message;
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) return message;
    if (requireNumber && !RegExp(r'[0-9]').hasMatch(value)) return message;
    if (requireSpecialChar && !RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
      return message;
    }
    return null;
  }
}
