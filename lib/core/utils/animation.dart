import 'package:flutter/material.dart';

class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDuration; 
  final Duration staggerDelay; 
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StaggeredList({
    Key? key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 450),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.axis = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  _StaggeredListState createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Duration _totalDuration;

  @override
  void initState() {
    super.initState();
    final base = widget.itemDuration;
    final stagger = widget.staggerDelay;
    _totalDuration = Duration(
      milliseconds:
          base.inMilliseconds +
          stagger.inMilliseconds * (widget.children.length - 1),
    );
    _ctrl = AnimationController(vsync: this, duration: _totalDuration);
    // start animation as soon as the widget appears
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.generate(widget.children.length, (i) {
      final startMs = widget.staggerDelay.inMilliseconds * i;
      final endMs = startMs + widget.itemDuration.inMilliseconds;
      final start = startMs / _totalDuration.inMilliseconds;
      final end =
          endMs / _totalDuration.inMilliseconds > 1.0
              ? 1.0
              : endMs / _totalDuration.inMilliseconds;
      final animation = CurvedAnimation(
        parent: _ctrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      );

      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final double opacity = animation.value;
          final offsetY = (1 - animation.value) * 18; // slide up effect
          return Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, offsetY),
              child: child,
            ),
          );
        },
        child: widget.children[i],
      );
    });

    if (widget.axis == Axis.vertical) {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: children,
      );
    } else {
      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: children,
      );
    }
  }
}
