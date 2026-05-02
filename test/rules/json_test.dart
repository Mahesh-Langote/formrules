import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('JsonRule', () {
    test('passes on valid json', () {
      const rule = JsonRule('Error');
      expect(rule.validate('{"key": "value"}'), isNull);
      expect(rule.validate('[1, 2, 3]'), isNull);
    });

    test('fails on invalid json', () {
      const rule = JsonRule('Error');
      expect(rule.validate('{"key": "value"'), 'Error');
      expect(rule.validate('not json'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = JsonRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
