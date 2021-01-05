import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/ImplementationScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<String> itemList = [
    'Detect Text',
    'Detect Face'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),
          backgroundColor: Colors.white,
        ),
        body:ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Text(itemList[index]),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ImplementationScreen()));
                },
              ),
            );
          },



        )


      )
    );
  }
}
