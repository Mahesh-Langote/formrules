import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('DateRule', () {
    test('passes on valid date', () {
      const rule = DateRule('Error');
      expect(rule.validate('2024-05-02'), isNull);
      expect(rule.validate('2024-05-02T12:00:00Z'), isNull);
    });

    test('fails on invalid date', () {
      const rule = DateRule('Error');
      expect(rule.validate('not a date'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = DateRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
