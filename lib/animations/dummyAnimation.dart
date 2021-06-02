import 'package:flutter/material.dart';

class FadeTransitionDemo extends StatefulWidget {
  _FadeTransitionDemoState createState() => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<FadeTransitionDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late final Animation<Offset> _offsetAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(_controller);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Flutter FadeTransition Widget Demo',
        ),
      ),
      body: Center(
          child: SlideTransition(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter Dev's",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/images/login.png"),
            ],
          ),
        ),
        position: _offsetAnimation,
      )),
    );
  }
}
