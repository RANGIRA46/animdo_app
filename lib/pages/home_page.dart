import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double _buttonRadius = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [_pageBackground(), _centeredCircularAnimationButton()],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return Container(color: Colors.blue);
  }

  Widget _centeredCircularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Toggle between increasing and decreasing the radius
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          width: _buttonRadius,
          height: _buttonRadius, // Ensure it's a perfect circle
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: const Center(
            child: Text(
              'Basic',
              style: TextStyle(color: Colors.white),
            ),
        ),
      ),
    ),
    );
  }
}