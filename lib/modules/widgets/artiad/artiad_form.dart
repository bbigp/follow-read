


import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/controller/add_artiad/add_artiad_controller.dart';
import 'package:follow_read/modules/widgets/acx/cupx_sliding_segmented_control.dart';
import 'package:follow_read/modules/widgets/artiad/basic_view.dart';
import 'package:get/get.dart';

import 'advanced_view.dart';

class ArtiadForm extends StatefulWidget {

  final int id;
  const ArtiadForm({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ArtiadFormState();
}

class _ArtiadFormState extends State<ArtiadForm> {

  String _selectedSegment = 'Advanced';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddArtiadController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.black4,
      ),
      body: Container(
        color: AppTheme.black4,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    CupxSlidingSegmentedControl(
                        groupValue: _selectedSegment,
                        onValueChanged: (value) {
                          setState(() {
                            _selectedSegment = value!;
                          });
                        },
                        children: ['Basic', 'Advanced'],
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 12, left: 16, right: 16),
                      child: CupxSlidingSegmentedControl(
                        groupValue: _selectedSegment,
                        onValueChanged: (value) {
                          setState(() {
                            _selectedSegment = value!;
                          });
                        },
                        children: ['Basic', 'Advanced'],
                      ),
                    ),
                    if (_selectedSegment == 'Basic') BasicView(addArtiad: controller),
                    if (_selectedSegment == 'Advanced') AdvancedView(addArtiad: controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.put(AddArtiadController(widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<AddArtiadController>();
  }
}