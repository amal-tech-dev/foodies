import 'package:flutter/material.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Foodies());
}

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmailLoginController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ForgetPasswordScreen(),
      ),
    );
  }
}
