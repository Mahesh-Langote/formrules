import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('MacAddressRule', () {
    test('passes on valid MAC address', () {
      const rule = MacAddressRule('Error');
      expect(rule.validate('00:1B:44:11:3A:B7'), isNull);
      expect(rule.validate('00-1B-44-11-3A-B7'), isNull);
    });

    test('fails on invalid MAC address', () {
      const rule = MacAddressRule('Error');
      expect(rule.validate('00:1B:44:11:3A'), 'Error');
      expect(rule.validate('00:1B:44:11:3A:BZ'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = MacAddressRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
