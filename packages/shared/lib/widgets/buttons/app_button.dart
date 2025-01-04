import 'package:shared/imports.dart';

/// standart button
class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isVibrate = false,
    this.height = 44,
    this.width = 160,
    this.textColor,
    this.color = AppColors.primary,
    this.fontSize = 16,
    this.borderRadius = 10,
  }) : super(key: key);

  final Function() onPressed;
  final String title;
  final double height;
  final double width;
  final bool isDisabled;
  final bool isVibrate;
  final Color? textColor;
  final Color color;
  final double fontSize;
  final double borderRadius;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isDisabled) {
          widget.onPressed();
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              child: Center(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: widget.fontSize,
                        color: widget.textColor ?? Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
