import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('CountryCodeRule', () {
    const rule = CountryCodeRule('Invalid');

    test('passes on valid country codes', () {
      expect(rule.validate('+1'), isNull);
      expect(rule.validate('+44'), isNull);
      expect(rule.validate('+91'), isNull);
      expect(rule.validate('+354'), isNull);
      expect(rule.validate('+1234'), isNull);
    });

    test('fails on invalid country codes', () {
      expect(rule.validate('1'), 'Invalid'); // missing +
      expect(rule.validate('+0'), 'Invalid'); // Cannot start with 0 after +
      expect(rule.validate('+12345'), 'Invalid'); // Too long
      expect(rule.validate('+a'), 'Invalid');
      expect(rule.validate('++1'), 'Invalid');
    });

    test('passes silently on empty or null', () {
      expect(rule.validate(''), isNull);
      expect(rule.validate(null), isNull);
    });
  });
}
