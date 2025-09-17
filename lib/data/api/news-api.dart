import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class NewsApi extends GetConnect {
  Future<Response> GetAllNews() async {
    return post(
      "$ip/all_announcements",
      {},
      headers: {
        "token":
            "eyJhbGciOiJub25lIn0.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTczNjI5MjEyNH0.",
      },
    );
  }
}
