import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('RequiredRule', () {
    test('passes on valid string', () {
      const rule = RequiredRule('Required');
      expect(rule.validate('hello'), isNull);
    });

    test('fails on empty string', () {
      const rule = RequiredRule('Required');
      expect(rule.validate(''), 'Required');
    });

    test('fails on whitespace string', () {
      const rule = RequiredRule('Required');
      expect(rule.validate('   '), 'Required');
    });

    test('fails on null', () {
      const rule = RequiredRule('Required');
      expect(rule.validate(null), 'Required');
    });
  });
}
