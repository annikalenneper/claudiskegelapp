// lib/main.dart
import 'package:claudiskegelapp/utils/routes.dart';
import 'package:claudiskegelapp/viewmodels/user_viewmodel.dart';
import 'package:claudiskegelapp/views/screens/appointment_screen.dart';
import 'package:claudiskegelapp/views/screens/userprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/services/firebase_options.dart';
import '/styles/constants.dart';
import 'viewmodels/auth_viewmodel.dart';
import '/views/auth/firebase_auth_screen.dart';
import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode('de');
  runApp(const KegelApp());
}

class KegelApp extends StatelessWidget {
  const KegelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.lightGrey,
        ),
        initialRoute: Routes.root,
        routes: {
          Routes.root: (context) => const AuthScreen(),
          Routes.main: (context) => const HomeScreen(),
          Routes.userProfile: (context) => const UserProfileScreen(),
          Routes.calendar: (context) => const AppointmentScreen(),
        },
      ),
    );
  }
}