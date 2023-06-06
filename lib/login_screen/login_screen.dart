
import 'package:capstone/bottom_bar_navigator/bottom_bar_navigator.dart';
import 'package:capstone/widget/dialog/finding_dialog.dart';

import 'package:flutter/material.dart';
import '../utils/constants/color_constant.dart';
import '../utils/constants/image_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPass = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();

    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgLoginBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Image.asset(ImageConstant.appIcon,
                height: size.height * 0.15, width: size.width * 0.3),
            Text(
              'Smart Locker',
              style: TextStyle(
                fontSize: size.height * 0.042,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.05,
                bottom: size.height * 0.03,
                left: size.width * 0.07,
                right: size.width * 0.07,
              ),
              child: Theme(
                data: theme.copyWith(
                  colorScheme: theme.colorScheme
                      .copyWith(primary: ColorConstant.primaryColor),
                ),
                child: TextField(
                  style: TextStyle(
                      fontSize: size.width * 0.04, color: Colors.black),
                  cursorColor: ColorConstant.primaryColor,
                  controller: null,
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    errorText: null,

                    prefixIcon: SizedBox(
                      width: size.width * 0.05,
                      child: Icon(
                        Icons.phone,
                        size: size.width * 0.05,
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
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
              padding: EdgeInsets.fromLTRB(size.width * 0.07, 0,
                  size.width * 0.07, size.height * 0.03),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme
                          .copyWith(primary: ColorConstant.primaryColor),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                      ),
                      obscureText: !_showPass,
                      onChanged: (value) {},
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      decoration: InputDecoration(
                        errorText: null,
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
                right: size.width * 0.07,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Quên mật khẩu? ',
                      style: TextStyle(
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.07,
                top: size.height * 0.03,
                right: size.width * 0.07,
              ),
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.055,
                child: ElevatedButton(
                  //onPressed: () {
                  //  Navigator.pushNamed(context, '/homeScreen');
                  //},
                  onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBarNavigator(selectedIndex: 0, isBottomNav: true),));
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: const Text("Đăng nhập"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.07,
                top: size.height * 0.05,
                right: size.width * 0.07,
                bottom: size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.05, right: size.width * 0.05),
                    child: Text(
                      "Hoặc ",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
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
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                left: size.width * 0.07,
                right: size.width * 0.07,
              ),
              child: Container(
                width: size.width,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageConstant.imgGoogle,
                          width: size.height * 0.04),
                      Text(
                        '    Đăng nhập với Google',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                ),
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
                        'Chưa có tài khoản? ',
                        style: TextStyle(
                          fontSize: size.height * 0.017,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUpScreen');
                        },
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Ứng dụng cho Khách hàng',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: size.height * 0.017,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
