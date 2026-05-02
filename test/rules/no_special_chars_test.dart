import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('NoSpecialCharsRule', () {
    test('passes on pure alphanumeric', () {
      const rule = NoSpecialCharsRule('No special chars');
      expect(rule.validate('abc 123'), isNull);
    });

    test('fails on special characters', () {
      const rule = NoSpecialCharsRule('No special chars');
      expect(rule.validate('abc!'), 'No special chars');
    });

    test('passes with allowed special characters', () {
      const rule = NoSpecialCharsRule('No special chars', allowed: '-_');
      expect(rule.validate('abc-123_'), isNull);
    });

    test('fails on unallowed special characters', () {
      const rule = NoSpecialCharsRule('No special chars', allowed: '-_');
      expect(rule.validate('abc-123_!'), 'No special chars');
    });

    test('passes silently on empty string', () {
      const rule = NoSpecialCharsRule('No special chars');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = NoSpecialCharsRule('No special chars');
      expect(rule.validate(null), isNull);
    });
  });
}
