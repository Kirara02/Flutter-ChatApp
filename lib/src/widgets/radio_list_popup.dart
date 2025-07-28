import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../utils/extensions/custom_extensions.dart';
import 'pop_button.dart';

class RadioListPopup<T> extends StatelessWidget {
  const RadioListPopup({
    super.key,
    required this.title,
    required this.optionList,
    required this.value,
    required this.onChange,
    this.getOptionTitle,
    this.getOptionSubtitle,
  });

  final String title;
  final List<T> optionList;
  final T value;
  final ValueChanged<T> onChange;
  final String Function(T)? getOptionTitle;
  final String Function(T)? getOptionSubtitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: KEdgeInsets.v8.size,
      title: Text(title),
      content: RadioList(
        optionList: optionList,
        value: value,
        onChange: onChange,
        getTitle: getOptionTitle,
        getSubtitle: getOptionSubtitle,
      ),
      actions: const [PopButton()],
    );
  }
}

class RadioList<T> extends StatelessWidget {
  const RadioList({
    super.key,
    required this.optionList,
    required this.value,
    required this.onChange,
    this.getTitle,
    this.getSubtitle,
  });

  final List<T> optionList;
  final T value;
  final ValueChanged<T> onChange;
  final String Function(T)? getTitle;
  final String Function(T)? getSubtitle;

  Widget getRadioListTile(BuildContext context, T option) {
    return RadioListTile<T>(
      activeColor: TabBarThemeData().indicatorColor,
      title: Text(getTitle?.call(option) ?? option.toString()),
      subtitle: getSubtitle != null ? (Text(getSubtitle!(option))) : null,
      value: option,
      groupValue: value,
      onChanged: (value) {
        if (value != null) {
          onChange(value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.height * .7),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              optionList.map((e) => getRadioListTile(context, e)).toList(),
        ),
      ),
    );
  }
}
