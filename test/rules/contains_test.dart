import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('ContainsRule', () {
    test('passes when value contains substring', () {
      const rule = ContainsRule('world', 'Error');
      expect(rule.validate('hello world'), isNull);
    });

    test('fails when value does not contain substring', () {
      const rule = ContainsRule('world', 'Error');
      expect(rule.validate('hello everyone'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = ContainsRule('world', 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
