import 'package:capstone/utils/constants/color_constant.dart';
import 'package:capstone/utils/constants/image_constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              ImageConstant.icAdd,
              height: size.height * 0.03,
              width: size.height * 0.03,
              color: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
      body: Material(
        color: Colors.white,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.05,),
                Container(
                  padding: EdgeInsets.all(size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Container(
                        width: size.width * 0.5,
                        height: size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageConstant.imgCreateBooking),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        "Tạo booking",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.1,),
                Container(
                  padding: EdgeInsets.all(size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Container(
                        width: size.width * 0.5,
                        height: size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageConstant.imgViewHistory),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        "Xem lịch sử",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
