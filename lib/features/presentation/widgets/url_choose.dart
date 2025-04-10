

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../../core/utils/logger.dart';
import '../providers/user_provider.dart';
import 'add_text.dart';
import 'circle_radio_tile.dart';
import 'done_button.dart';

class UrlChoose extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final user = userAsync.requireValue;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            )
          ],
        ),
        SizedBox(height: 12,),
        Container(
            decoration: BoxDecoration(
              color: AppTheme.white0,
              borderRadius: BorderRadius.circular(16),
            ),
            height: user.urls.length * 40 + 16,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                  itemCount: user.urls.length,
                  itemBuilder: (context, index) {
                    final url = user.urls[index];
                    return CircleRadioTile(
                      value: url,
                      choose: url == user.user.baseUrl,
                      onChanged: (v) {
                        logger.i('选中了: ${url}');
                      },
                    );
                  }),
            )),
        SizedBox(height: 8,),
        SizedBox(height: 8,),
        Row(
          children: [
            AddText('添加URL', onTap: (){

            }),
            Spacer(),
            DoneButton(onPressed: () {

            }, width: 128,),
          ],
        ),
        SizedBox(
          height: 21,
        )
      ],
    );
  }

}


