

import 'package:flutter/cupertino.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              radius: 10,
            )
          ],
        ),
      ),
    );
  }

}