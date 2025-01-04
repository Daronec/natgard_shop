import 'package:rxdart/rxdart.dart';

import 'package:shared/imports.dart';

import 'helpers/constants.dart';
import 'helpers/switch_input_format.dart';
import 'helpers/switch_keyboard_type.dart';
import 'helpers/switch_validation.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.textController,
    this.focusNode,
    this.type = TextFieldType.text,
    this.hintText,
    this.subLabelText,
    this.labelText,
    this.color,
    this.onChange,
    this.onComplete,
    this.onTap,
    this.formKey,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = true,
    this.enableFocus = false,
    this.suffix,
    this.prefix,
    this.prefixConstraints,
    this.suffixConstraints,
    this.width,
    this.colorBorder,
    this.textLength,
    this.textInputFormatter,
    this.obscureText,
    this.autofillHints,
    this.textInputAction,
    this.height = 56,
    this.minHeight = 45,
    this.showSelectCountry,
    this.isRequired = false,
    this.isLink = false,
    this.contentPadding,
    this.hintStyle,
    this.subLabelStyle,
    this.labelStyle,
    this.suffixText,
    this.label,
    this.isDense = false,
    this.showBorder = false,
    this.paddingSuffix,
  }) : super(key: key);

  final TextEditingController textController;
  final FocusNode? focusNode;
  final TextFieldType type;
  final String? hintText;
  final String? labelText;
  final String? subLabelText;
  final Color? color;
  final Function(String)? onChange;
  final Function()? onComplete;
  final Function()? onTap;
  final GlobalKey<FormState>? formKey;
  final bool readOnly;
  final bool enableFocus;
  final int maxLines;
  final int minLines;
  final Widget? suffix;
  final Widget? label;
  final String? suffixText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final double? width;
  final Color? colorBorder;
  final int? textLength;
  final TextInputFormatter? textInputFormatter;
  final bool? obscureText;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;
  final double height;
  final double minHeight;
  final bool? showSelectCountry;
  final bool isRequired;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? subLabelStyle;
  final bool isLink;
  final bool isDense;
  final bool showBorder;
  final EdgeInsets? paddingSuffix;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  MaskTextInputFormatter? _mask;
  bool isHashtag = false;
  Paint paint = Paint()
    ..shader = LinearGradient(
      colors: gradientColors2,
    ).createShader(
      const Rect.fromLTWH(
        0,
        0.0,
        100,
        20.0,
      ),
    );

  final _errorText = BehaviorSubject.seeded('');

  Stream<String> get getErrorText => _errorText.stream;

  void addMaskToText() {
    _mask = switchInputFormat(widget.type);
    if (_mask != null) {
      _mask!.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
          text: widget.textController.text,
        ),
      );
      widget.textController.text = _mask!.getMaskedText();
    }
  }

  @override
  void initState() {
    addMaskToText();
    widget.textController.addListener(() {
      if (widget.textController.text.isNotEmpty) {
        isHashtag = widget.textController.text[0] == '#';
        if (isHashtag) {
          paint = Paint()
            ..shader = LinearGradient(
              colors: gradientColors2,
            ).createShader(
              Rect.fromLTWH(
                0,
                0.0,
                widget.textController.text.length * 9,
                20.0,
              ),
            );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _mask = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                widget.labelText!,
                style: widget.labelStyle ??
                    const TextStyle(
                      color: AppColors.darkGrey,
                    ),
              ),
            ),
          if (widget.label != null) widget.label!,
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Form(
                  key: widget.formKey,
                  child: TextFormField(
                    enabled: true,
                    cursorColor: AppColors.grey,
                    enableIMEPersonalizedLearning: true,
                    textAlignVertical: widget.prefix != null || widget.suffix != null ? TextAlignVertical.top : null,
                    inputFormatters: [
                      if (widget.type == TextFieldType.name) Format.nameFormat,
                      if (_mask != null) _mask!,
                      if (widget.textLength != null) LengthLimitingTextInputFormatter(widget.textLength!),
                      if (widget.textInputFormatter != null) widget.textInputFormatter!,
                    ],
                    autofillHints: widget.autofillHints,
                    textInputAction: widget.textInputAction ??
                        (defaultTargetPlatform == TargetPlatform.iOS ? TextInputAction.done : TextInputAction.none),
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    controller: widget.textController,
                    focusNode: widget.focusNode,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: isHashtag
                          ? null
                          : widget.isLink
                              ? AppColors.blue
                              : AppColors.text,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.transparent,
                      decorationThickness: 0,
                      height: 1.21,
                      foreground: isHashtag ? paint : null,
                    ),
                    readOnly: !widget.readOnly,
                    autofocus: widget.enableFocus,
                    keyboardType: switchInputType(widget.type),
                    onEditingComplete: widget.onComplete,
                    obscureText: widget.obscureText ?? false,
                    onChanged: (text) {
                      setState(() {
                        if (widget.onChange != null) {
                          widget.onChange!(text);
                        }
                      });
                    },
                    validator: (value) {
                      final err = switchValidation(
                        context,
                        widget.type,
                        value!,
                      );
                      _errorText.add(err ?? '');
                      setState(() {});
                      return err;
                    },
                    textCapitalization: (widget.type == TextFieldType.name || widget.type == TextFieldType.text)
                        ? TextCapitalization.sentences
                        : TextCapitalization.none,
                    decoration: InputDecoration(
                      contentPadding: widget.contentPadding ?? const EdgeInsets.all(6),
                      fillColor: widget.color,
                      filled: true,
                      constraints: BoxConstraints(
                        maxHeight: widget.height,
                        minHeight: widget.minHeight,
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 0,
                        height: 0,
                      ),
                      hintText: widget.hintText,
                      hintStyle: widget.hintStyle ??
                          const TextStyle(
                            fontSize: 18,
                            color: AppColors.grey,
                          ),
                      isDense: widget.isDense,
                      hoverColor: Colors.transparent,
                      prefixIcon: widget.prefix,
                      prefixIconConstraints: widget.prefixConstraints ??
                          const BoxConstraints(
                            maxHeight: 32,
                            maxWidth: 32,
                          ),
                      suffixText: widget.suffixText,
                      suffixIconConstraints: widget.suffixConstraints ??
                          BoxConstraints(
                            maxHeight: 28,
                            maxWidth: getTextWidth(
                              widget.suffixText ?? '',
                              theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                              context,
                            ).toDouble(),
                          ),
                      suffixStyle: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onFieldSubmitted: (s) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              if (widget.suffix != null)
                Padding(
                  padding: widget.paddingSuffix ??
                      const EdgeInsets.only(
                        left: 9,
                        right: 8,
                        top: 10,
                      ),
                  child: widget.suffix!,
                ),
            ],
          ),
          if (widget.showBorder)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.grey,
              ),
            ),
          if (widget.subLabelText != null)
            Text(
              widget.subLabelText!,
              style: widget.subLabelStyle ??
                  const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
            ),
          StreamBuilder<String>(
            initialData: '',
            stream: getErrorText,
            builder: (ctx, error) {
              return error.data!.isNotEmpty
                  ? Text(
                      error.data!,
                      style: widget.labelStyle ??
                          const TextStyle(
                            color: AppColors.error,
                          ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
