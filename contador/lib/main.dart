import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const new({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unitecnarapp'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$counter', style: TextStyle(fontSize: 160, fontWeight: FontWeight.w100),),
              Text(counter==1 ? 'Click' : 'Clicks', style:  TextStyle(fontSize: 25),)
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              FloatingActionButton(
                child: Icon(Icons.plus_one),
                onPressed: (){
                  setState(() {
                    counter++;
                  });
                }
              ),
                SizedBox(height: 20,),
                FloatingActionButton(
                child: Icon(Icons.exposure_minus_1),
                onPressed: (){
                  setState(() {
                    if (counter==0) return;
                    counter--;
                  });
                }
              ),
                SizedBox(height: 20,),
                FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: (){
                  setState(() {
                    counter=0;
                  });
                }
                
              ),
          ],
        ),
      ),
    );
  }
}