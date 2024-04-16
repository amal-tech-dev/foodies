import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/contribute_screen/contribute_widgets/guest_contribution.dart';
import 'package:foodies/view/contribute_screen/contribute_widgets/user_contibution.dart';

class ContributeScreen extends StatefulWidget {
  ContributeScreen({super.key});

  @override
  State<ContributeScreen> createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  bool guest = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    checkLoginType();
    super.initState();
  }

  // check login type
  checkLoginType() async {
    auth.authStateChanges().listen(
      (event) {
        if (event != null) {
          if (event.isAnonymous)
            guest = true;
          else
            guest = false;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: guest ? GuestContibution() : UserContibution(),
      ),
    );
  }
}
