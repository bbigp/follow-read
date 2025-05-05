

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_button.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/components/drag_handle.dart';
import 'package:follow_read/theme/text_styles.dart';

class AlertSheet extends StatelessWidget {

  const AlertSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        const DragHandle(),
        const SizedBox(height: 4,),
        Row(children: [
          SvgPicture.asset(Svgicons.alertFill, width: 20, height: 20, fit: BoxFit.none,),
          const SizedBox(width: 12,),
          Expanded(child: Text('Delete folder?', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500,)),
          const SizedBox(width: 12,),
          const CupxSheetTitleCloseButton(),
        ],),
        const SizedBox(height: 12,),
        Text('Are you sure you want to delete this folder? Feeds contained in the folder will be deleted together.', style: AppTextStyles.caption,),
        const SizedBox(height: 24,),
        CupxButton.text('确认', style: CupxButtonStyle.dangerLarge, enabled: true,),
        const SizedBox(height: 24,),
      ],),
    );
  }


}