## [1.0.1] - 2026-05-02

### Changed
- Updated repository URLs and documentation links for consistency.
- Refined the showcase application with a clean, professional design system.
- Optimized CI workflow by scoping formatting and analysis checks.

## [1.0.0] - 2026-05-02

### Added
- Initial release with **34 comprehensive built-in rules**.
- **Multi-Country Phone Validation**: Added `PhoneCountry` enum for strict validation (US, UK, India, Australia, Brazil, Germany, France, Japan, China).
- **Country Code Validation**: Added `countryCode()` rule for ITU-T E.164 dial codes.
- **Fluent & Chainable API**: Beautiful builder syntax for easy `TextFormField` integration.
- **Fail-Fast Engine**: Immediately returns the first error found to optimize UX.
- **Zero-Dependency**: No `intl` or third-party bloat — pure Dart and Flutter.
- **Localization**: Full support for custom error messages via `FormRulesMessagesEn`.
- **Custom Rules**: Support for inline closures and reusable custom rule classes.
- **Premium Showcase**: Comprehensive example app featuring every rule and a real-world registration form.
