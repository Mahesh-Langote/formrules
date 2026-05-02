import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('Base64Rule', () {
    test('passes on valid base64', () {
      const rule = Base64Rule('Error');
      expect(rule.validate('SGVsbG8gV29ybGQ='), isNull);
    });

    test('fails on invalid base64', () {
      const rule = Base64Rule('Error');
      expect(rule.validate('not base64!'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = Base64Rule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
