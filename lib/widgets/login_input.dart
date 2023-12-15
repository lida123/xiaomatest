// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:xiaomatest/util/ColorsUtil.dart';
//
//
// ///登录输入框，自定义widget
// class LoginInput extends StatefulWidget {
//   final String? hint; // 输入框提示
//   final ValueChanged<String>? onChanged; //输入框事件回调函数
//   final bool obscureText; // 是否是密码输入框
//   final TextInputType? keyboardType; // 输入框类型
//   final bool isCode;
//
//   final double? h;
//
//   final Color? bgColor;
//
//   final double? radius;
//
//   final EdgeInsets? padding;
//
//   final Future<bool> Function()? sendCode;
//
//   final double? fontSize;
//
//   const LoginInput(this.hint,
//       {Key? key,
//       this.onChanged,
//       this.obscureText = false,
//       this.keyboardType,
//       this.isCode = false,
//       this.h = 48,
//       this.bgColor = Colors.transparent,
//       this.radius = 0,
//       this.padding = EdgeInsets.zero,
//       this.sendCode,
//       this.fontSize})
//       : super(key: key);
//
//   @override
//   _LoginInputState createState() => _LoginInputState();
// }
//
// class _LoginInputState extends State<LoginInput> {
//   TextEditingController _controller = new TextEditingController();
//
//   bool showPwd = false; // 是否显示密码
//
//   final ValueNotifier<bool> _showClearNotifier = ValueNotifier<bool>(false);
//
//   ValueNotifier<String>? _codeBtnTextNotifier;
//
//   int countDown = 60;
//
//   Timer? codeTimer;
//
//   bool isSendCode = false;
//
//   final FocusNode focusNode = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         if (_controller.text.isNotEmpty) {
//           _showClearNotifier.value = true;
//         }
//       } else {
//         if (_showClearNotifier.value) {
//           _showClearNotifier.value = false;
//         }
//       }
//     });
//     if (widget.isCode) {
//       _codeBtnTextNotifier = ValueNotifier<String>("获取验证码");
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _showClearNotifier.dispose();
//     _codeBtnTextNotifier?.dispose();
//     focusNode.dispose();
//     codeTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.h!.h,
//       padding: widget.padding,
//       decoration: BoxDecoration(
//           color: widget.bgColor,
//           borderRadius: BorderRadius.all(Radius.circular(widget.radius!))),
//       child: Row(
//         children: [
//           _input(),
//           _clearSvgIcon(context),
//           _eyeSvgIcon(context),
//           _codeWidget(context)
//         ],
//       ),
//     );
//   }
//
//   _input() {
//     return Expanded(
//         child: TextField(
//       focusNode: focusNode,
//       controller: _controller,
//       onChanged: _onChanged,
//       obscureText: widget.obscureText && !showPwd,
//       keyboardType: widget.keyboardType,
//       cursorColor: primaryColor,
//       style: TextStyle(
//           fontSize: widget.fontSize!.sp,
//           color: Color(0xff333333),
//           fontWeight: FontWeight.w400),
//       //输入框的样式
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(right: 10),
//           border: InputBorder.none,
//           hintText: widget.hint!,
//           hintStyle: TextStyle(
//               fontSize: 16.sp, color: Color(0xff999999))),
//     ));
//   }
//
//   _clearSvgIcon(BuildContext context) {
//     if (widget.isCode) {
//       return SizedBox();
//     }
//     return ValueListenableBuilder<bool>(
//         valueListenable: _showClearNotifier,
//         builder: (ctx, value, child) => Visibility(
//             visible: value,
//       child:  InkWell(
//         onTap:(){
//         _controller.clear();
//         _onChanged('');
//     },
//     child: ,
//     ),
//
//             // wrapTap(
//             //     context,
//             //     Icon(
//             //       IconFontConstant.dialog_close,
//             //       color: Color(0xffc2c2c2),
//             //       size: ScreenAdapter.sp(16),
//             //     ), () {
//             //   _controller.clear();
//             //   _onChanged('');
//             // }, isHideKeyBoard: false)));
//   }
//
//   _eyeSvgIcon(BuildContext context) {
//     if (widget.obscureText) {
//       return Visibility(
//         child: _eyeWrap('open-eye', context),
//         replacement: _eyeWrap('close-eye', context),
//         visible: showPwd,
//       );
//     } else {
//       return SizedBox();
//     }
//   }
//
//   _codeWidget(BuildContext context) {
//     if (!widget.isCode) {
//       return SizedBox();
//     }
//
//     return Row(
//       children: [
//         Container(
//           height: 20.h,
//           width:0.5.w,
//           color: Color(0xffeeeeee),
//         ),
//         SizedBox(
//           width: 12.w,
//         ),
//
//       ],
//     );
//   }
//
//   _eyeWrap(String svgName, BuildContext context) {
//     return wrapTap(
//         context,
//         Padding(
//           padding: EdgeInsets.only(left: ScreenAdapter.width(12)),
//           child: SvgIcon(
//               svgName: svgName,
//               svgColor: primaryColor,
//               svgWidth: ScreenAdapter.radius(22),
//               svgHeight: ScreenAdapter.radius(22)),
//         ), () {
//       setState(() {
//         showPwd = !showPwd;
//       });
//     }, isHideKeyBoard: false);
//   }
//
//   _onChanged(String text) {
//     if (text.isNotEmpty) {
//       _showClearNotifier.value = true;
//     } else {
//       _showClearNotifier.value = false;
//     }
//     if (widget.onChanged != null) {
//       widget.onChanged!(text);
//     }
//   }
//
//   sendCode() async {
//     if (isSendCode) {
//       return;
//     }
//
//     bool result = false;
//
//     if (widget.sendCode != null) {
//       result = await widget.sendCode!();
//     }
//
//     if (result) {
//       isSendCode = true;
//       _codeBtnTextNotifier?.value = "${countDown}s";
//       codeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//         countDown--;
//         _codeBtnTextNotifier?.value = "${countDown}s";
//         if (countDown == 0) {
//           codeTimer?.cancel();
//           isSendCode = false;
//           countDown = 60;
//           _codeBtnTextNotifier?.value = "获取验证码";
//         }
//       });
//     } else {
//       isSendCode = false;
//     }
//   }
// }
