import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projet_chevaux/pages/horse_form.dart';
import 'package:projet_chevaux/pages/horseslist.dart';
import 'package:projet_chevaux/pages/userslist.dart';
import '../pages/start.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../database/database.dart';
import '../pages/home.dart';
import '../pages/meeting_form.dart';
import '../pages/userprofile.dart';
import '../pages/lesson_form.dart';
import '../pages/tournament_form.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/start': (context) => StartPage(),
        '/home': (context) => HomePage(),
        '/userprofile': (context) => UserProfilePage(),
        '/LessonFormPage': (context) => LessonFormPage(),
        '/TournamentPage': (context) => TournamentPage(),
        '/userprofile': (context) => UserProfilePage(),
        '/horse_form': (context) => HorseFormPage(),
        '/horseslist': (context) => HorsesList(),
        '/MeetingFormPage': (context) => MeetingFormPage(),
        '/UsersList': (context) => UsersList(),

      },
      debugShowCheckedModeBanner: false,
      title: 'Horse race manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      home: const MyHomePage(title: 'COURSE MANAGER DE OUF'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  StartPage();
  }
}
