class CourseSectionModel {
  final String id;
  final String title;
  final String state;
  final String price;
  CourseSectionModel({
    required this.id,
    required this.title,
    required this.state,
    required this.price,
  });

  factory CourseSectionModel.fromJson(Map<String, dynamic> json) {
    return CourseSectionModel(
      id: json["id"].toString(),
      title: json["title"].toString(),
      state: json["price"].toString(),
      price: json["section_buy_status"].toString(),
    );
  }
}

// List<CourseSessonModel> courseSessons = [
//   CourseSessonModel(
//     id: "1",
//     title: "مقدمه دوره",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "2",
//     title: "آموزش نصب محیط توسعه",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "3",
//     idCourse: "1",
//     title: "سینتکس پایه",
//     state: "پولی",
//   ),
//   CourseSessonModel(
//     id: "4",
//     idCourse: "1",
//     title: "توابع و متدها",
//     state: "پولی",
//   ),
//   CourseSessonModel(id: "5", idCourse: "1", title: "پروژه عملی", state: "پولی"),

//   CourseSessonModel(
//     id: "6",
//     idCourse: "2",
//     title: "آشنایی با طراحی UI",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "7",
//     idCourse: "2",
//     title: "اجزای اصلی رابط کاربری",
//     state: "رایگان",
//   ),
//   CourseSessonModel(id: "8", idCourse: "2", title: "انیمیشن‌ها", state: "پولی"),
//   CourseSessonModel(id: "9", idCourse: "2", title: "بهینه سازی", state: "پولی"),

//   CourseSessonModel(
//     id: "10",
//     idCourse: "3",
//     title: "مبانی پایگاه داده",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "11",
//     idCourse: "3",
//     title: "نصب و راه اندازی",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "12",
//     idCourse: "3",
//     title: "Query نویسی",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "13",
//     idCourse: "3",
//     title: "مدیریت تراکنش‌ها",
//     state: "پولی",
//   ),
//   CourseSessonModel(
//     id: "14",
//     idCourse: "3",
//     title: "بهینه‌سازی",
//     state: "پولی",
//   ),

//   CourseSessonModel(
//     id: "15",
//     idCourse: "4",
//     title: "معرفی دوره پیشرفته",
//     state: "رایگان",
//   ),
//   CourseSessonModel(
//     id: "16",
//     idCourse: "4",
//     title: "مفاهیم پیشرفته",
//     state: "پولی",
//   ),
//   CourseSessonModel(
//     id: "17",
//     idCourse: "4",
//     title: "الگوهای طراحی",
//     state: "پولی",
//   ),
// ];
