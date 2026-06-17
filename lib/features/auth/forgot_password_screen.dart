import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../shared/layout/app_shell.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _submitted = false;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    // Simulated network delay — this is a mock with no real API call.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _loading = false;
        _submitted = true;
      });
    }
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRe.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: CenteredContent(
          maxWidth: 460,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTokens.space24),
              child: Card(
                elevation: AppTokens.cardElevation,
                shape: const RoundedRectangleBorder(
                  borderRadius: AppTokens.brXl,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppTokens.space32),
                  child: AnimatedSwitcher(
                    duration: AppTokens.motionMed,
                    child: _submitted
                        ? _SuccessContent(
                            email: _emailController.text.trim(),
                            onBackToSignIn: () => Navigator.of(context).pop(),
                          )
                        : _FormContent(
                            formKey: _formKey,
                            emailController: _emailController,
                            loading: _loading,
                            validateEmail: _validateEmail,
                            onSubmit: _submit,
                            onBack: () => Navigator.of(context).pop(),
                            theme: theme,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Form state
// ---------------------------------------------------------------------------

class _FormContent extends StatelessWidget {
  const _FormContent({
    required this.formKey,
    required this.emailController,
    required this.loading,
    required this.validateEmail,
    required this.onSubmit,
    required this.onBack,
    required this.theme,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool loading;
  final String? Function(String?) validateEmail;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.lock_reset_outlined,
            size: 56,
            color: theme.colorScheme.primary,
          ),
          Gaps.v16,
          Text(
            'Forgot your password?',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.v8,
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Gaps.v32,
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            onFieldSubmitted: (_) => onSubmit(),
            decoration: const InputDecoration(
              labelText: 'Email address',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: AppTokens.brMd,
              ),
            ),
            validator: validateEmail,
          ),
          Gaps.v24,
          FilledButton(
            onPressed: loading ? null : onSubmit,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppTokens.space16),
              shape: const StadiumBorder(),
            ),
            child: loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Send reset link'),
          ),
          Gaps.v12,
          TextButton(
            onPressed: onBack,
            child: const Text('Back to sign in'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Success state
// ---------------------------------------------------------------------------

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({
    required this.email,
    required this.onBackToSignIn,
  });

  final String email;
  final VoidCallback onBackToSignIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      key: const ValueKey('success'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.mark_email_read_outlined,
          size: 72,
          color: AppTokens.success,
        ),
        Gaps.v24,
        Text(
          'Check your email',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v12,
        Text(
          "If an account exists for $email, we've sent a reset link.",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        Gaps.v8,
        Text(
          'Please also check your spam folder.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Gaps.v32,
        FilledButton(
          onPressed: onBackToSignIn,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppTokens.space16),
            shape: const StadiumBorder(),
          ),
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }
}
