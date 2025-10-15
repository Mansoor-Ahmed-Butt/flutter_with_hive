import 'package:hive/hive.dart';
part "sign_up_model.g.dart";
@HiveType(typeId: 0)
class SignUpModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String userName;

  SignUpModel({required this.email, required this.password, required this.userName});


}
