import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:omni_mobile_app/share/components/no_auth/no_auth.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    readToken();
    super.initState();
  }

  Future<void> readToken() async{
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
    return 
    token == null ?
    NoAuth()
    :
    Tawk(
      directChatLink: 'https://tawk.to/chat/6396028bb0d6371309d3dde4/1gk0vjt5a',
      visitor: TawkVisitor(
        name: userName,
        email: email,
      ),
    );
  }
}
