import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyRenderBox extends SingleChildRenderObjectWidget {
  const MyRenderBox({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyRenderBoxProxy();
  }
}

class MyRenderBoxProxy extends RenderProxyBox {
  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return false;
  }
}
