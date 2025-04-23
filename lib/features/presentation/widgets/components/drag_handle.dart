

import 'package:flutter/material.dart';

import '../../../../config/theme.dart';

class DragHandle extends StatelessWidget {

  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 3.5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.black8,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }

}