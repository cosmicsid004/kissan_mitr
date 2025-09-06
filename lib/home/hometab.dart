import 'package:flutter/material.dart';
import 'package:kissan_mitr/common.dart';
import 'package:lottie/lottie.dart';

class homeTab extends StatefulWidget {
  const homeTab({super.key});

  @override
  State<homeTab> createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Container(
                width: 250,
                height: 250,
                alignment: Alignment.topCenter,
                child: Lottie.asset('assets/homeIcon/homeicon.json'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: colors.cardColor(),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
