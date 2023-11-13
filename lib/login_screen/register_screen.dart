
import 'package:capstone/services/api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


import '../utils/constants/color_constant.dart';
import '../utils/constants/image_constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPass = false;
  bool _isCommit = false;
  TextEditingController _fullname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _repassword = TextEditingController();
  TextEditingController _phone = TextEditingController();
  bool areStringsEqual = false;
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
          var snapshot;
          return Material(
            child: Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.only(
                left: size.width * 0.07,
                right: size.width * 0.07,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLoginBg),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Text(
                      'Đăng ký',
                      style: TextStyle(
                        fontSize: size.height * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.06,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                          },
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: _fullname,
                          decoration: InputDecoration(
                            hintText: "Họ và tên",
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.account_circle_sharp,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                          },
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.mail_outlined,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: "Số điện thoại",
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.phone,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                  primary: ColorConstant.primaryColor),
                            ),
                            child: TextField(
                              onChanged: (value) {
                              },
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black,
                              ),
                              obscureText: !_showPass,
                              cursorColor: ColorConstant.primaryColor,
                              controller: _password,
                              decoration: InputDecoration(
                                hintText: "Mật Khẩu",
                                prefixIcon: SizedBox(
                                  width: size.width * 0.05,
                                  child: Icon(
                                    Icons.lock,
                                    size: size.width * 0.05,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.height * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  onToggleShowPass();
                                });
                              },
                              child: Icon(
                                _showPass
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: _showPass
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                                size: size.height * 0.028,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                  primary: ColorConstant.primaryColor),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                areStringsEqual = _repassword.text == _password.text;
                                setState(() {
                                  if (areStringsEqual = _repassword.text == _password.text) {
                                    errorText = '';
                                  } else {
                                    errorText = 'Hai mật khẩu không trùng nhau';
                                  }
                                });
                              },
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black,
                              ),
                              obscureText: !_showPass,
                              cursorColor: ColorConstant.primaryColor,
                              controller: _repassword,
                              decoration: InputDecoration(
                                hintText: "Nhập lại mật khẩu",
                                prefixIcon: SizedBox(
                                  width: size.width * 0.05,
                                  child: Icon(
                                    Icons.lock,
                                    size: size.width * 0.05,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                      color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.height * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  onToggleShowPass();
                                });
                              },
                              child: Icon(
                                _showPass
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: _showPass
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                                size: size.height * 0.028,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                      ),
                    ),
                    // (snapshot.hasError &&
                    //     (snapshot.error as Map<String, String>)
                    //         .containsKey("commit"))
                    //     ? SizedBox(
                    //   width: size.width,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //       left: size.width * 0.03,
                    //     ),
                    //     child: Text(
                    //       (snapshot.error as Map<String, String>)["commit"]!,
                    //       textAlign: TextAlign.left,
                    //       style: TextStyle(
                    //         color: ColorConstant.redErrorText,
                    //         fontSize: size.height * 0.016,
                    //         height: 0.01,
                    //       ),
                    //     ),
                    //   ),
                    // )
                    //     : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              areStringsEqual = _repassword.text == _password.text;
                            });
                            if(areStringsEqual){
                              if(_fullname.text.isNotEmpty &&
                                  _phone.text.isNotEmpty &&
                                  _email.text.isNotEmpty &&
                                  _password.text.isNotEmpty &&
                                  _repassword.text.isNotEmpty){
                                //Api.register(_fullname.text, _password.text, _phone.text, _email.text);
                                if(await Api.register(_fullname.text, _password.text, _phone.text, _email.text)){
                                  registerUser(_email.text, _password.text, _fullname.text.toString().trim());
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                            }
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Cảnh báo'),
                                      content: Text('Vui lòng nhập đủ thông tin.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Đóng'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }else{
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Cảnh báo'),
                                    content: Text('Vui lòng nhập hai mật khẩu trùng nhau'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Đóng'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Đăng ký"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              "Hoặc ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.height * 0.018,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: SizedBox(
                        width: size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đã có tài khoản? ',
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
  Future<void> registerUser(String email, String password, String username) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu thông tin người dùng vào Realtime Database
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');
      userRef.child(userCredential.user!.uid).set({
        'email': email,
        'username': username,
      });
    } catch (e) {
      print('Đăng ký thất bại: $e');
      // Xử lý lỗi đăng ký
    }
  }
}



