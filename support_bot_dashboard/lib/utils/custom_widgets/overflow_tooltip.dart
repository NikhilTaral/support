import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

Widget overflowTooltipText(String text, TextStyle? style) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final span = TextSpan(text: text, style: style);
      final tp = TextPainter(
        text: span,
        maxLines: 1,
        textDirection: ui.TextDirection.ltr,
      );

      tp.layout(maxWidth: constraints.maxWidth);

      final isOverflowing = tp.didExceedMaxLines;
      return isOverflowing
          ? CustomToolTip(
              messageTextOverflow: TextOverflow.visible,
              width: UIHelpers.screenWidth(context) * 0.3,
              isMobile: false,
              message: text,
              prefersAbove: false,
              messagePadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Text(
                text,
                style: style,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            )
          : Text(
              text,
              style: style,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            );
    },
  );
}
