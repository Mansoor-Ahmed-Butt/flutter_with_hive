
import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/responsive.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';


bool isDebug = true;

String globalApiLink = "https://dev3.globalgroup.co/api/v2/";
String globalAdminApiLink = "https://admindev.globalgroup.co/api/v2/";
String apiLink = "https://payrolldev.globalgroup.co/api/v2/";
String companyname = "Technupur";
String fontFamily = "Montserrat";
RxBool isLoggingInInvitedUser = false.obs;
String referralCode = "";
String appVersion = "Dev - 0.1.1";
RxString selectedMenuItem = "".obs;

String fileName = "payrollSummaryHistory";

List<String> minutesList = List.generate(60, (index) => index.toString().padLeft(2, '0'));
List<String> hours12List = List.generate(25, (index) => (index).toString().padLeft(2, '0'));
List<String> meridiem = ['AM', 'PM'];
bool isValidPhoneNumber(String phonenumber) {
  String pattern = r'^[+]?[0-9]{1,4}[ -]?[0-9]{3}[ -]?[0-9]{3}[ -]?[0-9]{3}$';
  RegExp regexph = RegExp(pattern);
  return regexph.hasMatch(phonenumber);
}

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  if (hex.length == 3) {
    hex = hex.split("").map((char) => char * 2).join();
  }
  if (hex.length == 6) {
    hex = "FF$hex";
  }
  return Color(int.parse(hex, radix: 16));
}

String formateAmount(double amount) {
  if (amount < 0) {
    double newAmount = amount * -1;
    var formatter = NumberFormat('###,###,###,###,##0.00');
    String fromated = formatter.format(newAmount);
    return "($fromated)";
  } else {
    var formatter = NumberFormat('###,###,###,###,##0.00');
    return formatter.format(amount);
  }
}

String globalForamteDate(String date) {
  // List listdate = date.split("T");
  DateTime billDate1 = DateTime.parse(date);
  String formatedDate = DateFormat('MM/dd/yyyy').format(billDate1);
  return formatedDate;
}

String formatUSPhoneNumber(String phone) {
  if (phone.length == 11 && phone.startsWith('1')) {
    phone = phone.substring(1);
  }

  if (phone.length == 10) {
    return '(${phone.substring(0, 3)}) '
        '${phone.substring(3, 6)}-'
        '${phone.substring(6, 10)}';
  }
  return phone; // return as-is if not valid
}

//Date difference

DateTime functionTofindDateDifference({DateTime? joiningDate, DateTime? currentDate}) {
  DateTime? differenceOfYears;
  DateTime joiningDate = DateTime(1996, 12, 25);
  DateTime currentDate = DateTime(2025, 5, 19);
  int years = currentDate.year - joiningDate.year;
  int months = currentDate.month - joiningDate.month;
  int days = currentDate.day - joiningDate.day;
  // Adjust for negative values
  if (days < 0) {
    months -= 1;
    final prevMonth = DateTime(currentDate.year, currentDate.month, 0); // last day of previous month
    days += prevMonth.day;
  }
  if (months < 0) {
    years -= 1;
    months += 12;
  }
  print('You are $years years, $months months, and $days days old.');
  return differenceOfYears = DateTime(years, months, days);
}

double parseDollarAmount(String value) {
  final cleaned = value.replaceAll(r'$', '').replaceAll(',', '').trim();
  return cleaned.isEmpty ? 0.0 : double.tryParse(cleaned) ?? 0.0;
}

int contractorId = 19;
int companyIdEmployee = 20;
RxBool stepsCompleted = false.obs;
// int companyIdForTimeSheet = 22;
// int companyIdForContractorTimeSheet = 30;
RxList dropDownValuesforSave = [
  "Save and New",
].obs;
RxList dropDownValuesforSaveAndClose = [
  "Save and Close",
].obs;
bool isUserAlreadyLogedin = false;
String formateDatewithTime(String value) {
  // printLog("Function called of formated date and value is $value");
  String formattedDate = "";
  try {
    formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.parse(value));
  } catch (e) {
    formattedDate = value;
  }
  // printLog("Formatted return date is $formattedDate");
  return formattedDate;
}

