import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('AlphaRule', () {
    test('passes on alphabetic values', () {
      const rule = AlphaRule('Error');
      expect(rule.validate('abc'), isNull);
      expect(rule.validate('ABC'), isNull);
    });

    test('fails on non-alphabetic values', () {
      const rule = AlphaRule('Error');
      expect(rule.validate('abc1'), 'Error');
      expect(rule.validate('ab c'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = AlphaRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
