import 'package:podcast/data/models/course-section-model.dart';

class CoursesModel {
  final String id;
  final String title;
  final String description;
  final String buyStatus;
  final String price;
  final String finalPrice;
  final String? image;
  final String? sectionCount;
  final String? seen;
  final String? disCount;
  final List<CourseSectionModel>? sections;

  CoursesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.buyStatus,
    required this.price,
    required this.finalPrice,
    this.image,
    this.sectionCount,
    this.seen,
    this.disCount,
    this.sections,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    String buyStatusText;
    if (json['buy_status'] == "not_buy") {
      buyStatusText = "خریداری نشده";
    } else if (json['buy_status'] == "buy") {
      buyStatusText = "خریداری شده";
    } else {
      buyStatusText = "رایگان";
    }

    return CoursesModel(
      id: json['id'].toString(),
      disCount: json['discount']?.toString(),
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      image: json['media_url'],
      buyStatus: buyStatusText,
      finalPrice: json['final_price']?.toString() ?? "0",
      price: json['price']?.toString() ?? "0",
      sectionCount: json['section_count']?.toString(),
      seen: json['seen']?.toString(),
      sections: json['sections'] != null
          ? (json['sections'] as List)
                .map((e) => CourseSectionModel.fromJson(e))
                .toList()
          : null,
    );
  }
}

// List<CoursesModel> courses = [
//   // CoursesModel(
//   //   id: '1',
//   //   title: 'آموزش مقدماتی فلاتر',
//   //   description: 'یادگیری مبانی فلاتر از صفر.',
//   //   buyStatus: 'رایگان',
//   //   price: '100,000',
//   //   finalPrice: '0',
//   // ),
//   // CoursesModel(
//   //   id: '2',
//   //   title: 'فلاتر پیشرفته',
//   //   description: 'بررسی پیشرفته ویجت‌ها و مدیریت وضعیت در فلاتر.',
//   //   buyStatus: 'غیر رایگان',
//   //   price: '200',
//   //   finalPrice: '100',
//   // ),
//   // CoursesModel(
//   //   id: '3',
//   //   title: 'برنامه‌نویسی دارت',
//   //   description: 'یادگیری زبان دارت از پایه.',
//   //   buyStatus: 'رایگان',
//   //   price: '0',
//   //   finalPrice: '0',
//   // ),
//   // CoursesModel(
//   //   id: '4',
//   //   title: 'فایربیس برای فلاتر',
//   //   description: 'یکپارچه‌سازی فایربیس با اپلیکیشن‌های فلاتر.',
//   //   buyStatus: 'غیر رایگان',
//   //   price: '300',
//   //   finalPrice: '250',
//   // ),
//   // CoursesModel(
//   //   id: '5',
//   //   title: 'اصول طراحی UI/UX',
//   //   description: 'یادگیری اصول طراحی رابط کاربری و تجربه کاربری.',
//   //   buyStatus: 'رایگان',
//   //   price: '0',
//   //   finalPrice: '0',
//   // ),
//   // CoursesModel(
//   //   id: '6',
//   //   title: 'شبکه و امنیت در اپلیکیشن‌ها',
//   //   description: 'آشنایی با امنیت و شبکه در برنامه‌های موبایل.',
//   //   buyStatus: 'غیر رایگان',
//   //   price: '250',
//   //   finalPrice: '200',
//   // ),
//   // CoursesModel(
//   //   id: '7',
//   //   title: 'تست و رفع اشکال در فلاتر',
//   //   description: 'آموزش تست واحد و رفع خطا در اپلیکیشن‌های فلاتر.',
//   //   buyStatus: 'رایگان',
//   //   price: '0',
//   //   finalPrice: '0',
//   // ),
//   // CoursesModel(
//   //   id: '8',
//   //   title: 'مدیریت وضعیت با Provider',
//   //   description: 'یادگیری مدیریت وضعیت با استفاده از Provider در فلاتر.',
//   //   buyStatus: 'غیر رایگان',
//   //   price: '180',
//   //   finalPrice: '150',
//   // ),
//   // CoursesModel(
//   //   id: '9',
//   //   title: 'انیمیشن در فلاتر',
//   //   description: 'افزودن انیمیشن‌های حرفه‌ای به اپلیکیشن‌های فلاتر.',
//   //   buyStatus: 'رایگان',
//   //   price: '0',
//   //   finalPrice: '0',
//   // ),
//   // CoursesModel(
//   //   id: '10',
//   //   title: 'ساخت اپلیکیشن فروشگاهی',
//   //   description: 'تمرین عملی ساخت اپ فروشگاهی با فلاتر و فایربیس.',
//   //   buyStatus: 'غیر رایگان',
//   //   price: '400',
//   //   finalPrice: '350',
//   // ),
// ];
