import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('NumericRule', () {
    test('passes on numeric values', () {
      const rule = NumericRule('Not a number');
      expect(rule.validate('123'), isNull);
      expect(rule.validate('123.45'), isNull);
      expect(rule.validate('-42'), isNull);
    });

    test('fails on non-numeric values', () {
      const rule = NumericRule('Not a number');
      expect(rule.validate('12a'), 'Not a number');
      expect(rule.validate('abc'), 'Not a number');
    });

    test('passes silently on empty string', () {
      const rule = NumericRule('Not a number');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = NumericRule('Not a number');
      expect(rule.validate(null), isNull);
    });
  });
}
