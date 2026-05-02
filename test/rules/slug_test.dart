import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('SlugRule', () {
    test('passes on valid slug', () {
      const rule = SlugRule('Error');
      expect(rule.validate('my-valid-slug'), isNull);
      expect(rule.validate('slug123'), isNull);
    });

    test('fails on invalid slug', () {
      const rule = SlugRule('Error');
      expect(rule.validate('Not-A-Slug'), 'Error');
      expect(rule.validate('my slug'), 'Error');
      expect(rule.validate('slug-'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = SlugRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
