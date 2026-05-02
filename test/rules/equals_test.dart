import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('EqualsRule', () {
    test('passes when value equals target', () {
      const rule = EqualsRule('hello', 'Error');
      expect(rule.validate('hello'), isNull);
    });

    test('fails when value does not equal target', () {
      const rule = EqualsRule('hello', 'Error');
      expect(rule.validate('world'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = EqualsRule('hello', 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
