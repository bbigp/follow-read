
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class OpenModal {

  static void open(BuildContext context, Widget view){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // 允许内容高度超过屏幕70%
      backgroundColor: AppTheme.white95,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDragHandle(),
                  view,
                ],
              ),
            );
          }
        );
      },
    );
  }

  static Widget _buildDragHandle() {
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