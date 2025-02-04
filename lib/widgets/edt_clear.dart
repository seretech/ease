import 'package:flutter/material.dart';

import '../classes/main_class.dart';

class EdtClear extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final FocusNode focusNode;
  final TextEditingController textController;
  final TextInputType? textInputType;
  final String? hint;
  final int? max;
  final bool? auto;
  final bool? border;

  const EdtClear(
      {super.key,
        this.onChanged,
        required this.focusNode,
        required this.textController,
        this.textInputType,
        this.hint,
        this.max,
        this.auto,
        this.border
      });

  @override
  State<EdtClear> createState() => _State();
}

class _State extends State<EdtClear> {


  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.textController,
      focusNode: widget.focusNode,
      keyboardType: widget.textInputType ?? TextInputType.text,
      maxLength: widget.max ?? 256,
      style: MainClass.txtStyle(),
      cursorColor: Colors.black,
      maxLines: 1,
      autocorrect: false,
      autofocus: widget.auto ?? false,
      enableSuggestions: true,
      onTapOutside: (v){
        widget.focusNode.unfocus();
      },
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border:  InputBorder.none,
      ),
    );
  }
}