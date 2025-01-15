import 'package:flutter/material.dart';
import 'package:stroll_test/core/extensions/widget_extensions.dart';

class RingWidget extends StatefulWidget {
  final Color color;
  final double radius;
  final Widget child;

  const RingWidget(
      {super.key,
      required this.color,
      required this.radius,
      required this.child});

  @override
  State<RingWidget> createState() => _RingWidgetState();
}

class _RingWidgetState extends State<RingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: widget.radius,
        width: widget.radius,
        decoration: BoxDecoration(
            border: Border.all(color: widget.color),
            borderRadius: BorderRadius.circular(widget.radius)),
        child: widget.child.toCenter(),
      ),
    );
  }
}
