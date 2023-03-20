import 'package:flutter/material.dart';

class CapsuleSelector extends StatefulWidget {
  final List<CapsuleOption> options;
  final num? initial;
  final void Function(num) onChange;
  final double? radius;
  const CapsuleSelector({
    Key? key,
    required this.options,
    required this.onChange,
    this.initial,
    this.radius,
  }) : super(key: key);

  @override
  _CapsuleSelectorState createState() => _CapsuleSelectorState();
}

class _CapsuleSelectorState extends State<CapsuleSelector> {
  late num current = widget.initial != null ? widget.initial as num : 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 0, minWidth: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius != null ? widget.radius as double : 100)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.options.map<_CapsuleOption>(
            (CapsuleOption c) {
              return _CapsuleOption(
                selectedChild: c.selectedChild,
                unselectedChild: c.unselectedChild,
                value: c.value,
                current: current,
                onSelect: (n) {
                  current = n;
                  widget.onChange(n);
                  setState(() {});
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class CapsuleOption {
  final Widget selectedChild;
  final Widget unselectedChild;
  final num value;
  const CapsuleOption({
    Key? key,
    required this.selectedChild,
    required this.unselectedChild,
    required this.value,
  });
}

class _CapsuleOption extends StatelessWidget {
  final Widget selectedChild;
  final Widget unselectedChild;
  final num value;
  final num current;
  final void Function(num) onSelect;
  const _CapsuleOption({
    Key? key,
    required this.selectedChild,
    required this.unselectedChild,
    required this.value,
    required this.current,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(value),
      child: value == current ? selectedChild : unselectedChild,
    );
  }
}
