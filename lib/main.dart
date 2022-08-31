import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constant.dart';
import 'features/admin/screen/admin_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'models/user.dart';
import 'provider/user_provider.dart';
import 'services/auth_service.dart';
import 'widgets/bottom_nav_bar.dart';
import 'route.dart';

main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        backgroundColor: GlobalVariable.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariable.secondaryColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: user.token.isNotEmpty
          ? user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}

// class Scaff extends StatelessWidget {
//   const Scaff({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: [
//               // Container(
//               //   color: Colors.cyan,
//               // child:
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                   ],
//                 ),
//               ),
//               // ),
//               // Container(
//               //   color: Colors.blue,
//               //   height: 200,
//               //   child: Image.asset('assets/images/mobiles.jpeg'),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
