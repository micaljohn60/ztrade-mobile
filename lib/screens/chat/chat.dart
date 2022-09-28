import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Tawk(
      directChatLink: 'https://tawk.to/chat/62ffcdf537898912e964075f/1garjp2rn',
      visitor: TawkVisitor(
        name: 'Mr H',
        email: 'randomlyh2020.mm@gmail.com',
      ),
    );
  }
}
