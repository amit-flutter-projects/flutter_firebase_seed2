import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_seed2/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_seed2/blocs/simple_bloc_observer.dart';
import 'package:flutter_firebase_seed2/config/custom_router.dart';
import 'package:flutter_firebase_seed2/repositories/auth/auth_repository.dart';
import 'package:flutter_firebase_seed2/screens/login/cubit/login_cubit.dart';
import 'package:flutter_firebase_seed2/screens/login/login_screen.dart';
import 'package:flutter_firebase_seed2/screens/nav/nav_screen.dart';
import 'package:flutter_firebase_seed2/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: AuthRepository(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            "/": (ctx) => SplashScreen(),
            SplashScreen.routeName: (ctx) => SplashScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            NavScreen.routeName: (ctx) => NavScreen(),
          },
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
