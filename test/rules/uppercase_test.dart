import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('UppercaseRule', () {
    test('passes on uppercase values', () {
      const rule = UppercaseRule('Error');
      expect(rule.validate('ABC'), isNull);
    });

    test('fails on lowercase values', () {
      const rule = UppercaseRule('Error');
      expect(rule.validate('AbC'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = UppercaseRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
