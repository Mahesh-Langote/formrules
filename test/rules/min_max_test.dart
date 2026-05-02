import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/formrules.dart';

void main() {
  group('MinRule', () {
    final validator = FormRules.min(10).build();

    test('should pass if value is null or empty', () {
      expect(validator(null), null);
      expect(validator(''), null);
    });

    test('should pass if value is greater than or equal to min', () {
      expect(validator('10'), null);
      expect(validator('15'), null);
      expect(validator('10.5'), null);
    });

    test('should fail if value is less than min', () {
      expect(validator('9'), 'Must be at least 10');
      expect(validator('0'), 'Must be at least 10');
      expect(validator('-5'), 'Must be at least 10');
    });

    test('should fail if value is not numeric', () {
      expect(validator('abc'), 'Must be at least 10');
    });

    test('should use custom message', () {
      final custom = FormRules.min(10, message: 'Too low').build();
      expect(custom('5'), 'Too low');
    });
  });

  group('MaxRule', () {
    final validator = FormRules.max(10).build();

    test('should pass if value is null or empty', () {
      expect(validator(null), null);
      expect(validator(''), null);
    });

    test('should pass if value is less than or equal to max', () {
      expect(validator('10'), null);
      expect(validator('5'), null);
      expect(validator('9.9'), null);
    });

    test('should fail if value is greater than max', () {
      expect(validator('11'), 'Must be at most 10');
      expect(validator('100'), 'Must be at most 10');
    });

    test('should fail if value is not numeric', () {
      expect(validator('abc'), 'Must be at most 10');
    });

    test('should use custom message', () {
      final custom = FormRules.max(10, message: 'Too high').build();
      expect(custom('15'), 'Too high');
    });
  });
}
