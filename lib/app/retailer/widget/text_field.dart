import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

typedef OnChange = Function(PhoneNumber);

class MobileTextfield extends StatelessWidget {
  final TextEditingController phoneTextEditingController;
  final OnChange onChange;
  // final _UsNumberTextInputFormatter _phoneNumberFormatter =
  //     _UsNumberTextInputFormatter();

  MobileTextfield(
      {Key key,
      @required this.phoneTextEditingController,
      @required this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: IntlPhoneField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          focusColor: AppColor.base,
          border: InputBorder.none,
        ),
        // countryCodeTextColor: Colors.black,
        inputFormatters: <TextInputFormatter>[
          // LengthLimitingTextInputFormatter(13),
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
          // _phoneNumberFormatter,
        ],
        controller: phoneTextEditingController,
        style: TextStyle(
          color: Colors.black,
        ),
        initialCountryCode: 'TZ',
        onChanged: onChange,
      ),
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
// class _UsNumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final int newTextLength = newValue.text.length;
//     int selectionIndex = newValue.selection.end;
//     int usedSubstringIndex = 0;
//     final StringBuffer newText = StringBuffer();
//     if (newTextLength >= 1) {
//       newText.write('(');
//       if (newValue.selection.end >= 1) selectionIndex++;
//     }
//     if (newTextLength >= 4) {
//       newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
//       if (newValue.selection.end >= 3) selectionIndex += 2;
//     }
//     if (newTextLength >= 7) {
//       newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
//       if (newValue.selection.end >= 6) selectionIndex++;
//     }
//     if (newTextLength >= 11) {
//       newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
//       if (newValue.selection.end >= 10) selectionIndex++;
//     }
//     // Dump the rest.
//     if (newTextLength >= usedSubstringIndex)
//       newText.write(newValue.text.substring(usedSubstringIndex));
//     return TextEditingValue(
//       text: newText.toString(),
//       selection: TextSelection.collapsed(offset: selectionIndex),
//     );
//   }
// }
