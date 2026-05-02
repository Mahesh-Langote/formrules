import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('PhoneRule', () {
    test('passes on valid phone', () {
      const rule = PhoneRule('Invalid phone');
      expect(rule.validate('+1234567890'), isNull);
      expect(rule.validate('123-456-7890'), isNull);
    });

    test('fails on invalid phone', () {
      const rule = PhoneRule('Invalid phone');
      expect(rule.validate('abc'), 'Invalid phone');
    });

    test('passes with custom pattern', () {
      final rule = PhoneRule('Invalid', pattern: RegExp(r'^\d{3}$'));
      expect(rule.validate('123'), isNull);
      expect(rule.validate('1234'), 'Invalid');
    });

    test('passes silently on empty or null', () {
      const rule = PhoneRule('Invalid phone');
      expect(rule.validate(''), isNull);
      expect(rule.validate(null), isNull);
    });

    test('passes on valid specific country formats', () {
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.us)
              .validate('+1 123 456 7890'),
          isNull);
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.india)
              .validate('+91 9876543210'),
          isNull);
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.uk)
              .validate('+447911123456'),
          isNull);
    });

    test('fails on invalid specific country formats', () {
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.us)
              .validate('+44 123 456 7890'),
          'Invalid');
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.india)
              .validate('+91 123'),
          'Invalid');
      expect(
          const PhoneRule('Invalid', country: PhoneCountry.uk)
              .validate('011 123'),
          'Invalid');
    });
  });
}
