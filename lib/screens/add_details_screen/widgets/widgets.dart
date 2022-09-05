  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField displayTextField(bool numberOnly,TextEditingController controller,String hintText) {
    return TextField(
      inputFormatters: numberOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.singleLineFormatter],
      keyboardType: numberOnly ? TextInputType.number: TextInputType.text,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide:
                BorderSide(width: 3, color: Colors.green.withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide(width: 3, color: Colors.green),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey)),
    );}