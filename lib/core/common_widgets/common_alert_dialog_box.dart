import 'package:flutter/material.dart';
import 'package:test_todo_app/core/theme/skin.dart';


class CommonDialog extends StatelessWidget {
  final String title;
  final Widget message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onPressed;
  final VoidCallback? onCancel;
  final Color? confirmButtonColor;


  const CommonDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onPressed,
    this.cancelText,
    this.onCancel,
    this.confirmButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message,
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
          child: Text(cancelText ?? 'Cancel'),
        ),

        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:confirmButtonColor?? Skin.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(confirmText ?? 'OK'),
        ),
      ],
    );
  }
}
