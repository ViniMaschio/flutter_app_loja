import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final IconData? icon;
  final Color? color;
  final bool outlined;
  final bool small;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.icon,
    this.color,
    this.outlined = false,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? Colors.grey;

    final buttonStyle =
        outlined
            ? OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: defaultColor,
              side: BorderSide(color: defaultColor),
              padding: small ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null,
            )
            : ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: defaultColor,
              padding: small ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null,
            );

    final childContent =
        isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, size: small ? 16 : 18, color: Colors.white),
                if (icon != null) const SizedBox(width: 6),
                Text(label, style: TextStyle(fontSize: small ? 12 : 14, color: Colors.white)),
              ],
            );

    final button =
        outlined
            ? OutlinedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: childContent)
            : ElevatedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: childContent);

    return SizedBox(width: double.infinity, child: button);
  }
}
