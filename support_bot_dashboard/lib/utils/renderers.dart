import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/applications_pluto_helper_methods.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Renderers {
  static TextStyle frozenStyle(
      PlutoColumnRendererContext rendererContext, TextStyle textStyle) {
    if (rendererContext.cell.column.frozen == PlutoColumnFrozen.start ||
        rendererContext.cell.column.frozen == PlutoColumnFrozen.end) {
      // return textStyle.copyWith(fontWeight: FontWeight.w700);
    }
    return textStyle;
  }

  static Widget textRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final String text = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small
            .copyWith(fontSize: 14, color: SupportBotColors.gray.shade800));

    return Text(
      text,
      textAlign: TextAlign.start,
      style: textStyle,
    );
  }

  static Widget scoreTextRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final num value = rendererContext.cell.value ?? "";
    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small.copyWith(
            fontSize: 14,
            color:
                value > 5 ? const Color(0xFF11972C) : const Color(0xFFFD0101)));

    return Text(
      "$value/10",
      style: textStyle,
    );
  }

  static Widget applicationTextStatusRenderer(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final dynamic status = rendererContext.cell.value;
    final String displayText = (status == true)
        ? "Validate"
        : (status == false)
            ? "Not Validate"
            : "N/A";

    textStyle ??= frozenStyle(
        rendererContext,
        SupportBotTextstyle.small.copyWith(
          fontSize: 14,
          color: ApplicationsPlutoHelperMethods.getTextColorFromStatus(
            status: displayText,
          ),
        ));

    return Text(
      displayText,
      style: textStyle,
    );
  }

  static Widget actionButtonRenderer(
    PlutoColumnRendererContext rendererContext, {
    required BuildContext context,
    void Function(String?)? onDelete,
  }) {
    final actionData =
        rendererContext.row.cells["Action"]?.value as Map<String, dynamic>? ??
            {};
    return Align(
      alignment: Alignment.topLeft,
      child: PopupMenuTheme(
          data: const PopupMenuThemeData(
            color: SupportBotColors.white,
          ),
          child: PopupMenuButton<String>(
            tooltip: "",
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: const Icon(
                Icons.more_vert_rounded,
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: "share",
                child: Row(
                  children: [
                    const Icon(
                      SupportBotIcons.share,
                      size: 14,
                    ),
                    UIHelpers.horizontalSpaceTiny,
                    Text(
                      'Share',
                      style: SupportBotTextstyle.small.copyWith(
                          color: SupportBotColors.gray.shade800,
                          // fontFamily: FontFamily.poppinsRegular,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: "edit",
                onTap: () {
                  // String? jobUId = actionData['jobUId'];

                  // context.go("/edit-jobPost/$jobUId");
                },
                child: Row(
                  children: [
                    const Icon(
                      SupportBotIcons.edit,
                      size: 14,
                    ),
                    UIHelpers.horizontalSpaceTiny,
                    Text("Edit",
                        style: SupportBotTextstyle.small.copyWith(
                            color: SupportBotColors.gray.shade800,
                            // fontFamily: FontFamily.poppinsRegular,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  static Widget tooltip(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final cellValue = rendererContext.cell.value;

    return SingleChildScrollView(
      child: MouseRegion(
        onEnter: (_) {},
        child: SizedBox(
          width: 20,
          child: SingleChildScrollView(
            child: Tooltip(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              message: cellValue.toString(),
              verticalOffset: 2,
              preferBelow: false,
              child: Container(
                width: 2,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text(
                  cellValue.toString(),
                  style: const TextStyle(
                    color: SupportBotColors.disablePrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  static Widget validationDropDown(
    PlutoColumnRendererContext rendererContext, {
    TextStyle? textStyle,
  }) {
    final cellValue = rendererContext.cell.value;

    return SingleChildScrollView(
      child: MouseRegion(
        onEnter: (_) {},
        child: SizedBox(
          width: 20,
          child: SingleChildScrollView(
            child: Tooltip(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              message: cellValue.toString(),
              verticalOffset: 2,
              preferBelow: false,
              child: Container(
                width: 2,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text(
                  cellValue.toString(),
                  style: const TextStyle(
                    color: SupportBotColors.disablePrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
