

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingMore extends StatelessWidget {
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