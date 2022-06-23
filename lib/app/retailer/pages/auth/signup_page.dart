import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/pages/auth/otp_page.dart';
import 'package:uza_sales/app/retailer/provider/auth_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/text_field.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _phone;
  PhoneNumber number = PhoneNumber(isoCode: 'TZ');

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.bgScreen,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .create_your_account
                        .toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(AppLocalizations.of(context).phone_number),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.border)),
                    width: Utils.displayWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        _phone = number.phoneNumber.replaceAll("+", "");
                        print(_phone);
                      },
                      onInputValidated: (bool value) {
                        if (value) print(value);
                      },
                      validator: (value) {
                        if (value.length >= 9) {
                          return "*";
                        } else
                          return null;
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      hintText: "*** *** ***",
                      initialValue: number,
                      textFieldController: _phoneController,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      color: Theme.of(context).primaryColor,
                      height: 45,
                      minWidth: Utils.displayWidth(context),
                      onPressed: () {
                        if (!_authProvider.isSendingPhone) {
                          if (_phoneController.text.length <= 9)
                            _authProvider.signUp(phone: _phone).then((value) {
                              if (!value) {
                                showToastWidget(
                                  ToastWidget(
                                      icon: Icon(
                                        Icons.done,
                                        color: Color(0xFF06be77),
                                        size: 15,
                                      ),
                                      height: 50,
                                      width: 250,
                                      color: AppColor.success,
                                      description: "code sent"),
                                  duration: Duration(seconds: 2),
                                  position: ToastPosition.bottom,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpPage(
                                              phone: _phone,
                                            )));
                              } else {
                                showToastWidget(
                                  ToastWidget(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      height: 50,
                                      width: 280,
                                      color: AppColor.preBase,
                                      description:
                                          "${_authProvider.authResponce.message.en}"),
                                  duration: Duration(seconds: 2),
                                  position: ToastPosition.bottom,
                                );
                              }
                            });
                        }
                      },
                      child: _authProvider.isSendingPhone
                          ? Loading()
                          : Text(
                              AppLocalizations.of(context)
                                  .send_verification
                                  .toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
