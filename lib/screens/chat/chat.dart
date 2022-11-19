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

  String newValue = "";
  CustomSecureStorage css = CustomSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    readToken();
    super.initState();
  }

  Future<void> readToken() async{
    final String value = await css.readValue();
    setState(() {
      newValue = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return 
    newValue == null ?
    NoAuth()
    :
    Tawk(
      directChatLink: 'https://tawk.to/chat/62ffcdf537898912e964075f/1garjp2rn',
      visitor: TawkVisitor(
        name: 'Mr H',
        email: 'randomlyh2020.mm@gmail.com',
      ),
    );
  }
}
