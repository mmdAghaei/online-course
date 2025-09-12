import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/feature/home/home-screen.dart';
import 'package:podcast/routes/routes_controller.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutesController routesController = Get.put(RoutesController());

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => Expanded(child: routesController.currentPage)),
          Positioned(
            bottom: 50.h,
            left: 20,
            right: 20,
            top: 700.h,
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<CustomColors>()!.navibox,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      blurRadius: 56.w,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigationButton(
                      image: "assets/Vector-1.png",
                      isActive: routesController.currentIndex.value == 0,
                      onTap: () => routesController.changePage(0),
                    ),
                    NavigationButton(
                      image: "assets/Vector.png",
                      isActive: routesController.currentIndex.value == 2,
                      onTap: () => routesController.changePage(2),
                    ),
                    NavigationButton(
                      image: "assets/Vector-2.png",
                      isActive: routesController.currentIndex.value == 1,
                      onTap: () => routesController.changePage(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String image;
  final bool isActive;
  final dynamic onTap;
  const NavigationButton({
    super.key,
    required this.image,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(500),
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 45.w,
        height: 45.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: (Theme.of(context).extension<CustomColors>()!.iconnavi ??
                    const Color.fromARGB(255, 204, 204, 204))
                .withOpacity(isActive ? 0.4 : 0),

            width: isActive ? 3 : 0,
          ),
        ),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: isActive ? 1 : .5,
          child: SizedBox(
            width: 22.w,
            height: 22.w,
            child: ImageIcon(
              AssetImage(image),
              color: Theme.of(context).extension<CustomColors>()!.iconnavi,
            ),
          ),
        ),
      ),
    );
  }
}
