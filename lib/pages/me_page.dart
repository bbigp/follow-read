

import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [

        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('账户', style: TextStyle(fontSize: 30, color: Color(0xFF8B0000)),),
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('列表', style: TextStyle(fontSize: 14, ),),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0), // 内边距
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 对齐方式
              children: [
                // 账号图标（左边）
                Icon(Icons.rss_feed_outlined, size: 28,),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0), // 左边间距
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 账号名称
                      Text(
                        'accountName',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87, // 文字颜色
                        ),
                      ),
                      // 账号 URL
                      Text(
                        'accountUrl',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey, // URL 颜色
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text('点击切换账号', style: TextStyle(fontSize: 12, color: Colors.grey),),
          //   ],
          // ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_outlined, size: 24, color: Color(0xFF8B0000),),
              Text('添加账号', style: TextStyle(fontSize: 16, color: Color(0xFF8B0000)),)
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


}