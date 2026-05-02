import 'package:flutter_test/flutter_test.dart';
import 'package:formrules/formrules.dart';

class TestMessages extends FormRulesMessagesEn {
  @override
  String get required => 'Custom required';
}

void main() {
  group('Localization overrides', () {
    test('uses default english messages', () {
      final validator = FormRules.required().build();
      expect(validator(''), 'This field is required.');
    });

    test('uses global override', () {
      final old = FormRulesLocalizations.current;
      FormRulesLocalizations.current = TestMessages();

      final validator = FormRules.required().build();
      expect(validator(''), 'Custom required');

      FormRulesLocalizations.current = old;
    });

    test('falls back to english for non-overridden messages', () {
      final old = FormRulesLocalizations.current;
      FormRulesLocalizations.current = TestMessages();

      final validator = FormRules.email().build();
      expect(validator('notemail'), 'Enter a valid email address.');

      FormRulesLocalizations.current = old;
    });
  });
}
