import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _register_pagePageState createState() => _register_pagePageState();
}

class _register_pagePageState extends State<registerPage> {
  late FocusNode registerFocusNode;
  late TextEditingController registerController;
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

    registerFocusNode = FocusNode();
    registerController = TextEditingController();
    pwdFocusNode = FocusNode();
    pwdController = TextEditingController();
    _showLoginClearNotifier = ValueNotifier<bool>(false);
    _showPwdClearNotifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "注册账号不能为空",
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "注册密码不能为空",
                  style: TextStyle(),
                ),
              ),
              visible: showEmptyPwdTip),
          InkWell(
            onTap: () {
              if (registerController.text.isEmpty) {
                setState(() {
                  showEmptyLoginTip = true;
                  EasyLoading.showError("注册账号不能为空");
                });
                return;
              }

              if (pwdController.text.isEmpty) {
                setState(() {
                  showEmptyPwdTip = true;
                  EasyLoading.showError("注册密码不能为空");
                });
                return;
              }

              if (registerController.text == "123456" &&
                  pwdController.text == "123456") {
                EasyLoading.showSuccess("注册成功");

                return;
              } else {
                EasyLoading.showError("注册失败");
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
      focusNode: isLogin ? registerFocusNode : pwdFocusNode,
      controller: isLogin ? registerController : pwdController,
      onChanged: isLogin ? _onRegisterChanged : _pwdOnChanged,
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
          hintText: "请输入注册账号",
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
                  registerController.clear();
                  _onRegisterChanged('');
                },
                child: Image.asset("assets/images/clear.png"),
              ),
            ));
  }

  _onRegisterChanged(String text) {
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
    registerFocusNode.dispose();
    registerController.dispose();
    pwdFocusNode.dispose();
    pwdController.dispose();
  }
}