String formateDateForPaySchedule(String date) {
  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(date);

  // Format to desired output
  String formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);
  return formattedDate;
}

// String formatReportNumberStyle(String text, String selectedStyle, bool dividedBy1000, bool withoutCents, {bool noDollarSign = false, bool isFromReportSide = false}) {
//   // printLog("dividedBy1000=====$dividedBy1000");
//   if (text.contains("\$")) {
//     text = text.replaceAll("\$", "");
//   }
//   if (text.contains(",")) {
//     text = text.replaceAll(",", "");
//   }
//   if (isFromReportSide && ((double.tryParse(text) == 0.00) || text.toString() == "null" || text.toString() == "")) {
//     printLog("isFromReportSide is true and amount is 0.00 and prefence is ${PreferencesData.preferencesReports["sectionMainForth"]["radioGroupValue"]}");
//     if (((PreferencesData.preferencesReports["sectionMainForth"] ?? {})["radioGroupValue"]) == 1) {
//       return "${currencyUnit}0.00";
//     } else if (((PreferencesData.preferencesReports["sectionMainForth"] ?? {})["radioGroupValue"]) == 2) {
//       return "$currencyUnit-";
//     } else if (((PreferencesData.preferencesReports["sectionMainForth"] ?? {})["radioGroupValue"]) == 4) {
//       return "";
//     } else {
//       return "-";
//     }
//     // return noDollarSign ? '-' : '$currencyUnit-';
//   }

//   String copyText = text;
//   if (withoutCents) {
//     copyText = copyText.split(".").first;
//   }
//   double amount = double.parse(copyText == "" || copyText == "null" ? "0" : copyText);
//   var formatter = NumberFormat('###,###,###,###,##0.00');
//   copyText = formatter.format(amount);

//   if (dividedBy1000) {
//     // double amount = double.parse(copyText == "" || copyText == "null" ? "0" : copyText);

//     amount = amount / 1000;

//     // var formatter = NumberFormat('###,###,###,###,##0.00');
//     copyText = formatter.format(amount);

//     // printLog("copyText========$copyText");
//   }

//   if (withoutCents) {
//     copyText = copyText.split(".").first;
//   }
//   // double amount = 0;

//   if ((double.tryParse(text) ?? 0) < 0) {
//     // if (selectedStyle == CustomizationController.to.localNegativeNumberStyleOptions[1]) {
//     //   copyText = "(${copyText.toString()})";

//     // }

//     if (selectedStyle == CustomizationController.to.localNegativeNumberStyleOptions[1]) {
//       // Remove the first occurrence of the negative sign.
//       String formattedText = copyText.toString();

//       if (copyText.toString().contains("-")) {
//         formattedText = copyText.toString().replaceFirst('-', '');
//       }
//       // else{

//       // }
//       // Wrap the result in parentheses.
//       copyText = "($formattedText)";
//     } else if (selectedStyle == CustomizationController.to.localNegativeNumberStyleOptions[2]) {
//       copyText = "${copyText.substring(1)}-";
//     } else if (selectedStyle == CustomizationController.to.localNegativeNumberStyleOptions[3]) {
//       copyText = copyText.substring(1);
//     }
//   }

//   if (amount == 0) {
//     return noDollarSign ? '-' : '$currencyUnit-';
//   }

//   // printLog("${noDollarSign ? "" : currencyUnit}$copyText");

//   // return (AppFunctions.formateAmount(copyText, addCurrency: true));
//   return "${noDollarSign ? "" : currencyUnit}$copyText";
// }

// int fontSizeTextToFontSizeValueForInvoiceTemplatePdf(String size) {
//   if (size == CustomizationController.to.localFontSizeOptionsForInvoiceTemplate[0]) {
//     return 6;
//   } else if (size == CustomizationController.to.localFontSizeOptionsForInvoiceTemplate[1]) {
//     return 7;
//   } else if (size == CustomizationController.to.localFontSizeOptionsForInvoiceTemplate[2]) {
//     return 9;
//   } else if (size == CustomizationController.to.localFontSizeOptionsForInvoiceTemplate[3]) {
//     return 12;
//   } else {
//     return 9;
//   }
// }

