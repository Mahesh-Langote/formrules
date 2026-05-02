import 'package:flutter/material.dart';
import '../main.dart';

class CodeSnippetDialog extends StatelessWidget {
  final String title;
  final String code;

  const CodeSnippetDialog({super.key, required this.title, required this.code});

  static void show(BuildContext context, String title, String code) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, anim1, anim2) =>
          CodeSnippetDialog(title: title, code: code),
      transitionBuilder: (context, anim1, anim2, child) => FadeTransition(
        opacity: anim1,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620),
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
              child: Row(
                children: [
                  const Icon(Icons.code, color: AppTheme.accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              color: AppTheme.bgPrimary,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: SelectableText(
                  code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Color(0xFF79C0FF),
                    fontSize: 13,
                    height: 1.6,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
