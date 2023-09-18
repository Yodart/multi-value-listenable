library multi_value_listenable;

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Signature for a function that builds a widget depending on multiple values.
typedef MultiValueWidgetBuilder = Widget Function(BuildContext context, List values, Widget? child);

/// A widget that listens to multiple [ValueListenable]s and rebuilds when any of them change.
class MultiValueListenableBuilder extends StatefulWidget {
  const MultiValueListenableBuilder({super.key, required this.valueListenables, required this.builder, this.child});

  /// The list of [ValueListenable] whose value you depend on in order to build.
  final List<ValueListenable> valueListenables;

  /// A [MultiValueWidgetBuilder] which builds a widget depending on the
  /// [valueListenables]'s value.
  ///
  /// Can incorporate a [valueListenables] value-independent widget subtree
  /// from the [child] parameter into the returned widget tree.
  final MultiValueWidgetBuilder builder;

  /// A [valueListenables]-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree
  /// the [builder] builds depends on the value of the [valueListenables]. For
  /// example, if the [valueListenables] is a [String] and the [builder] simply
  /// returns a [Text] widget with the [String] value.
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _MultiValueListenableBuilderState();
}

class _MultiValueListenableBuilderState extends State<MultiValueListenableBuilder> {
  late List values;

  @override
  void initState() {
    super.initState();
    values = widget.valueListenables.map((value) => value.value).toList();
    widget.valueListenables.forEach((value) => value.addListener(onValueChanged));
  }

  @override
  void didUpdateWidget(MultiValueListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenables != widget.valueListenables) {
      oldWidget.valueListenables.map((value) => value.removeListener(onValueChanged));
      values = widget.valueListenables.map((value) => value.value).toList();
      widget.valueListenables.map((value) => value.addListener(onValueChanged));
    }
  }

  @override
  void dispose() {
    widget.valueListenables.map((value) => value.removeListener(onValueChanged));
    super.dispose();
  }

  void onValueChanged() {
    if (!mounted) return;
    setState(() => values = widget.valueListenables.map((value) => value.value).toList());
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, values, widget.child);
}
