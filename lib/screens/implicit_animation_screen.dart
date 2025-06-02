import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Implicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*TweenAnimationBuilder(
              tween:
                  _visible
                      ? ColorTween(begin: Colors.blue, end: Colors.teal)
                      : ColorTween(begin: Colors.teal, end: Colors.blue),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return Image.network(
                  'https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png',
                  color: value,
                  colorBlendMode: BlendMode.colorBurn,
                );
              },
              curve: Curves.easeInOut,
            ),*/
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.elasticInOut,
              width: _visible ? size.width * 0.7 : size.width * 0.8,
              height: _visible ? size.width * 0.7 : size.width * 0.8,
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: _visible ? Colors.red : Colors.amber,
                borderRadius: BorderRadius.circular(_visible ? 300 : 0),
              ),
            ),
            /*AnimatedAlign(
              duration: Duration(seconds: 2),
              alignment: _visible ? Alignment.topLeft : Alignment.topRight,
              child: AnimatedOpacity(
                duration: Duration(seconds: 2),
                opacity: _visible ? 1 : 0,
                child: Container(
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                  color: Colors.amber,
                  // decoration: BoxDecoration(),
                ),
              ),
            ),*/
            SizedBox(height: 50),
            ElevatedButton(onPressed: _trigger, child: Text('Go!')),
          ],
        ),
      ),
    );
  }
}
