import 'package:flutter/material.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';

class EmployersDataProvider extends ChangeNotifier {
  EmployersDataProvider() {
    getAllEmployees();
  }
  List<Employee> employeesList = [];
  List jobsList = [];
  List<WorkerTask> tasks = [];

  void getAllEmployees() async {
    await getEmployees().then((employeesListUnparsed) {
      for (var employee in employeesListUnparsed) {
        employeesList.add(Employee(
            name: employee['name'],
            phone: employee['phone_no'],
            email: ' ', //employee[''],
            id: employee['employee_id']));
      }
    });
  }

  void getAllJobs() {}

  void getAllTasks() {}
}
