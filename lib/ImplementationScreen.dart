import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ImplementationScreen extends StatefulWidget {
  @override
  _ImplementationScreenState createState() => _ImplementationScreenState();
}

class _ImplementationScreenState extends State<ImplementationScreen> {
  File pickedImage;
  var result = '';
  bool isImageLoaded = false;

  pickImage()async{



    var temfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(temfile.path);
      isImageLoaded = true;



    }
    );
  }

  readTextFromImage()async{
    FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText detectText = await textRecognizer.processImage(firebaseVisionImage);

    for(TextBlock block in detectText.blocks){
      for(TextLine line in block.lines){
        for(TextElement element in line.elements){
          setState(() {
            result = result + ' '+ element.text;
            
          });
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:pickImage,
            color: Colors.white,
            icon: Icon(Icons.camera),
          )
        ],
        backgroundColor: Colors.blue,
        title: Text('Machine learning')
        ,
      )
      ,
      body: Column(
        children: [
          isImageLoaded ? Center(
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(pickedImage)
                      ,
                  fit: BoxFit.cover
                )
              ),
            ),
          ):Container(),
          Text(result),
          FloatingActionButton(
            onPressed: readTextFromImage,
            backgroundColor: Colors.blue,
            child: Text('detect text'),
          )
        ],
      ),
    );
  }
}
