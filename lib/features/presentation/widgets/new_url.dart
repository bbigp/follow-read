


import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/done_button.dart';

class NewUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
          labelText: '服务器URL',
            hintText: 'ex. https://api.example.cn/v1/',
          ),
          keyboardType: TextInputType.url,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '服务器URL必填';
            }
            return null;
          }
        ),
        SizedBox(height: 8,),
        SizedBox(height: 8,),
        DoneButton(onPressed: (){

        }),
        SizedBox(
          height: 21,
        )
      ],
    );
  }

}