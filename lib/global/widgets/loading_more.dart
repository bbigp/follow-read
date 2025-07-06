

import 'package:flutter/cupertino.dart';

///
class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, width: double.infinity,
      child: Center(
        child: CupertinoActivityIndicator(radius: 10,),
      ),
    );
  }

}