import 'package:flutter/material.dart';
import 'package:realtime_project/core/di/di.dart';
import 'package:realtime_project/core/routing/router.dart';
import 'package:realtime_project/src/employee_list/presentation/views/emp/emp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: generateRoute,
        home: const EmployeHomeScreen());
  }
}
