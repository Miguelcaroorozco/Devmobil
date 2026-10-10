import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyappState();
}

class _MyappState extends State<HomeScreen> {

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
              _CustomButton(icon: Icons.plus_one_outlined, onPressed: (){
                setState(() {
                  counter++;
                });
              },),
              _CustomButton(icon: Icons.exposure_minus_1_outlined, onPressed: (){
                setState(() {
                  if (counter==0) return;
                  counter --;
                });
              }
              ),
              _CustomButton(icon: Icons.refresh, onPressed: (){
                setState(() {
                  counter = 0;
                });
              }
                
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CustomButton({
    super.key,
    required this.icon,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color.fromARGB(255, 139, 249, 255),
      elevation: 5,
      onPressed: onPressed,
      child: Icon(icon)
    );
  }
}