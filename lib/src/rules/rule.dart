/// Abstract base class for all validation rules.
///
/// Consumers can extend this to build their own reusable rule classes,
/// then inject them via `Validator.addRule` (requires importing validator.dart).
abstract class ValidationRule {
  /// Default const constructor.
  const ValidationRule();

  /// Validates the [value] and returns an error string if it fails,
  /// or null if it passes.
  String? validate(String? value);
}
