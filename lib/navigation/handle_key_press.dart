import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class HandleKeyPress {
  final ScrollController controller;
  HandleKeyPress(this.controller);

  bool onKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey != LogicalKeyboardKey.arrowLeft &&
        event.logicalKey != LogicalKeyboardKey.arrowRight) {
          return false;
      }

      final focusedChild = node.nearestScope.focusedChild;

      if (focusedChild == null) {
        return false;
      }

      double scrollTo;
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        node.focusInDirection(TraversalDirection.left);
        scrollTo = max(controller.offset - focusedChild.size.width - 20, 0);
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        node.focusInDirection(TraversalDirection.right);
        scrollTo = max(controller.offset + focusedChild.size.width + 20, 0);
      }
      controller.animateTo(scrollTo, duration: new Duration(milliseconds: 300), curve: Curves.ease);
      return true;
    }
    return false;
  }
}