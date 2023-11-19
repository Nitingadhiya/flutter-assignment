import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment/address/address_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: const [Locale('en')],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // backgroundColor: Color(0XFF5408AD),
        appBarTheme: AppBarTheme(
          color: Color(0XFF5408AD),
        ),
      ),
      home: const HomePage(title: 'Flutter Gigabank assignment'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _navigateToAddAddressScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddressScreen(title: "Registered Address"),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color(0XFF5408AD),
                elevation: 5,
              ),
              onPressed: _navigateToAddAddressScreen,
              child: const Text('Add address', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