// FontWeight fontWeightTextToFontWeightValue(String weight) {
//   if (weight == CustomizationController.to.localFontWeightOptions[0]) {
//     return FontWeight.normal;
//   } else if (weight == CustomizationController.to.localFontWeightOptions[1]) {
//     return FontWeight.bold;
//   } else {
//     return FontWeight.normal;
//   }
// }

// FontStyle fontStyleTextToFontStyle(String style) {
//   if (style == CustomizationController.to.localFontStyleOptions[0]) {
//     return FontStyle.normal;
//   } else if (style == CustomizationController.to.localFontStyleOptions[1]) {
//     return FontStyle.italic;
//   } else {
//     return FontStyle.normal;
//   }
// }

///
extension CustomUtils on num {
  double get cH => double.parse(toString());
  double get cW => double.parse(toString());
  double get cSP => double.parse(toString());
  double get cTS => double.parse(toString());
  double get cSPE => double.parse(toString());
  double get cHE => double.parse(toString());
  double get cWE => double.parse(toString());
  double get cRE => double.parse(toString());
  double get h => double.parse(toString());
  double get r => double.parse(toString());
  double get w => double.parse(toString());
  double get sp => double.parse(toString());
  double get spMax => double.parse(toString());
}

///////////////////////////////
// Added for profile data
extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

String formateAmountFromString(String text) {
  double amount = double.parse(text == "" || text == "null" ? "0" : text);

  if (amount < 0) {
    double newAmount = amount * -1;
    var formatter = NumberFormat('###,###,###,###,##0.00');
    String fromated = formatter.format(newAmount);
    return "($fromated)";
  } else {
    var formatter = NumberFormat('###,###,###,###,##0.00');
    return formatter.format(amount);
  }
}

String currencyUnit = "\$";
String formateAmountFromStringWithCurrency(String text) {
  double amount = double.parse(text == "" || text == "null" ? "0" : text);

  if (amount < 0) {
    double newAmount = amount * -1;
    var formatter = NumberFormat('###,###,###,###,##0.00');
    String fromated = formatter.format(newAmount);
    return "($fromated)";
  } else {
    var formatter = NumberFormat('###,###,###,###,##0.00');
    return (currencyUnit + formatter.format(amount));
  }
}

List idsListofUploadedImages = []; // List of uploaded Attachment ids
List imageofCollatralIds = [];
List loanDocumentsIds = [];
List loanNoticesIds = [];
int orgId = 0;
////////////////////////////////////////////////////////////////////////////
String calculateAge(String dob) {
  try {
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age.toString();
  } catch (e) {
    return "";
  }
}

String formatReadableDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMMM d, y').format(dateTime); // e.g. April 25, 2025
}

String formatDurationFromDate(String dateTimeString) {
  DateTime fromDate = DateTime.parse(dateTimeString);
  DateTime now = DateTime.now();

  int years = now.year - fromDate.year;
  int months = now.month - fromDate.month;
  int days = now.day - fromDate.day;

  if (days < 0) {
    final prevMonth = DateTime(now.year, now.month, 0); // last day of prev month
    days += prevMonth.day;
    months -= 1;
  }

  if (months < 0) {
    months += 12;
    years -= 1;
  }

  return '${years}yrs - ${months}m - $days days';
}

String formatDateForEmployee(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String daySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final day = date.day;
  final suffix = daySuffix(day);
  final formatted = DateFormat('MMMM d, y').format(date);
  return formatted.replaceFirst('$day,', '$day$suffix,');
}

String formatFileSize(int size) {
  const int kb = 1024;
  const int mb = kb * 1024;
  const int gb = mb * 1024;

  if (size >= gb) {
    return "${(size / gb).toStringAsFixed(2)} GB";
  } else if (size >= mb) {
    return "${(size / mb).toStringAsFixed(2)} MB";
  } else if (size >= kb) {
    return "${(size / kb).toStringAsFixed(2)} KB";
  } else {
    return "$size bytes";
  }
}

String formatDateWithController(String inputDate) {
  try {
    DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(inputDate);

    String formattedDate = DateFormat("d MMMM, yyyy").format(parsedDate);

    return formattedDate;
  } catch (e) {
    return "Invalid date format";
  }
}

