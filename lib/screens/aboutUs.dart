import 'package:elaptop/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String desAbout =
        'Xuất phát từ chính nhu cầu luôn muốn cập nhật những xu hướng công nghệ và nhanh nhất nhưng vẫn phù hợp túi tiền . WELAPS ra đời với mong muốn mang đến những lựa chọn tuyệt vời nhất từ mẫu mã đặc biệt giá cả cực kì mềm. Một môi trường công nghệ thân thiện – nơi bạn có thể thỏa sức lựa chọn. Nơi luôn niềm nở chào đón quý khách nhiệt tình chu đáo bất kể bạn có mua sản phẩm hay không. Vì vậy, đừng ngại đến.';
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        centerTitle: true,
        title: Text('',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: Home()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        // actions: [Container()],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: MediaQuery.of(context).size.height * (710 / 812),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  //header
                  Container(
                    // padding: EdgeInsets.only(bottom: 0.5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue.shade300,
                          width: 2.5,
                        ),
                      ),
                    ),
                    // height: 40,
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //container
                  Container(
                    height: 490,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF0B5EA7),
                          width: 3,
                        ),
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(170.0),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          height: 400,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 290,
                                height: 60,
                                child: Text(
                                  'WELAPS\nChuyên sỉ các máy laptop',
                                  style: TextStyle(
                                    color: Color(0xFF0B5EA7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(
                                child: Text(
                                  desAbout,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   child: MyButton(
                        //     onPressed: () {},
                        //     name: 'Button',
                        //     width: 150,
                        //   ),
                        // ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
