import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('HexColorRule', () {
    test('passes on valid hex color', () {
      const rule = HexColorRule('Error');
      expect(rule.validate('#FFF'), isNull);
      expect(rule.validate('#FFFFFF'), isNull);
      expect(rule.validate('123456'), isNull);
    });

    test('fails on invalid hex color', () {
      const rule = HexColorRule('Error');
      expect(rule.validate('#FFZ'), 'Error');
      expect(
          rule.validate('#FFFF'), isNull); // 4 digits is valid hex with alpha
      expect(rule.validate('#FFFFF'), 'Error'); // 5 digits is invalid
    });

    test('passes silently on empty string', () {
      const rule = HexColorRule('Error');
      expect(rule.validate(''), isNull);
    });
  });
}
