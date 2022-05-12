import 'dart:async';

import 'package:bivinnorokom/home_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override

  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                  top: 80,
                  left: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Bivinno Rokom',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Best deal with us',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  )),
              Positioned(
                  top: 65,
                  left: 20,
                  child: Container(
                    height: 80,
                    width: 4,
                    color: Colors.black,
                  )),
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Text('www.bivinnorokom.com.bd',textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
