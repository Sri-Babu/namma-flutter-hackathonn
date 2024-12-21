import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

import '../widgets/gradiant_text.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const GradientText(
          "Namma AI",
          style: TextStyle(fontWeight: FontWeight.bold),
          gradient: LinearGradient(colors: [
            orange,
            purple,
          ]),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                //get colors from hex
                Colors.white,
                flutterBlue,
              ]),
        ),
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/namma-flutter-logo.png"),
                    fit: BoxFit.cover),
              ),
              child: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width * 8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 16.0),
                      child: (GradientText(
                        "Hai, Let's speak in",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        gradient: LinearGradient(colors: [
                          orange,
                          purple,
                        ]),
                      )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: (GradientText(
                        "Thanglish",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        gradient: LinearGradient(colors: [
                          orange,
                          purple,
                        ]),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 16.0, bottom: 16.0),
                      child: (TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/chat');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: GradientText(
                              "Get In",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              gradient: LinearGradient(colors: [
                                orange,
                                purple,
                              ]),
                            ),
                          ))),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
