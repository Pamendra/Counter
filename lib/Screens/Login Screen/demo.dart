import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<MyWidget> {
//   int _numberPickerValue = 0;
//   FocusNode _focusNode1 = FocusNode();
//   FocusNode _focusNode2 = FocusNode();
//   TextEditingController _textEditingController1 =
//   TextEditingController(text: '');
//   TextEditingController _textEditingController2 =
//   TextEditingController(text: '');
//
//   @override
//   void dispose() {
//     _focusNode1.dispose();
//     _focusNode2.dispose();
//     _textEditingController1.dispose();
//     _textEditingController2.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(50),
//         child: Column(
//           children: [
//             TextFormField(
//               focusNode: _focusNode1,
//               controller: _textEditingController1,
//               onTap: () {
//                 setState(() {
//                   _numberPickerValue = int.tryParse(_textEditingController1.text) ?? 0;
//                 });
//                 _textEditingController1.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController1.text.length));
//               },
//               onChanged: (value) {
//                 setState(() {
//                   _numberPickerValue = int.tryParse(value) ?? 0;
//                 });
//               },
//             ),
//             TextFormField(
//               focusNode: _focusNode2,
//               controller: _textEditingController2,
//               onTap: () {
//                 setState(() {
//                   _numberPickerValue = int.tryParse(_textEditingController2.text) ?? 0;
//                 });
//                 _textEditingController2.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController2.text.length));
//               },
//               onChanged: (value) {
//                 setState(() {
//                   _numberPickerValue = int.tryParse(value) ?? 0;
//                 });
//               },
//             ),
//             NumberPicker(
//               value: _numberPickerValue,
//               minValue: 0,
//               maxValue: 100,
//               onChanged: (value) {
//                 setState(() {
//                   _numberPickerValue = value;
//                 });
//                 if (_focusNode1.hasFocus) {
//                   _textEditingController1.text = value.toString();
//                 } else if (_focusNode2.hasFocus) {
//                   _textEditingController2.text = value.toString();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _numberPickerValue = 0;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              onTap: () {
                setState(() {
                  _numberPickerValue =
                      int.tryParse(_textEditingController.text) ?? 0;
                  _textEditingController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _textEditingController.text.length));
                });
              },
              onChanged: (value) {
                setState(() {
                  _numberPickerValue = int.tryParse(value) ?? 0;
                });
              },
            ),
            NumberPicker(
              value: _numberPickerValue,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) {
                setState(() {
                  _numberPickerValue = value;
                  _textEditingController.text = value.toString();
                  _textEditingController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _textEditingController.text.length));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
