
import 'date_util.dart';

String? validateEmail(String? value) {
  if (value!.trim().isEmpty) {
    return "Email is invalid";
  }
/*  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return string("error_email_invalid");
  }*/
  return null;
}


bool validateLink(String value){
  var urlPattern = r"(https?:\/\/)?([\w\d-]+\.)+[\w]{2,}(\/[\w\d-._~:?#[\]@!$&\'()*+,;=]*)?$";
  final pattern = RegExp(urlPattern, caseSensitive: false);

    if (!pattern.hasMatch(value)) {
      return false;
    }
    else {
      return true;
    }
}

bool isValidFromToDate(String fromDate, String toDate) {
  if (fromDate.isNotEmpty && toDate.isNotEmpty) {
    DateTime startTime = SPDateUtils.stringFormat(fromDate, SPDateUtils.FORMAT_DD_MM_YYYY);
    DateTime endTime = SPDateUtils.stringFormat(toDate, SPDateUtils.FORMAT_DD_MM_YYYY);
    if (endTime.isBefore(startTime)) {
      return false;
    } else {
      return true;
    }
  }else{
    return true;
  }
}