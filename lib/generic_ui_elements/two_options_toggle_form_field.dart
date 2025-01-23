import 'package:flutter/material.dart';

class TwoOptionsToggleFormField extends FormField<bool> {
  TwoOptionsToggleFormField({
    super.key,
    String? firstOption,
    String? secondOption,
    super.onSaved,
    super.validator,
    super.initialValue,
    Icon? icon,
  }) : super(
            builder: (FormFieldState<bool> state) {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (icon != null)
                    SizedBox(
                      width: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: icon,
                      ),
                    ),
                  if (firstOption != null)
                    Text(
                      firstOption,
                      style: state.value == false
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : null,
                    ),
                  Switch(
                    value: state.value ?? false,
                    onChanged: state.didChange,
                  ),
                  if (secondOption != null)
                    Text(
                      secondOption,
                      style: state.value == true
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : null,
                    ),
                ],
              );
            });
}
