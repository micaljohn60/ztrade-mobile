import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/share/components/no_auth/no_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/secure_storage/custom_secure_storage.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String email = "";
  String userName = "";
  String token = "";
  CustomSecureStorage css = CustomSecureStorage();
  WebViewController _controller;
  final Uri _chatUrl =
      Uri.parse('https://tawk.to/chat/6396028bb0d6371309d3dde4/1gk0vjt5a');

  void _launchUrl() async {
    if (!await launchUrl(_chatUrl,mode: LaunchMode.externalApplication)) throw 'Could not launch $_chatUrl';
  }

  @override
  void initState() {
    // TODO: implement initState
    readToken();
    super.initState();
  }

  Future<void> readToken() async {
    final String newToken = await css.readValue();
    final String newuserName = await css.readValueName("username");
    final String newemail = await css.readValueName("email");
    setState(() {
      email = newemail;
      userName = newuserName;
      token = newToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return token == null
        ? NoAuth()
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text("Please click the link to open Chat Window"),
              ),
              GestureDetector(
                onTap: _launchUrl,
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryBackgroundColor,
                  ),
                  child: Center(child: Text('Go to Chat',style: TextStyle(color: Colors.white),)),
                ),
              )
            ]),
          );
    // Tawk(
    //   directChatLink: 'https://tawk.to/chat/6396028bb0d6371309d3dde4/1gk0vjt5a',
    //   visitor: TawkVisitor(
    //     name: userName,
    //     email: email,
    //   ),
    // );
  }
}
