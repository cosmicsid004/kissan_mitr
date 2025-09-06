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
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.cardColor(),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Card(
                    color: colors.cardColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Farm Overview",
                            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("🌾 Land Area:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("2 Hectares"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("🌱 Crop Planted:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("Wheat"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("📍 Location:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("Punjab, India"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("🌤 Weather Today:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("28°C, Sunny"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("💧 Soil Moisture:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("45%"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("🚜 Last Activity:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                              Text("Fertilizer added 3 days ago"),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Card(
                color: colors.cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Tasks",
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      // Task 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🧴 Fertilizer application",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                          Text("Due in 2 days", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      // Task 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🌾 Next Irrigation",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                          Text("Sept 8", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                      // Task 3 (example)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🌿 Pesticide spray",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                          Text("Sept 12"),
                        ],
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
