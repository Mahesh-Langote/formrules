import 'package:formrules/src/l10n/messages/en.dart';

/// Global controller for form rules localization.
///
/// To override messages globally, set [current] to your custom implementation
/// of [FormRulesMessagesEn].
class FormRulesLocalizations {
  FormRulesLocalizations._();

  /// The currently active localization messages.
  /// Defaults to [FormRulesMessagesEn].
  static FormRulesMessagesEn current = const FormRulesMessagesEn();
}
