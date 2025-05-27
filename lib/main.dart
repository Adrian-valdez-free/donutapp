import 'package:donutapp/pages/Login.dart';
import 'package:donutapp/pages/reiniciarPass.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialPage = const LogIn();

  @override
  void initState() {
    super.initState();
    _handleDynamicLinks();
  }

  void _handleDynamicLinks() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      _processLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      _processLink(deepLink);
    }).onError((error) {
      print('Error al recibir el link dinámico: $error');
    });
  }

 void _processLink(Uri link) {
  final mode = link.queryParameters['mode'];
  final oobCode = link.queryParameters['oobCode'];

  if (mode == 'resetPassword' && oobCode != null) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(oobCode: oobCode),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Flutter Demo',
  navigatorKey: navigatorKey, 
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.pink,
    ),
  ),
  home: const LogIn(), // <== SIEMPRE inicias aquí
);

  }
}
