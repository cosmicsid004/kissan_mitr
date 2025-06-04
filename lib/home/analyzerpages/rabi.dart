import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class rabiPage extends StatefulWidget {
  const rabiPage({super.key});

  @override
  State<rabiPage> createState() => _rabiPageState();
}

class _rabiPageState extends State<rabiPage> {

  File ? _selectedImage;
  var _recognitions;
  var v = "";

  String ? label;
  int ? confidence;

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions.toString();
      for (var recog in _recognitions) {
        label = recog['label'];
        confidence = (recog['confidence'] * 100).toInt();
      }
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
    });
    print("//////////////////////////////////////////////////");
    print(_recognitions);
    // print(dataList);
    print("//////////////////////////////////////////////////");
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    print(label);
    print(confidence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(child: _selectedImage != null ? Image.file(_selectedImage!) : Text(""), height: 800, width: 500,),
            ),
            Text("The image is of a ${label.toString().substring(2)}",
              style:TextStyle(
                  fontSize: 25
              ),
            ),
            Text("Confidence Level : ${confidence.toString()}%",
              style: TextStyle(
                  fontSize: 20
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9D4AA),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: MaterialButton(
                    child: const Text(
                      "Pick image from Gallery",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                  ),
                ),

                const SizedBox(width: 20,),

                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFB9D4AA),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: MaterialButton(
                    child: const Text(
                      "Click image from Camera",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                    onPressed: () {
                      _clickImageFromCamera();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
    detectimage(_selectedImage!);
  }

  Future _clickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
    detectimage(_selectedImage!);
  }
}
