import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/data/models/news-model.dart';
import 'package:podcast/feature/news%20about/news-about-screen.dart';

class NewsCard extends StatelessWidget {
  final NewsModel item;

  const NewsCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(item.image);
    return Container(
      width: 339.w,
      height: 248.w,
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColors>()!.card,
        boxShadow: [
          // BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 101.w),
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: 339.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 328.w,
              height: 159.w,
              margin: const EdgeInsets.only(top: 8),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.image??""),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  item.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).extension<CustomColors>()!.title,
                    fontSize: 16.sp,
                    fontFamily: Fonts.VazirMedium.fontFamily,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  item.created_at,
                  style: TextStyle(
                    color: Color(0xFF989898),
                    fontSize: 11.sp,
                    fontFamily: Fonts.VazirMedium.fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsSlider extends StatefulWidget {
  final List<NewsModel> items;

  const NewsSlider({Key? key, required this.items}) : super(key: key);

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        int nextPage = (_currentPage + 1) % widget.items.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 339.w,
      height: 270.w,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemBuilder: (context, index) {
          final active = index == _currentPage;

          return AnimatedScale(
            scale: active ? 1.0 : 0.9,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              opacity: active ? 1.0 : 0.6,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () =>
                      Get.to(NewsAboutScreen(newsModel: widget.items[index])),
                  child: NewsCard(item: widget.items[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
