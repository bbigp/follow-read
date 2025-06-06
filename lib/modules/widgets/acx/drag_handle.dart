

import 'package:flutter/material.dart';

import '../../../../../config/theme.dart';

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

class SheetGrabber extends StatelessWidget {

  const SheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 8),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: AppTheme.black8,
          ),
          height: 3.5, width: 36,
        ),
      ),
    );
  }


}