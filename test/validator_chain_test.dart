import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/formrules.dart';

void main() {
  group('Validator Chain', () {
    test('executes in order and fails fast', () {
      final validator = FormRules.required(
        message: 'Req',
      ).minLength(3, message: 'Min').email(message: 'Email').build();

      expect(validator(''), 'Req');
      expect(validator('ab'), 'Min');
      expect(validator('abc'), 'Email');
      expect(validator('abc@example.com'), isNull);
    });

    test('passes on empty for non-required chain', () {
      final validator = FormRules.email(message: 'Email').build();
      expect(validator(''), isNull);
      expect(validator(null), isNull);
      expect(validator('notanemail'), 'Email');
    });

    test('custom rule executes correctly', () {
      final validator = FormRules.required()
          .custom((val) => val == 'secret' ? null : 'Wrong')
          .build();

      expect(validator('hello'), 'Wrong');
      expect(validator('secret'), isNull);
    });

    test('addRule executes correctly', () {
      final validator = FormRules.required().addRule(_MyCustomRule()).build();

      expect(validator('hello'), 'Fail');
      expect(validator('pass'), isNull);
    });
  });
}

class _MyCustomRule extends ValidationRule {
  @override
  String? validate(String? value) {
    if (value != 'pass') return 'Fail';
    return null;
  }
}
