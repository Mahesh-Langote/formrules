import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('EmailRule', () {
    test('passes on valid email', () {
      const rule = EmailRule('Invalid email');
      expect(rule.validate('user@example.com'), isNull);
    });

    test('fails on missing @', () {
      const rule = EmailRule('Invalid email');
      expect(rule.validate('notanemail'), 'Invalid email');
    });

    test('passes silently on empty string', () {
      const rule = EmailRule('Invalid email');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = EmailRule('Invalid email');
      expect(rule.validate(null), isNull);
    });
  });
}
