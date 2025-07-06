

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
class LoadingPage extends StatelessWidget {

  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity, height: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 14,),
            const CupertinoActivityIndicator(radius: 14,),
            const SizedBox(height: 14,),
            const SizedBox(height: 16,),
            const SizedBox(height: 20,),
          ],),
        ),
      ),
    );
  }

}