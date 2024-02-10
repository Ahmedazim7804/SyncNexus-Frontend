import 'package:worker_app/models/user_model.dart';

class Employee extends User {
  Employee({required name, required phone, required email, required this.id})
      : super(email: email, name: name, phone: phone);
  final String id;
}
