import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.label,
    this.hintText,
    this.controller,
    this.focus = false,
    this.onChanged,
    Key? key,
    this.height,
    this.contentPadding,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
    this.required = false,
    this.emodjiText = false,
  }) : super(key: key);
  final String? label;
  final String? hintText;
  final double? height;
  final EdgeInsets? contentPadding;
  final bool focus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool required;
  final bool emodjiText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && required)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: theme.textTheme.headlineMedium,
                ),
                TextSpan(
                  text: ' *',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          )
        else if (label != null)
          Text(
            label!,
            style: theme.textTheme.headlineMedium,
          ),
        if (label != null) const SizedBox(height: 7),
        Container(
          height: height ?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: theme.colorScheme.onSecondary,
          ),
          child: TextFormField(
            enabled: enabled,
            autofocus: focus,
            controller: controller,
            cursorColor: theme.colorScheme.primary,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              isDense: true,
              hintText: hintText,
              hintStyle: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.secondary,
              ),
              border: InputBorder.none,
            ),
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
            onChanged: onChanged,
            onFieldSubmitted: (s) {
              FocusScope.of(context).unfocus();
            },
            inputFormatters: inputFormatters,
            onEditingComplete: () {
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && !focus) {
                currentFocus.unfocus();
              }
            },
          ),
        )
      ],
    );
  }
}

