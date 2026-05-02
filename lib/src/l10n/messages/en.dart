/// Base message class for form rules.
///
/// Consumers can extend this to add their language or override specific messages.
class FormRulesMessagesEn {
  /// Default const constructor.
  const FormRulesMessagesEn();

  /// Message for the required rule.
  String get required => 'This field is required.';

  /// Message for the email rule.
  String get email => 'Enter a valid email address.';

  /// Message for the minLength rule.
  String minLength(int n) => 'Must be at least $n characters.';

  /// Message for the maxLength rule.
  String maxLength(int n) => 'Must be no more than $n characters.';

  /// Message for the URL rule.
  String get url => 'Enter a valid URL.';

  /// Message for the URL rule when HTTPS is required.
  String get urlHttps => 'URL must use HTTPS.';

  /// Message for the phone rule.
  String get phone => 'Enter a valid phone number.';

  /// Message for the min rule.
  String min(num min) => 'Must be at least $min';

  /// Message for the max rule.
  String max(num max) => 'Must be at most $max';

  /// Message for the countryCode rule.
  String get countryCode => 'Please enter a valid country code.';

  /// Message for the numeric rule.
  String get numeric => 'Only numbers are allowed.';

  /// Message for the regex rule.
  String get regex => 'Invalid format.';

  /// Message for the match rule.
  String get match => 'Fields do not match.';

  /// Message for the noSpecialChars rule.
  String get noSpecialChars => 'Special characters are not allowed.';

  // ── New 21 Rules ──

  String get alpha => 'Only alphabetic characters are allowed.';
  String get alphaNumeric => 'Only alphanumeric characters are allowed.';
  String get lowercase => 'Must be strictly lowercase.';
  String get uppercase => 'Must be strictly uppercase.';
  String get inList => 'Invalid selection.';
  String get notInList => 'This selection is not allowed.';
  String get equals => 'Must match the required value.';
  String get notEquals => 'Must not match the restricted value.';
  String get contains => 'Must contain the required text.';
  String get startsWith => 'Must start with the required text.';
  String get endsWith => 'Must end with the required text.';
  String get ipAddress => 'Enter a valid IP address.';
  String get macAddress => 'Enter a valid MAC address.';
  String get creditCard => 'Enter a valid credit card number.';
  String get date => 'Enter a valid date.';
  String get uuid => 'Enter a valid UUID.';
  String get hexColor => 'Enter a valid hex color.';
  String get base64 => 'Enter a valid base64 string.';
  String get json => 'Enter valid JSON.';
  String get slug => 'Enter a valid URL slug.';
  String get password => 'Password is not strong enough.';
}
