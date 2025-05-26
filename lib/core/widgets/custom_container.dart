import 'package:flutter/material.dart';
import '../../../utils/web_engine.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  late final WebEngine engine;

  @override
  void initState() {
    super.initState();
    engine = WebEngine();
  }

  @override
  Widget build(BuildContext context) {
    return engine.build(context);
  }
}