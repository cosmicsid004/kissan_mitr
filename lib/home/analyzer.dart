import 'package:flutter/material.dart';
import 'package:kissan_mitr/common.dart';
import 'package:kissan_mitr/home/analyzerpages/kharif.dart';
import 'package:kissan_mitr/home/analyzerpages/rabi.dart';
import 'package:kissan_mitr/home/analyzerpages/zaid.dart';
import 'package:lottie/lottie.dart';

class analyzer extends StatefulWidget {
  const analyzer({super.key});

  @override
  State<analyzer> createState() => _analyzerState();
}

class _analyzerState extends State<analyzer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 250,
                    height: 250,
                    child: Lottie.asset('assets/analyzerIcon/analyzer.json')
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rabiPage()
                        ),
                    );
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: colors.cardColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                              height: 100,
                              child: Image.asset('assets/analyzerIcon/wheat-icon.png')
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(color: colors.buttonColor(), borderRadius: BorderRadius.all(Radius.circular(20))),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  style: TextStyle(
                                      fontSize: 40,
                                    fontWeight: FontWeight.bold
                                  ),
                                    'Rabi Crop'
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kharifPage())
                    );
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: colors.cardColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                child: Image.asset('assets/analyzerIcon/paddy.png')
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(color: colors.buttonColor(), borderRadius: BorderRadius.all(Radius.circular(20))),
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                      style: TextStyle(
                                          fontSize: 40,
                                        fontWeight: FontWeight.bold
                                      ),
                                      'Kharif Crop'
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => zaidPage())
                    );
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: colors.cardColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                child: Image.asset('assets/analyzerIcon/sugarcane.png')
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(color: colors.buttonColor(), borderRadius: BorderRadius.all(Radius.circular(20))),
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                      style: TextStyle(
                                          fontSize: 40,
                                        fontWeight: FontWeight.bold
                                      ),
                                      'Zaid Crop'
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
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
