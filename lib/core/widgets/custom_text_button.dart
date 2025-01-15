import 'package:flutter/material.dart';
import 'package:stroll_test/core/extensions/context_extensions.dart';
import 'package:stroll_test/features/home/presentation/views/home_page.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.state,
      this.color,
      this.textStyle});
  final VoidCallback onPressed;
  final String label;
  final AudioState state;
  final TextStyle? textStyle;
  final Color? color;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.state == AudioState.none ||
              widget.state == AudioState.recording
          ? .5
          : 1,
      duration: const Duration(milliseconds: 500),
      child: TextButton(
        onPressed: widget.state == AudioState.none ||
                widget.state == AudioState.recording
            ? () {}
            : widget.onPressed,
        child: Text(widget.label,
            style: widget.textStyle ?? context.textTheme.titleMedium),
      ),
    );
  }
}
