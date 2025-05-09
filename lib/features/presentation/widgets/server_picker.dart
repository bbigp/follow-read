

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_button.dart';
import 'package:follow_read/features/presentation/widgets/new_url.dart';
import 'package:follow_read/features/presentation/widgets/smart_modal.dart';

import '../../../config/theme.dart';
import '../providers/user_provider.dart';
import 'circle_radio_tile.dart';
import 'components/cupx_sheet_title.dart';
import 'components/drag_handle.dart';

class ServerPicker extends ConsumerWidget {

  ServerPicker({super.key});

  final _tempSelectedUrlProvider = StateProvider.autoDispose<String?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final user = userAsync.requireValue;

    final tempSelected = ref.watch(_tempSelectedUrlProvider);
    final selectedUrl = tempSelected ?? user.user.baseUrl;
    return Column(
      children: [
        const DragHandle(),
        CupxSheetTitle.closeButton(title: '选择服务器URL', left: false, right: true,),
        const SizedBox(height: 8),
        Container(
            decoration: BoxDecoration(
              color: AppTheme.white0,
              borderRadius: BorderRadius.circular(16),
            ),
            height: user.urls.length * 40 + 16,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8,),
              child: ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user.urls.length,
                  itemBuilder: (context, index) {
                    final url = user.urls[index];
                    return CircleRadioTile(value: url, choose: url == selectedUrl,
                      onTap: (){
                        ref.read(_tempSelectedUrlProvider.notifier).state = url;
                      },
                    );
                  }),
            )),
        const SizedBox(height: 8,),
        const SizedBox(height: 8,),
        Row(
          children: [
            const SizedBox(width: 16,),
            CupxButton.icon('添加URL', icon: Svgicons.plusO,
              style: CupxButtonStyle.ghostMediumCompact.copyWith(size: mediumCompactButtonSize.copyWith(padding: 8)),
              enabled: true,
              onPressed: () async {
                SmartModal.openSmartModal(context, NewUrl());
              },
            ),
            const Spacer(),
            CupxButton.text('Done',
                style: CupxButtonStyle.primaryMediumCompact.copyWith(
                    size: mediumCompactButtonSize.copyWith(padding: 45)),
                enabled: ref.read(_tempSelectedUrlProvider) != null,
                onPressed: () async {
                  final temp = ref.read(_tempSelectedUrlProvider);
                  if (temp != null && temp != user.user.baseUrl) {
                    ref.read(userProvider.notifier).chooseUrl(temp);
                  }
                  Navigator.pop(context);
                }),
            const SizedBox(width: 16,),
          ],
        ),
        const SizedBox(
          height: 21,
        )
      ],
    );
  }

}


