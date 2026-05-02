import 'package:flutter/material.dart';
import 'package:formrules/formrules.dart';
import '../main.dart';

const String _formCodeSnippet = '''
final _passwordController = TextEditingController();

// ── Personal Information ──────────────────────────────────
TextFormField(
  validator: FormRules.required(message: 'First name is required')
      .alpha(message: 'Only letters allowed')
      .minLength(2)
      .build(),
)

TextFormField(
  validator: FormRules.required(message: 'Last name is required')
      .alpha(message: 'Only letters allowed')
      .build(),
)

TextFormField(
  validator: FormRules.required(message: 'Username is required')
      .alphaNumeric(message: 'No spaces or symbols')
      .minLength(3)
      .maxLength(20)
      .build(),
)

TextFormField(
  validator: FormRules.required(message: 'Date of birth is required')
      .date(message: 'Use YYYY-MM-DD format')
      .build(),
)

// ── Contact ───────────────────────────────────────────────
TextFormField(
  validator: FormRules.required(message: 'Email is required')
      .email(message: 'Enter a valid email address')
      .build(),
)

TextFormField(
  validator: FormRules.required(message: 'Country code is required')
      .countryCode(message: 'e.g. +91, +1, +44')
      .build(),
)

TextFormField(
  validator: FormRules.required(message: 'Phone number is required')
      .phone(country: PhoneCountry.india)
      .build(),
)

TextFormField(
  validator: FormRules.url(requireHttps: true).build(),
)

// ── Account Security ──────────────────────────────────────
TextFormField(
  controller: _passwordController,
  obscureText: true,
  validator: FormRules.required(message: 'Password is required')
      .password(
        minLength: 8,
        requireUppercase: true,
        requireLowercase: true,
        requireNumber: true,
        requireSpecialChar: true,
      )
      .build(),
)

TextFormField(
  obscureText: true,
  validator: FormRules.required(message: 'Please confirm your password')
      .match(() => _passwordController.text,
            message: 'Passwords do not match')
      .build(),
)

// ── Profile ───────────────────────────────────────────────
TextFormField(
  maxLines: 3,
  validator: FormRules.required(message: 'Bio is required')
      .minLength(20, message: 'Too short (min 20)')
      .maxLength(250, message: 'Too long (max 250)')
      .build(),
)

TextFormField(
  validator: FormRules.slug(message: 'Lowercase, numbers & hyphens').build(),
)

TextFormField(
  validator: FormRules.hexColor(message: 'Use #RRGGBB format').build(),
)

TextFormField(
  validator: FormRules.ipAddress().build(),
)

// ── Agreement ─────────────────────────────────────────────
TextFormField(
  validator: FormRules.required(message: 'You must agree')
      .equals('AGREE', message: 'Type exactly: AGREE')
      .uppercase(message: 'Must be uppercase')
      .build(),
)
''';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _submitted = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration successful — all fields validated'),
          backgroundColor: AppTheme.success,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            backgroundColor: AppTheme.bgSurface,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: AppTheme.textSecondary, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Registration Form Demo',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.code, size: 15, color: AppTheme.accent),
                label: const Text(
                  'View Code',
                  style: TextStyle(color: AppTheme.accent, fontSize: 13),
                ),
                onPressed: () => _showCodeDialog(context),
              ),
              const SizedBox(width: 8),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(color: AppTheme.border, height: 1),
            ),
          ),
          // Body
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _submitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _sectionCard(
                          title: 'Personal Information',
                          children: [
                            _row([
                              _input(
                                label: 'First Name',
                                hint: 'John',
                                icon: Icons.person_outline,
                                validator: FormRules.required(
                                        message: 'First name is required')
                                    .alpha(message: 'Only letters allowed')
                                    .minLength(2)
                                    .build(),
                              ),
                              _input(
                                label: 'Last Name',
                                hint: 'Doe',
                                icon: Icons.person_outline,
                                validator: FormRules.required(
                                        message: 'Last name is required')
                                    .alpha(message: 'Only letters allowed')
                                    .build(),
                              ),
                            ]),
                            const SizedBox(height: 16),
                            _row([
                              _input(
                                label: 'Username',
                                hint: 'johndoe99',
                                icon: Icons.alternate_email,
                                validator: FormRules.required(
                                        message: 'Username is required')
                                    .alphaNumeric(
                                        message: 'No spaces or symbols')
                                    .minLength(3)
                                    .maxLength(20)
                                    .build(),
                              ),
                              _input(
                                label: 'Date of Birth',
                                hint: '1995-06-15',
                                icon: Icons.calendar_today_outlined,
                                validator: FormRules.required(
                                        message: 'Date of birth is required')
                                    .date(message: 'Use YYYY-MM-DD format')
                                    .build(),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _sectionCard(
                          title: 'Contact Details',
                          children: [
                            _input(
                              label: 'Email Address',
                              hint: 'john.doe@example.com',
                              icon: Icons.alternate_email,
                              validator: FormRules.required(
                                      message: 'Email is required')
                                  .email(message: 'Enter a valid email address')
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            _row([
                              _input(
                                label: 'Country Code',
                                hint: '+91',
                                icon: Icons.flag_outlined,
                                validator: FormRules.required(
                                        message: 'Country code is required')
                                    .countryCode(message: 'e.g. +91, +1, +44')
                                    .build(),
                              ),
                              _input(
                                label: 'Phone Number',
                                hint: '+91 9876543210',
                                icon: Icons.phone_outlined,
                                validator: FormRules.required(
                                        message: 'Phone is required')
                                    .phone(country: PhoneCountry.india)
                                    .build(),
                              ),
                            ]),
                            const SizedBox(height: 16),
                            _input(
                              label: 'Website',
                              hint: 'https://yourwebsite.com',
                              icon: Icons.link,
                              validator: FormRules.url(
                                      requireHttps: true,
                                      message: 'Must start with https://')
                                  .build(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _sectionCard(
                          title: 'Account Security',
                          children: [
                            _input(
                              label: 'Password',
                              hint: 'Min 8 chars with upper, number & special',
                              icon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              controller: _passwordController,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18,
                                  color: AppTheme.textSecondary,
                                ),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                              validator: FormRules.required(
                                      message: 'Password is required')
                                  .password()
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            _input(
                              label: 'Confirm Password',
                              hint: 'Re-enter your password',
                              icon: Icons.lock_reset_outlined,
                              obscureText: _obscureConfirm,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18,
                                  color: AppTheme.textSecondary,
                                ),
                                onPressed: () => setState(
                                    () => _obscureConfirm = !_obscureConfirm),
                              ),
                              validator: FormRules.required(
                                      message: 'Please confirm your password')
                                  .match(() => _passwordController.text,
                                      message: 'Passwords do not match')
                                  .build(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _sectionCard(
                          title: 'Profile',
                          children: [
                            _input(
                              label: 'Bio',
                              hint:
                                  'Tell us about yourself (20–250 characters)',
                              icon: Icons.notes_outlined,
                              maxLines: 3,
                              validator: FormRules.required(
                                      message: 'Bio is required')
                                  .minLength(20,
                                      message: 'Too short — min 20 characters')
                                  .maxLength(250,
                                      message: 'Too long — max 250 characters')
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            _row([
                              _input(
                                label: 'GitHub Username',
                                hint: 'my-github-handle',
                                icon: Icons.code,
                                validator: FormRules.slug(
                                        message:
                                            'Lowercase, numbers & hyphens only')
                                    .build(),
                              ),
                              _input(
                                label: 'Favourite Hex Color',
                                hint: '#3B82F6',
                                icon: Icons.palette_outlined,
                                validator: FormRules.hexColor(
                                        message: 'Use #RRGGBB or #RGB format')
                                    .build(),
                              ),
                            ]),
                            const SizedBox(height: 16),
                            _input(
                              label: 'IP Address (Optional)',
                              hint: '192.168.1.1',
                              icon: Icons.router_outlined,
                              validator: FormRules.ipAddress(
                                      message:
                                          'Enter a valid IPv4 or IPv6 address')
                                  .build(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _sectionCard(
                          title: 'Agreement',
                          children: [
                            Text(
                              'By registering, you agree to our Terms of Service and Privacy Policy. Type AGREE below to confirm.',
                              style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 13,
                                  height: 1.5),
                            ),
                            const SizedBox(height: 16),
                            _input(
                              label: 'Confirmation',
                              hint: 'Type AGREE',
                              icon: Icons.check_circle_outline,
                              validator: FormRules.required(
                                      message: 'You must agree to continue')
                                  .equals('AGREE',
                                      message: 'Type exactly: AGREE')
                                  .uppercase(message: 'Must be uppercase')
                                  .build(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Submit
                        FilledButton(
                          onPressed: _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.accent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Submit Registration',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppTheme.border, height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(List<Widget> fields) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 480) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields
              .map((f) => Expanded(child: f))
              .toList()
              .expand((w) => [w, const SizedBox(width: 16)])
              .toList()
            ..removeLast(),
        );
      }
      return Column(
          children: fields
              .map((f) =>
                  Padding(padding: const EdgeInsets.only(bottom: 16), child: f))
              .toList());
    });
  }

  Widget _input({
    required String label,
    required String hint,
    required IconData icon,
    required FormFieldValidator<String> validator,
    TextEditingController? controller,
    bool obscureText = false,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        hintText: hint,
        hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
        prefixIcon: Icon(icon, color: AppTheme.textSecondary, size: 18),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.bgPrimary,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.borderFocus, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.error, width: 1.5),
        ),
        errorStyle: const TextStyle(
            color: AppTheme.error, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _showCodeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 680, maxHeight: 560),
              decoration: BoxDecoration(
                color: AppTheme.bgSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                    child: Row(
                      children: [
                        const Icon(Icons.code,
                            color: AppTheme.accent, size: 18),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Registration Form — Code Snippet',
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close,
                              color: AppTheme.textSecondary, size: 18),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppTheme.border, height: 1),
                  Expanded(
                    child: Container(
                      color: AppTheme.bgPrimary,
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          _formCodeSnippet,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFF79C0FF),
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: AppTheme.border, height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
