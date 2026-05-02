import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('CreditCardRule', () {
    test('passes on valid credit card', () {
      const rule = CreditCardRule('Error');
      // 49927398716 is a valid test luhn number
      expect(rule.validate('49927398716'), isNull);
      expect(rule.validate('4992-7398-716'), isNull);
    });

    test('fails on invalid credit card', () {
      const rule = CreditCardRule('Error');
      expect(rule.validate('49927398717'), 'Error');
    });

    test('fails on non-numeric characters', () {
      const rule = CreditCardRule('Error');
      expect(rule.validate('4992a398716'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = CreditCardRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
