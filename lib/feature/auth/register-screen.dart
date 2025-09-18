import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/user-auth-controller.dart';
import 'package:podcast/data/api/user-auth.dart';
import 'package:podcast/feature/auth/register-controller.dart';
import 'package:podcast/feature/varification/varification-screen.dart';
import 'package:podcast/routes/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _topSlide;
  late final Animation<double> _topFade;
  late final Animation<Offset> _cardSlide;
  late final Animation<double> _cardFade;

  bool _remember = true;

  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _topSlide = Tween(begin: const Offset(0, -0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );
    _topFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
      ),
    );

    _cardSlide = Tween(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _cardFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPillToggle() {
    return Obx(() {
      final isLogin = authController.isLogin.value;
      return Container(
        width: 312.w,
        height: 44.w,
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: authController.setLogin,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isLogin
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'ورود',
                    style: TextStyle(
                      color: isLogin ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: Fonts.VazirBold.fontFamily,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: authController.setRegister,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isLogin
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'ثبت‌نام',
                    style: TextStyle(
                      color: !isLogin ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: Fonts.VazirBold.fontFamily,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    UserAuthController userAuthController = Get.put(UserAuthController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: const Alignment(0.43, -1),
                    child: Visibility(
                      visible: false,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: Container(
                        width: 150.w,
                        height: 26.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: Color(0xFFA8A8A8),
                        ),
                      ),
                    ),
                  ),

                  SlideTransition(
                    position: _topSlide,
                    child: FadeTransition(
                      opacity: _topFade,
                      child: Align(
                        alignment: Alignment(0, -0.77),
                        child: SizedBox(
                          width: 336.w,
                          child: Obx(() {
                            final isLogin = authController.isLogin.value;
                            return Text(
                              isLogin
                                  ? 'وارد حساب بشو و به دنیای دوره‌ها\nدسترسی پیدا کن'
                                  : 'ثبت‌نام کن و به دنیای دوره‌ها\nدسترسی پیدا کن',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontFamily: Fonts.VazirBold.fontFamily,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                  SlideTransition(
                    position: _cardSlide,
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: Container(
                        width: double.infinity,
                        height: 519.w,
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).extension<CustomColors>()!.card,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(29),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 375.w,
                                height: 300.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildPillToggle(),

                                    Obx(() {
                                      final isLogin =
                                          authController.isLogin.value;
                                      if (isLogin) {
                                        return Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .phoneController,
                                                  hintText: "شماره تلفن",
                                                  icon: const Icon(
                                                    Icons.call,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  obscureText: false,
                                                  textInputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'[0-9]'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .passwordController,
                                                  hintText: 'رمز عبور',
                                                  icon: const Icon(
                                                    Icons.password,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: true,
                                                  textInputFormatters: [],
                                                ),
                                              ),

                                              SizedBox(
                                                width: 312.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                          VarificationScreen(),
                                                        );
                                                      },
                                                      child: Text(
                                                        'فراموشی رمز عبور',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFF0F172A,
                                                          ),
                                                          fontSize: 13.sp,
                                                          fontFamily: Fonts
                                                              .VazirBold
                                                              .fontFamily,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'مرا به خاطر بسپار',
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFFB9B9B9,
                                                            ),
                                                            fontSize: 12.sp,
                                                            fontFamily: Fonts
                                                                .VazirBold
                                                                .fontFamily,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                        SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Checkbox(
                                                            value: _remember,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _remember =
                                                                    value ??
                                                                    false;
                                                              });
                                                            },
                                                            checkColor:
                                                                Colors.white,
                                                            activeColor:
                                                                const Color(
                                                                  0xFF0F172A,
                                                                ),
                                                            side:
                                                                const BorderSide(
                                                                  color: Color(
                                                                    0xFFB9B9B9,
                                                                  ),
                                                                  width: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .firstNameController,
                                                  hintText: "نام",
                                                  icon: const Icon(
                                                    Icons.person,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.name,
                                                  obscureText: false,
                                                  textInputFormatters: [],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .lastNameController,
                                                  hintText: "نام خانوادگی",
                                                  icon: const Icon(
                                                    Icons.person,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.name,
                                                  obscureText: false,
                                                  textInputFormatters: [],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .phoneController,
                                                  hintText: "شماره تلفن",
                                                  icon: const Icon(
                                                    Icons.call,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  obscureText: false,
                                                  textInputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'[0-9]'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 312.w,
                                                child: TextFieldWidget(
                                                  textEditingController:
                                                      userAuthController
                                                          .passwordController,
                                                  hintText: 'رمز عبور',
                                                  icon: const Icon(
                                                    Icons.password,
                                                    size: 24,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: true,
                                                  textInputFormatters: [],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Container(
                                  width: 326.w,
                                  height: 55.w,
                                  child: Obx(() {
                                    final isLogin =
                                        authController.isLogin.value;
                                    return ButtonApp(
                                      title: isLogin ? "ورود" : "ثبت‌نام",
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                      foregroundColor: Colors.white,
                                      onTap: () async {
                                        if (isLogin) {
                                          userAuthController.login();
                                        } else {
                                          userAuthController.signUp();
                                        }
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
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
