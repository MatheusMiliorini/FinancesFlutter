import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyInputField extends StatefulWidget {
  final ValueChanged<String> onChange;
  final String label;

  const CurrencyInputField(
      {super.key, required this.onChange, required this.label});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyInputFieldState createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  final TextEditingController _controller = TextEditingController(text: "0.00");

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateValue);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateValue);
    _controller.dispose();
    super.dispose();
  }

  void _updateValue() {
    final text = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isNotEmpty) {
      final double value = double.parse(text) / 100;
      _controller.value = _controller.value.copyWith(
        text: value.toStringAsFixed(2),
        selection: TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        ),
      );
    } else {
      _controller.value = _controller.value.copyWith(
        text: "0.00",
        selection: TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        ),
      );
    }
    widget.onChange(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the ${widget.label.toLowerCase()}';
        }
        return null;
      },
    );
  }
}