// Future<Map> verifyAddressFromApi(BuildContext context, dynamic address1, dynamic address2, dynamic city, dynamic zip, dynamic state, dynamic country) async {
//   printLog("Inside The Address Validation Api Call");
//   dynamic addressData = {
//     "addressLine1": address1.text.trim(),
//     "addressLine2": address2.text.trim(),
//     "CountryId": country?["id"] ?? 0,
//     "StateId": state?["id"] ?? 0,
//     "city": city.text.trim(),
//     "zip": zip.text.trim(),
//   };
//   printLog("Data: ====================>    $addressData");
//   ProgressDialogCustom(context).show();
//   ResponseModel response = await APIsCallPost.submitRequest(
//     ApiUrls.validataAddress,
//     addressData,
//   );
//   ProgressDialogCustom(context).hide();

//   var res = jsonDecode(response.data);
//   if (response.statusCode == 200 || response.statusCode == 201) {
//     printLog("Response from Address Validation: $res");

//     return res;
//   }

//   return res;
// }

String formatDateWithTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  int hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
  String period = dateTime.hour >= 12 ? 'PM' : 'AM';

  String formattedDate = "${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}/${dateTime.year}";
  String formattedTime = "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";

  return "$formattedDate, $formattedTime";
}

// globalEasyLoadingToast(String message, {bool isShowCenter = false}) {
//   EasyLoading.showToast(message, toastPosition: isShowCenter ? EasyLoadingToastPosition.center : EasyLoadingToastPosition.bottom);
// }

getListToShow(List list) {
  //return a list where isShow value is true
  return list.where((element) => element.isShow == true).toList();
}

getListToShowEntry(List list) {
  //return a list where isShow value is true
  return list.where((element) => element["isShow"] == true).toList();
}

double lastCalculated = 210.w;
double lastCalculatedHeader = 90;
double lastCalculatedTabel = 0.w;

double getWidth(context, {bool isTables = false}) {
  if (isTables) {
    // double idealWidth = MediaQuery.of(context).size.height * 1.77777777778;
    double idealWidth = 1920;
    // print(idealWidth.toString() + " " + (MediaQuery.of(context).size.width.toString()));
    if (MediaQuery.of(context).size.width < idealWidth) {
      double difference = (idealWidth - MediaQuery.of(context).size.width);
      if (difference <= 380) {
        lastCalculatedTabel = difference + 75;
      } else {
        lastCalculatedTabel = difference - (difference - 380);
      }
    } else {
      lastCalculatedTabel = 0;
    }
    // print(lastCalculatedTabel);
    return MediaQuery.of(context).size.width + lastCalculatedTabel;
  } else {
    return MediaQuery.of(context).size.width;
  }
}

double globalWidthOfFiled(context) {
  return (Responsive.isDesktop(context))
      ? MediaQuery.of(context).size.width * 0.27
      : (Responsive.isTablet(context))
          ? MediaQuery.of(context).size.width * 0.48
          : MediaQuery.of(context).size.width * 0.98;
}

double globalWidthOfFiledAS4(context) {
  return (Responsive.isDesktop(context))
      ? MediaQuery.of(context).size.width * 0.202
      : (Responsive.isTablet(context))
          ? MediaQuery.of(context).size.width * 0.48
          : MediaQuery.of(context).size.width * 0.98;
}

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}


bool isValidUrlWeb(String url) {
  final pattern = r'^(https?:\/\/)?' // optional http or https
      r'(([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})' // domain
      r'(\/[^\s]*)?$'; // optional path
  final regex = RegExp(pattern);

  return regex.hasMatch(url.trim());
}

int countDaysUntil(String dateString) {
  DateTime targetDate = DateTime.parse(dateString);

  DateTime today = DateTime.now();

  int difference = targetDate.difference(today).inDays;

  return difference;
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);

  return formattedDate;
}

