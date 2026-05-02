import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('NotEqualsRule', () {
    test('passes when value does not equal target', () {
      const rule = NotEqualsRule('hello', 'Error');
      expect(rule.validate('world'), isNull);
    });

    test('fails when value equals target', () {
      const rule = NotEqualsRule('hello', 'Error');
      expect(rule.validate('hello'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = NotEqualsRule('hello', 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
