import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/src/rules/rules.dart';

void main() {
  group('UrlRule', () {
    test('passes on valid url', () {
      const rule = UrlRule('Invalid url');
      expect(rule.validate('http://example.com'), isNull);
      expect(rule.validate('https://example.com/path'), isNull);
    });

    test('fails on invalid url scheme', () {
      const rule = UrlRule('Invalid url');
      expect(rule.validate('ftp://example.com'), 'Invalid url');
    });

    test('fails on missing url components', () {
      const rule = UrlRule('Invalid url');
      expect(rule.validate('not_a_url'), 'Invalid url');
    });

    test('fails if requireHttps is true and scheme is http', () {
      const rule = UrlRule('Must be https', requireHttps: true);
      expect(rule.validate('http://example.com'), 'Must be https');
      expect(rule.validate('https://example.com'), isNull);
    });

    test('passes silently on empty string', () {
      const rule = UrlRule('Invalid url');
      expect(rule.validate(''), isNull);
    });

    test('passes silently on null', () {
      const rule = UrlRule('Invalid url');
      expect(rule.validate(null), isNull);
    });
  });
}
