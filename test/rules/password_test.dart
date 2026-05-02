import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('PasswordRule', () {
    test('passes on strong password', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('StrongPass1!'), isNull);
    });

    test('fails if missing uppercase', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('weakpass1!'), 'Error');
    });

    test('fails if missing lowercase', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('WEAKPASS1!'), 'Error');
    });

    test('fails if missing number', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('StrongPass!'), 'Error');
    });

    test('fails if missing special character', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('StrongPass1'), 'Error');
    });

    test('fails if too short', () {
      const rule = PasswordRule('Error');
      expect(rule.validate('Str1!'), 'Error');
    });

    test('passes with custom config', () {
      const rule =
          PasswordRule('Error', requireSpecialChar: false, minLength: 4);
      expect(rule.validate('Pas1'), isNull);
    });

    test('passes silently on empty string', () {
      const rule = PasswordRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
