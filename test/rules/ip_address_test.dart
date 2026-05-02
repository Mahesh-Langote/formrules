import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('IpAddressRule', () {
    test('passes on valid IPv4', () {
      const rule = IpAddressRule('Error');
      expect(rule.validate('192.168.1.1'), isNull);
    });

    test('fails on invalid IPv4', () {
      const rule = IpAddressRule('Error');
      expect(rule.validate('256.1.2.3'), 'Error');
      expect(rule.validate('1.2.3'), 'Error');
    });

    test('passes on valid IPv6', () {
      const rule = IpAddressRule('Error');
      expect(rule.validate('2001:0db8:85a3:0000:0000:8a2e:0370:7334'), isNull);
      expect(rule.validate('::1'), isNull);
    });

    test('fails if v4Only is set and input is v6', () {
      const rule = IpAddressRule('Error', v4Only: true);
      expect(rule.validate('::1'), 'Error');
    });

    test('passes silently on empty string', () {
      const rule = IpAddressRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
