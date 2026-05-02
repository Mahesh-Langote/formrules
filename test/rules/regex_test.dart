import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('RegexRule', () {
    test('passes on match', () {
      final rule = RegexRule(RegExp(r'^[a-z]+$'), 'Must be lowercase');
      expect(rule.validate('abc'), isNull);
    });

    test('fails on no match', () {
      final rule = RegexRule(RegExp(r'^[a-z]+$'), 'Must be lowercase');
      expect(rule.validate('ABC'), 'Must be lowercase');
    });

    test('passes silently on empty string', () {
      final rule = RegexRule(RegExp(r'^[a-z]+$'), 'Must be lowercase');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      final rule = RegexRule(RegExp(r'^[a-z]+$'), 'Must be lowercase');
      expect(rule.validate(null), isNull);
    });
  });
}
