
import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class TwoTabSwitch<T> extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final T leftValue;
  final T rightValue;
  final T selectedValue;
  final void Function(T value) onChanged;
  final double borderRadius;
  final double selectedBorderRadius;
  final double height;

  const TwoTabSwitch({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftValue,
    required this.rightValue,
    required this.selectedValue,
    required this.onChanged,
    this.borderRadius = 14,
    this.selectedBorderRadius = 10,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppTheme.black4,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final width = (constraints.maxWidth - 4) / 2;
        return Row(
          children: [
            _buildTab(leftLabel, leftValue, selectedValue == leftValue, width),
            _buildTab(rightLabel, rightValue, selectedValue == rightValue, width),
          ],
        );
      }),
    );
  }

  Widget _buildTab(String label, T value, bool isSelected, double width) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onChanged(value);
        }
      },
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(selectedBorderRadius),
          color: Colors.white,
        )
            : null,
        margin: isSelected ? const EdgeInsets.all(2) : null,
        width: width,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.33,
            color: isSelected ? AppTheme.black95 : AppTheme.black50,
          ),
        ),
      ),
    );
  }
}
