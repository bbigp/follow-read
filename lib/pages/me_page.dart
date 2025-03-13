

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_read/utils/api_client.dart';

import '../models/user.dart';
import '../utils/logger.dart';


class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {

  User? _user;
  bool _isLoading = false;

  Future<void> _fetchUser() async {
    setState(() {
      _isLoading = true;
    });
    final user = await ApiClient.me(
      onError: (e) => setState(() {
        Fluttertoast.showToast(
          msg: "请求失败: ${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
        );
      })
    );
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
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
                          _user?.username ?? 'Username',
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
            GestureDetector(
              onTap: () {
                _showAddDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_outlined, size: 24, color: Color(0xFF8B0000),),
                  Text('添加账号', style: TextStyle(fontSize: 16, color: Color(0xFF8B0000)),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    final TextEditingController keyController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    bool isButtonEnabled = false;
    void checkInput() {
      // 检查所有输入框是否都有内容
      isButtonEnabled = urlController.text.isNotEmpty &&
          keyController.text.isNotEmpty &&
          nameController.text.isNotEmpty;
    }


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return  AlertDialog(
              insetPadding: EdgeInsets.all(10),
              title: Icon(Icons.rss_feed_outlined),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                      hintText: 'me',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        checkInput();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                      labelText: '服务器地址',
                      hintText: 'https://demo.demo.com/v1/',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        checkInput();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: keyController,
                    decoration: InputDecoration(
                      labelText: 'ApiKey',
                      hintText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        checkInput();
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('取消'),
                ),
                TextButton(
                  onPressed: isButtonEnabled ? () {
                    // Perform the "Add" action here
                    String url = urlController.text;
                    String key = keyController.text;
                    String name = nameController.text;

                    print('URL: $url, Key: $key, Name: $name');

                    Navigator.of(context).pop(); // Close the dialog
                  } : null,
                  child: Text('添加'),
                ),
              ],
            );
          },
        );
      },
    );
  }



}