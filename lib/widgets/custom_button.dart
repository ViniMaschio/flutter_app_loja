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

    if (small) {
      return SizedBox(
        height: 36,
        width: 36,
        child: Material(
          color: outlined ? Colors.transparent : defaultColor,
          shape: const CircleBorder(),
          child: IconButton(
            icon:
                isLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(icon ?? Icons.help, size: 18, color: outlined ? defaultColor : Colors.white),
            onPressed: isLoading ? null : onPressed,
            tooltip: label,
          ),
        ),
      );
    }

    final style =
        outlined
            ? OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: defaultColor,
              side: BorderSide(color: defaultColor),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            )
            : ElevatedButton.styleFrom(
              backgroundColor: defaultColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            );

    final child =
        isLoading
            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, size: 18, color: Colors.white),
                if (icon != null) const SizedBox(width: 6),
                Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
              ],
            );

    return SizedBox(
      width: double.infinity,
      child:
          outlined
              ? OutlinedButton(onPressed: isLoading ? null : onPressed, style: style, child: child)
              : ElevatedButton(onPressed: isLoading ? null : onPressed, style: style, child: child),
    );
  }
}
