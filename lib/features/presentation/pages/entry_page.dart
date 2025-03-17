import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme.dart';
import '../widgets/spacer_divider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final feedId;

  const EntryPage({
    required this.feedId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          actions: [
            // _buildRefreshButton(ref, feedsState.isSyncing),
            // const SizedBox(width: 12),
          ],
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildFeedItem();
            }));
  }


  Widget _buildFeedItem(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 18,
            child: Row(
              children: [
                Icon(Icons.ac_unit, size: 18,),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Text('标题', style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.38,
                        color: AppTheme.black95,
                      ),),
                    ),
                ),
                SizedBox(
                  width: 16,
                  child: Text('3h', style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.38,
                    color: AppTheme.black25,
                  ),),
                ),
              ],
            ),
          ),
          SpacerDivider(
            indent: 0,
            spacing: 1,
            thickness: 0.5,
          ),
        ],
      ),
    );

  }


}
