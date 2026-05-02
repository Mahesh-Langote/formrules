import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('StartsWithRule', () {
    test('passes when value starts with prefix', () {
      const rule = StartsWithRule('hello', 'Error');
      expect(rule.validate('hello world'), isNull);
    });

    test('fails when value does not start with prefix', () {
      const rule = StartsWithRule('hello', 'Error');
      expect(rule.validate('world hello'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = StartsWithRule('hello', 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