// Widget globalNetworkImage(String url, double height, double width, {BoxFit? fit = BoxFit.cover, Function? onTap, String placeHolderName = ""}) {
//   print("url => $url");
//   return FadeInImage(
//     height: height,
//     width: width,
//     fit: fit,
//     imageErrorBuilder: (context, e, stackTrace) => widgetImagePlaceHolder(placeHolderName: placeHolderName),
//     image: NetworkImage(
//       url,
//     ),
//     placeholder: const AssetImage('assets/imgs/logo2.png'),
//   );
// }

String formatTimeFromApi(dynamic timeValue) {
  if (timeValue == null) return "";
  // Convert any input (int, double) to a string
  String timeStr = timeValue.toString();

  // Split the string at the decimal point
  List<String> parts = timeStr.split('.');

  String hours = parts[0];
  String minutes;

  if (parts.length > 1) {
    minutes = parts[1];
    // Pad single-digit minutes with a trailing zero
    if (minutes.length == 1) {
      minutes = '${minutes}0';
    }
  } else {
    // If there's no decimal, minutes are 00
    return timeValue;
  }

  return '$hours:$minutes';
}

String convertDecimalToTime(double decimalHours) {
  if (decimalHours == 0.0) {
    return '-';
  }
  // Get the full hours part (e.g., 1.02 -> 1)
  final int hours = decimalHours.truncate();

  // Get the decimal part and convert it to minutes (e.g., 1.02 -> 0.02 * 60 = 1.2)
  final double fractionalPart = decimalHours - hours;
  final int minutes = (fractionalPart * 60).round();

  // Format the hours and minutes with leading zeros if needed
  final String formattedHours = hours.toString().padLeft(2, '0');
  final String formattedMinutes = minutes.toString().padLeft(2, '0');

  return '$formattedHours:$formattedMinutes';
}

double convertTimeFormatToDecimal(String time) {
  if (time.isEmpty) {
    return 0.0;
  }
  final List<String> parts = time.split('.');

  if (parts.length != 2) {
    return 0.0;
  }

  final int hours = int.parse(parts[0]);
  final int minutes = int.parse(parts[1]);

  return hours + (minutes / 60);
}

bool validateDob(String dobStr) {
  try {
    // Parse string to DateTime
    final parts = dobStr.split('/');
    if (parts.length != 3) return false;

    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final dob = DateTime(year, month, day);
    final now = DateTime.now();

    // Calculate age
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    // Age validation
    return age >= 18 && age <= 80;
  } catch (e) {
    return false; // Invalid format or parsing error
  }
}

bool validateDate(String dobStr) {
  try {
    // Parse string to DateTime
    final parts = dobStr.split('/');
    if (parts.length != 3) return false;

    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final selectedDate = DateTime(year, month, day);

    // Get today (without time part)
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    // Allow today and future dates
    return selectedDate.isAtSameMomentAs(todayDateOnly) || selectedDate.isAfter(todayDateOnly);
  } catch (e) {
    return false; // Invalid format or parsing error
  }
}

String formatHoursStringToHHMM(String hoursString) {
  final double? hours = double.tryParse(hoursString);
  if (hours == null) return "";

  final int hh = hours.floor();
  final int mm = ((hours - hh) * 60).round();
  return '${hh.toString().padLeft(2, '0')}:${mm.toString().padLeft(2, '0')}';
}

String convertDateToISO(String attendanceDate) {
  // Expects: "MM/dd/yyyy"
  final parts = attendanceDate.split('/');
  final formatted = "${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}";
  return formatted;
}

Duration parseTimeToDuration(String input) {
  if (input.contains(':')) {
    final parts = input.split(':');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return Duration(hours: hours, minutes: minutes);
  } else {
    // fallback → treat number as "hours"
    double value = double.tryParse(input) ?? 0;
    return Duration(minutes: (value * 60).round());
  }
}

double parseToDouble(String input) {
  final parts = input.split(':');
  final h = int.tryParse(parts[0]) ?? 0;
  final m = (parts.length > 1) ? (int.tryParse(parts[1]) ?? 0) : 0;
  return h + (m / 60);
}

String convertDateTimeStringToHHMM(String dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('hh:mm').format(dateTime);
    return formattedTime;
  } catch (e) {
    print('Error parsing date: $e');
    return '';
  }
}
