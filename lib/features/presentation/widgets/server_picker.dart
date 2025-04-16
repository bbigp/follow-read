

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/widgets/new_url.dart';
import 'package:follow_read/features/presentation/widgets/smart_modal.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../providers/user_provider.dart';
import 'add_text.dart';
import 'circle_radio_tile.dart';
import 'done_button.dart';
import 'drag_handle.dart';

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
        DragHandle(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16,),
            Expanded(child: Text('选择服务器URL', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black95,
              ),)),
            SizedBox(width: 12, height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 30, height: 30,
                decoration: BoxDecoration(
                  color: AppTheme.black4,
                  borderRadius: BorderRadius.circular(99),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(Svgicons.x, width: 20, height: 20,),
              ),
            ),
            SizedBox(width: 16,),
          ],
        ),
        SizedBox(height: 12,),
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
                    return GestureDetector(
                      onTap: (){
                        ref.read(_tempSelectedUrlProvider.notifier).state = url;
                      },
                      child: CircleRadioTile(value: url, choose: url == selectedUrl,),
                    );
                  }),
            )),
        SizedBox(height: 8,),
        SizedBox(height: 8,),
        Row(
          children: [
            SizedBox(width: 16,),
            AddText('添加URL', onTap: (){
              SmartModal.openSmartModal(context, NewUrl());
            }),
            Spacer(),
            DoneButton(onPressed: () {
              final temp = ref.read(_tempSelectedUrlProvider);
              if (temp != null && temp != user.user.baseUrl) {
                ref.read(userProvider.notifier).chooseUrl(temp);
              }
              Navigator.pop(context);
            }, width: 128,),
            SizedBox(width: 16,),
          ],
        ),
        SizedBox(
          height: 21,
        )
      ],
    );
  }

}


