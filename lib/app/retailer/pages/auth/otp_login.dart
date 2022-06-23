import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_home.dart';
import 'package:uza_sales/app/retailer/provider/auth_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/sales/pages/sales_home.dart';

import '../home_page.dart';

class OtpLogin extends StatefulWidget {
  final String phone;
  const OtpLogin({Key key, @required this.phone}) : super(key: key);

  @override
  _OtpLoginState createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  StreamController<ErrorAnimationType> errorController;
  Timer _timer;

  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String codeText = '';
  bool hasError = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _otpcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // startTimer();
    errorController = StreamController<ErrorAnimationType>();
  }

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
                        .verify_your_number
                        .toUpperCase(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(AppLocalizations.of(context).one_time_password),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.border)),
                    width: Utils.displayWidth(context),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: PinCodeTextField(
                          autoFocus: true,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: AppColor.base,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 5,
                          showCursor: true,
                          obscureText: true,
                          obscuringCharacter: '*',
                          // obscuringWidget: Image.asset('assets/icons/logo.png'),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 5) {
                              return "code should be 5";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            // borderRadius: BorderRadius.circular(5),
                            fieldHeight: 40,
                            activeColor: AppColor.base,
                            selectedFillColor: AppColor.bgScreen,
                            selectedColor: AppColor.base,
                            fieldWidth: 25,
                            inactiveFillColor: AppColor.bgScreen,
                            inactiveColor: Colors.black,
                            activeFillColor: AppColor.bgScreen,
                          ),
                          cursorColor: Colors.black,
                          // autoFocus: true,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,

                          // errorAnimationController: errorController,
                          controller: _otpcontroller,
                          keyboardType: TextInputType.number,

                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              codeText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Center(
                  //     child: Text(
                  //   _start > 0 ? "in $_start" : "now",
                  //   style: TextStyle(color: Colors.white),
                  // )),
                  SizedBox(height: 10),
                  Center(
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text:
                              "${AppLocalizations.of(context).didint_resend}?  ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: AppLocalizations.of(context).resend,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (_start == 0) {
                                setState(() {
                                  _start = 30;
                                });
                                startTimer();
                                Navigator.pop(context);
                                _authProvider
                                    .signUp(phone: this.widget.phone)
                                    .then((value) {
                                  if (!value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OtpLogin(
                                                  phone: this.widget.phone,
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

                                print('***************object*************');
                              }
                            },
                          style: TextStyle(color: AppColor.base)),
                      TextSpan(
                          text: _start > 0 ? "in $_start" : "now",
                          style: TextStyle(
                              color: AppColor.base,
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ])),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      color: Theme.of(context).primaryColor,
                      height: 45,
                      minWidth: Utils.displayWidth(context),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          // validating form
                          if (codeText.length != 5) {
                            errorController.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                          } else {
                            print(" send codetext ");
                            print(codeText);
                            _authProvider
                                .verifyOtp(
                                    phone: this.widget.phone,
                                    otp: _otpcontroller.text)
                                .then((value) => {
                                      if (!value)
                                        {
                                          showToastWidget(
                                            LoggedInToast(
                                                icon: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                height: 50,
                                                width: 280,
                                                color: AppColor.success,
                                                description:
                                                    "You're now Login successful"),
                                            duration: Duration(seconds: 3),
                                            position: ToastPosition.bottom,
                                          ),
                                          print("*****  verify otp   ******"),
                                          if (_authProvider.isSupplier == true)
                                            {
                                              print(
                                                  "you are signed as supplier"),
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalesHome())),
                                            }
                                          else if (_authProvider.isRetailer ==
                                              true)
                                            {
                                              print(
                                                  "you are signed in as retailer"),
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage())),
                                            }
                                          else if (_authProvider
                                                  .isOrderBooker ==
                                              true)
                                            {
                                              print(
                                                  "you are signed in as orderbooker"),
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookerHome())),
                                            }
                                          else
                                            {
                                              print("Admin signed in"),
                                            }
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             HomePage())),
                                        }
                                      else
                                        {
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
                                                description: "Invalid code"),
                                            duration: Duration(seconds: 2),
                                            position: ToastPosition.bottom,
                                          )
                                        }
                                    });
                          }
                        }
                      },
                      child: _authProvider.isVerifyingCode
                          ? Loading()
                          : Text(
                              AppLocalizations.of(context).next.toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
