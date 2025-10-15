import 'package:hive/hive.dart';
part "log_in_model.g.dart";
@HiveType(typeId: 0)
class LoginModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;

  LoginModel({required this.email, required this.password});


}
