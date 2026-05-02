import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('MinLengthRule', () {
    test('passes on length >= min', () {
      const rule = MinLengthRule(3, 'Too short');
      expect(rule.validate('123'), isNull);
      expect(rule.validate('1234'), isNull);
    });

    test('fails on length < min', () {
      const rule = MinLengthRule(3, 'Too short');
      expect(rule.validate('12'), 'Too short');
    });

    test('passes silently on empty string', () {
      const rule = MinLengthRule(3, 'Too short');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = MinLengthRule(3, 'Too short');
      expect(rule.validate(null), isNull);
    });
  });
}
