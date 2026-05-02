import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('InListRule', () {
    test('passes when value is in list', () {
      const rule = InListRule(['A', 'B'], 'Error');
      expect(rule.validate('A'), isNull);
    });

    test('fails when value is not in list', () {
      const rule = InListRule(['A', 'B'], 'Error');
      expect(rule.validate('C'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = InListRule(['A', 'B'], 'Error');
      expect(rule.validate(''), isNull);
    });
  });
}
