import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('AlphaNumericRule', () {
    test('passes on alphanumeric values', () {
      const rule = AlphaNumericRule('Error');
      expect(rule.validate('abc123'), isNull);
      expect(rule.validate('123'), isNull);
    });

    test('fails on special characters', () {
      const rule = AlphaNumericRule('Error');
      expect(rule.validate('abc!'), 'Error');
      expect(rule.validate('ab c'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = AlphaNumericRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
