import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('MaxLengthRule', () {
    test('passes on length <= max', () {
      const rule = MaxLengthRule(3, 'Too long');
      expect(rule.validate('12'), isNull);
      expect(rule.validate('123'), isNull);
    });

    test('fails on length > max', () {
      const rule = MaxLengthRule(3, 'Too long');
      expect(rule.validate('1234'), 'Too long');
    });

    test('passes silently on empty string', () {
      const rule = MaxLengthRule(3, 'Too long');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = MaxLengthRule(3, 'Too long');
      expect(rule.validate(null), isNull);
    });
  });
}
