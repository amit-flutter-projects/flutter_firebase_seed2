import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';

class NewLoginScreen extends StatelessWidget {
  static const routeName = "/new_login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome Screen'),
      ),
      body: Center(
        child: Center(
          child: ElevatedButton(
            child: const Text("Sign In"),
            onPressed: () async {
              final providers = [
                AuthUiProvider.phone,
                AuthUiProvider.google,
              ];

              final result = await FlutterAuthUi.startUi(
                items: providers,
                tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                  tosUrl: "https://www.google.com",
                  privacyPolicyUrl: "https://www.google.com",
                ),
                androidOption: AndroidOption(
                  enableSmartLock: false, // default true
                  showLogo: false, // default false
                  overrideTheme: false, // default false
                ),
                emailAuthOption: EmailAuthOption(
                  requireDisplayName: true, // default true
                  enableMailLink: false, // default false
                  handleURL: '',
                  androidPackageName: 'com.prachet.flutter_firebase_seed2',
                  androidMinimumVersion: '',
                ),
              );
              print('User Authenticated : $result');
              //print(FirebaseAuth.instance.currentUser!.phoneNumber);
            },
          ),
        ),
      ),
    );
  }
}
