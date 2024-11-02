import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crazy Animation Thingy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    RxBool buttonClicked = false.obs;
    var size = Get.size;

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(21.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Expand/Ripples button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 355),
                  top: buttonClicked.value ? size.width * 0.21 : 0,
                  left: buttonClicked.value ? size.width * 0.37 : 0,
                  child: GestureDetector(
                    onTap: () => buttonClicked.toggle(),
                    child: Text(
                      buttonClicked.value ? "Ripples" : "Expand",
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // First Circle (bottom)
                _buildAnimatedCircle(
                  size: size,
                  clicked: buttonClicked.value,
                  topPosition: buttonClicked.value
                      ? size.width * 0.40
                      : size.width * 0.40,
                  circleSize: buttonClicked.value
                      ? size.width * 0.8
                      : size.width * 0.46,
                  color: Colors.grey,
                  child: buttonClicked.value
                      ? _buildCircleContent(size)
                      : const SizedBox(),
                ),
                // Second Circle (middle)
                _buildAnimatedCircle(
                  size: size,
                  clicked: buttonClicked.value,
                  topPosition: buttonClicked.value
                      ? size.width * 1.25
                      : size.width * 0.45,
                  rightPosition: buttonClicked.value ? 0 : size.width * 0.27,
                  circleSize: buttonClicked.value
                      ? size.width * 0.2
                      : size.width * 0.38,
                  color: const Color.fromARGB(255, 53, 53, 53),
                  child: buttonClicked.value
                      ? Icon(Icons.rotate_left,
                          size: size.width * 0.1, color: Colors.white)
                      : const SizedBox(),
                  onTap: () => buttonClicked.value = false,
                ),
                // Third Circle (top)
                _buildAnimatedCircle(
                  size: size,
                  clicked: buttonClicked.value,
                  topPosition: buttonClicked.value ? 0 : size.width * 0.495,
                  circleSize:
                      buttonClicked.value ? size.width * 0.2 : size.width * 0.3,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCircle({
    required Size size,
    required bool clicked,
    required double topPosition,
    double? rightPosition,
    required double circleSize,
    required Color color,
    Widget child = const SizedBox(),
    VoidCallback? onTap,
  }) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 355),
      curve: Curves.easeOut,
      top: topPosition,
      right: rightPosition,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 355),
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildCircleContent(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconRow(size, Icons.shopping_cart, "Items in Cart"),
        _buildIconRow(size, Icons.history_toggle_off, "Purchase History"),
        _buildIconRow(size, Icons.settings_outlined, "App Settings"),
      ],
    );
  }

  Widget _buildIconRow(Size size, IconData icon, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: size.width * 0.06, color: Colors.white),
        Text(
          " $label",
          style: TextStyle(fontSize: size.width * 0.05, color: Colors.white),
        ),
      ],
    );
  }
}
