import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('UuidRule', () {
    test('passes on valid UUID', () {
      const rule = UuidRule('Error');
      expect(rule.validate('123e4567-e89b-12d3-a456-426614174000'), isNull);
    });

    test('fails on invalid UUID', () {
      const rule = UuidRule('Error');
      expect(rule.validate('123e4567-e89b-12d3-a456-42661417400'), 'Error');
      expect(rule.validate('not-a-uuid'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = UuidRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
