

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
import 'package:follow_read/modules/widgets/obx/obx_app_bar.dart';
import 'package:get/get.dart';

import 'add_filter_controller.dart';
import 'advanced_view.dart';
import 'basic_view.dart';

class AddFilterForm extends StatefulWidget {

  const AddFilterForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddFilterFormState();
}

class _AddFilterFormState extends State<AddFilterForm> {

  String _selectedSegment = 'Basic';

  final controller = Get.find<AddFilterController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ObxAppBar(builder: () => ActionSheetTitleBar(
        title: 'New Filter',
        enabled: controller.state.title.isNotEmpty,
        color: AppColors.black04,
        onPressed: () async {
          await controller.save();
          Get.back();
        },
      ),),
      body: Container(
        color: AppColors.black04,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 12, left: 16, right: 16),
                      child: CupxSlidingSegmentedControl(groupValue: _selectedSegment,
                        onValueChanged: (value) {
                          setState(() {
                            _selectedSegment = value!;
                          });
                        },
                        children: ['Basic', 'Advanced'],
                      ),
                    ),
                    if (_selectedSegment == 'Basic') BasicView(controller: controller),
                    if (_selectedSegment == 'Advanced') AdvancedView(controller: controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}