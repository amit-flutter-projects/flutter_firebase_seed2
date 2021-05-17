import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_seed2/screens/new_login_screen/new_login_screen.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../login/login_screen.dart';
import '../nav/nav_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prevState, state) => prevState.status != state.status,
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.of(context)
                .pushReplacementNamed(NewLoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
