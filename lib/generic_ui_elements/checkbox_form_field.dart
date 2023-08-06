import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool? initialValue,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Checkbox(
                    value: state.value,
                    onChanged: state.didChange,
                  ),
                  if (title != null) title
                ],
              );
            });
}
