import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('EndsWithRule', () {
    test('passes when value ends with suffix', () {
      const rule = EndsWithRule('world', 'Error');
      expect(rule.validate('hello world'), isNull);
    });

    test('fails when value does not end with suffix', () {
      const rule = EndsWithRule('world', 'Error');
      expect(rule.validate('hello world!'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = EndsWithRule('world', 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
