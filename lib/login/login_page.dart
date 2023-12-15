import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaomatest/register/register_page.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _login_pagePageState createState() => _login_pagePageState();
}

class _login_pagePageState extends State<loginPage> {
  late FocusNode loginFocusNode;
  late TextEditingController loginController;
  late FocusNode pwdFocusNode;
  late TextEditingController pwdController;
  late ValueNotifier<bool> _showLoginClearNotifier;
  late ValueNotifier<bool> _showPwdClearNotifier;
  bool showPwd = true;
  bool showEmptyLoginTip = false;
  bool showEmptyPwdTip = false;
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginFocusNode = FocusNode();
    loginController = TextEditingController();
    pwdFocusNode = FocusNode();
    pwdController = TextEditingController();
    _showLoginClearNotifier = ValueNotifier<bool>(false);
    _showPwdClearNotifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            // padding: const EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, // 背景色
                borderRadius: BorderRadius.circular(10) // 圆角边框
                ),
            child: Row(
              children: [
                _input(),
                _loginClearButton(context),
              ],
            ), // 子 Widget，可以去掉
          ),
          Visibility(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text(
                  "登录账号不能为空",
                  style: TextStyle(),
                ),
              ),
              visible: showEmptyLoginTip),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            // padding: const EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, // 背景色
                borderRadius: BorderRadius.circular(10) // 圆角边框
                ),
            child: Row(
              children: [
                _input(isLogin: false),
                _registerClearButton(context),
                SizedBox(width: 10),
                Visibility(
                  visible: showPwd,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showPwd = false;
                      });
                    },
                    child: Image.asset("assets/images/showpassword.png"),
                  ),
                  replacement: InkWell(
                    onTap: () {
                      setState(() {
                        showPwd = true;
                      });
                    },
                    child: Image.asset("assets/images/hidepassword.png"),
                  ),
                ),
              ],
            ), // 子 Widget，可以去掉
          ),
          Visibility(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text(
                  "登录密码不能为空",
                  style: TextStyle(),
                ),
              ),
              visible: showEmptyPwdTip),
          InkWell(
            onTap: () {
              if (loginController.text.isEmpty) {
                setState(() {
                  showEmptyLoginTip = true;
                  EasyLoading.showError("登录账号不能为空");
                });
                return;
              }

              if (pwdController.text.isEmpty) {
                setState(() {
                  showEmptyPwdTip = true;
                  EasyLoading.showError("登录密码不能为空");
                });
                return;
              }


              if (loginController.text=="123456"&&pwdController.text=="123456") {


                  EasyLoading.showSuccess("登录成功");

                return;
              }else{
                EasyLoading.showError("密码或者账号不正确");
              }
            },
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              // padding: const EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange, // 背景色
                  borderRadius: BorderRadius.circular(10) // 圆角边框
                  ),
              child: Text("登录",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) {
                        return registerPage();
                      }
                  )
              );
            },
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              // padding: const EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange, // 背景色
                  borderRadius: BorderRadius.circular(10) // 圆角边框
              ),
              child: Text("注册",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  _input({bool isLogin = true}) {
    return Expanded(
        child: TextField(
      focusNode: isLogin ? loginFocusNode : pwdFocusNode,
      controller: isLogin ? loginController : pwdController,
      onChanged: isLogin ? _onLoginChanged : _pwdOnChanged,
      obscureText: isLogin ? true : showPwd,
      keyboardType: TextInputType.text,
      cursorColor: Colors.orange,
      style: TextStyle(
          fontSize: 12.sp,
          color: Color(0xff333333),
          fontWeight: FontWeight.w400),
      //输入框的样式
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10),
          border: InputBorder.none,
          hintText: "请输入登录账号",
          hintStyle: TextStyle(fontSize: 16.sp, color: Color(0xff999999))),
    ));
  }

  _loginClearButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _showLoginClearNotifier,
        builder: (ctx, value, child) => Visibility(
              visible: value,
              child: InkWell(
                onTap: () {
                  loginController.clear();
                  _onLoginChanged('');
                },
                child: Image.asset("assets/images/clear.png"),
              ),
            ));
  }

  _onLoginChanged(String text) {
    if (text.isNotEmpty) {
      _showLoginClearNotifier.value = true;
     setState(() {
       showEmptyLoginTip = false;
     });
    } else {
      _showLoginClearNotifier.value = false;
    }
  }

  _registerClearButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _showPwdClearNotifier,
        builder: (ctx, value, child) => Visibility(
              visible: value,
              child: InkWell(
                onTap: () {
                  pwdController.clear();
                  _pwdOnChanged('');
                },
                child: Image.asset("assets/images/clear.png"),
              ),
            ));
  }

  _pwdOnChanged(String text) {
    if (text.isNotEmpty) {
      _showPwdClearNotifier.value = true;
     setState(() {
       showEmptyPwdTip = false;
     });
    } else {
      _showPwdClearNotifier.value = false;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginFocusNode.dispose();
    loginController.dispose();
    pwdFocusNode.dispose();
    pwdController.dispose();
  }
}
