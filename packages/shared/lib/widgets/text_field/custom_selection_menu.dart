import 'package:shared/imports.dart';
import 'package:flutter/cupertino.dart';

class CustomSelectionMenu extends StatelessWidget {
  const CustomSelectionMenu({
    super.key,
    required this.editableTextState,
  });

  final EditableTextState editableTextState;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextSelectionToolbar(
      anchors: editableTextState.contextMenuAnchors,
      children: editableTextState.contextMenuButtonItems.map(
        (ContextMenuButtonItem buttonItem) {
          return CupertinoButton(
            borderRadius: null,
            color: AppColors.background,
            disabledColor: AppColors.background,
            onPressed: buttonItem.onPressed,
            padding: const EdgeInsets.all(10.0),
            pressedOpacity: 0.9,
            child: SizedBox(
              width: 200.0,
              child: Text(
                CupertinoTextSelectionToolbarButton.getButtonLabel(
                  context,
                  buttonItem,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
