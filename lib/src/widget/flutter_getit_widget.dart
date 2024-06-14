import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetItWidget extends StatefulWidget {
  const FlutterGetItWidget(ValueKey<String> key) : super(key: key);

  /// Getter for declaring bindings that will be initialized
  /// and discarded upon view initialization and disposal
  List<Bind> get bindings => [];

  /// Getter to inform which Page should be re-rendered upon loading
  WidgetBuilder get widget;

  @override
  State<FlutterGetItWidget> createState() => _FlutterGetItWidgetState();
}

class _FlutterGetItWidgetState extends State<FlutterGetItWidget> {
  late final String id;
  late final FlutterGetItContainerRegister containerRegister;

  @override
  void initState() {
    super.initState();
    id = widget.key.toString();
    containerRegister = Injector.get<FlutterGetItContainerRegister>()
      ..register(
        id,
        widget.bindings,
        withTag: true,
      )
      ..load(id);
  }

  @override
  Widget build(BuildContext context) {
    return widget.widget(context);
  }

  @override
  void dispose() async {
    await containerRegister.unRegister(id);
    super.dispose();
  }
}
