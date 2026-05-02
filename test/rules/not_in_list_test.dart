import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('NotInListRule', () {
    test('passes when value is not in list', () {
      const rule = NotInListRule(['A', 'B'], 'Error');
      expect(rule.validate('C'), isNull);
    });

    test('fails when value is in list', () {
      const rule = NotInListRule(['A', 'B'], 'Error');
      expect(rule.validate('A'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = NotInListRule(['A', 'B'], 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
