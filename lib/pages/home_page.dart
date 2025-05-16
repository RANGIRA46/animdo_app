import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double _buttonRadius = 100;

  final Tween<double> _backgroundScale = Tween<double>(
    begin: 0.5,
    end: 1.2,
  ); // Scale from 0.5 to 1.2
  late AnimationController _controller; // Animation controller
  late Animation<double>
      _backgroundAnimation; // Animation for the background scale
  late AnimationController
      _starIconAnimationController; // Animation controller for star icon

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for background
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation using the Tween and the controller, with a curve
    _backgroundAnimation = _backgroundScale.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth easing curve for the animation
      ),
    );

    // Start the background animation
    _controller.forward();

    // Initialize the animation controller for the star icon
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _starIconAnimationController.repeat();
  }

  @override
  void dispose() {
    // Dispose the animation controllers
    _controller.dispose();
    _starIconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _backgroundAnimation.value, // Apply the scale animation
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _pageBackground(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [_centeredCircularAnimationButton(), _starIcon()],
                ),
              ],
            ),
          );
        },
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

            // Restart the background animation on tap
            _controller.reset();
            _controller.forward();
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut, // Add a curve for the button animation
          width: _buttonRadius,
          height: _buttonRadius, // Ensure it's a perfect circle
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: const Center(
            child: Text('Basic', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starIconAnimationController.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconAnimationController.value * 2 * pi, // Rotate the star icon
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}