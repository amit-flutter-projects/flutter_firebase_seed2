import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_instagram/blocs/auth/auth_bloc.dart';
import '../../repositories/auth/auth_repository.dart';
import 'cubit/login_cubit.dart';
import '../../widgets/error_dialog.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginWithCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(content: state.failure.message,),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Seed Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                context.read<AuthRepository>().googleSignIn();
                              },
                              child: Text(
                                'Login with Google',
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                              ),
                            ),
                            // SizedBox(height: 16),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     context.read<LoginCubit>().signInAnonymously();
                            //   },
                            //   child: Text(
                            //     'Login Anonymously',
                            //   ),
                            //   style: ElevatedButton.styleFrom(
                            //     elevation: 1,
                            //   ),
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
