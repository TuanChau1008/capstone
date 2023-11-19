import 'package:flutter/material.dart';

import '../dialogs/generic_dialog.dart';
import '../services/api.dart';
import '../utils/constants/color_constant.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({Key? key}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  TextEditingController masterCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/homeScreen');
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 30),
              buildTextField("Mật khẩu cũ", "******", true),
              buildTextFieldPw("Mật khẩu mới", "******", true),
              buildTextFieldRePw("Xác nhận lại mật khẩu", "******", true),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // OutlinedButton(
                  //   onPressed: () {},
                  //   child: Text("THOÁT",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         letterSpacing: 2,
                  //         color: Colors.black
                  //     ),
                  //   ),
                  //   style: OutlinedButton.styleFrom(
                  //       padding: EdgeInsets.symmetric(horizontal: 50),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20))
                  //   ),
                  // ),
                  ElevatedButton(
                      onPressed: () async {

                        Api.changeMasterCode(masterCode.text);
                        if (context.mounted) {
                          await showGenericDialog(
                          context: context,
                          title: "Đổi master code",
                          content: "Đổi master code thành công",
                          optionBuilder: () => {"OK": true}, data: '',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstant.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 170),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))
                      ),
                      child: const Text("LƯU",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      )
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget buildTextFieldPw(String labelText, String placeholder,
      bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: masterCode,
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }
  Widget buildTextFieldRePw(String labelText, String placeholder,
      bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }
}
