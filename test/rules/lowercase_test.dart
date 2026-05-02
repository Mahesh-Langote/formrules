import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('LowercaseRule', () {
    test('passes on lowercase values', () {
      const rule = LowercaseRule('Error');
      expect(rule.validate('abc'), isNull);
    });

    test('fails on uppercase values', () {
      const rule = LowercaseRule('Error');
      expect(rule.validate('aBc'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = LowercaseRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
