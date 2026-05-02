import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('MatchRule', () {
    test('passes when matching', () {
      const rule = MatchRule(_getValue, 'No match');
      expect(rule.validate('target'), isNull);
    });

    test('fails when not matching', () {
      const rule = MatchRule(_getValue, 'No match');
      expect(rule.validate('other'), 'No match');
    });

    test('passes silently on empty string', () {
      const rule = MatchRule(_getValue, 'No match');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = MatchRule(_getValue, 'No match');
      expect(rule.validate(null), isNull);
    });
  });
}

String _getValue() => 'target';
