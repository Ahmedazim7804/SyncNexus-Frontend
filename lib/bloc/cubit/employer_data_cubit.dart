import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/employer_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/provider/user_endpoints.dart';
import 'package:equatable/equatable.dart';

part 'employer_data_state.dart';

class EmployerDataCubit extends Cubit<EmployerDataState> {
  EmployerDataCubit() : super(EmployerDataLoading()) {
    getAllData();
  }

  late final Employer employer;
  List<Employee> employeesList = [];
  List jobsList = [];
  List<WorkerTask> tasks = [];

  void getAllData() async {
    await getEmployersData();
    await getAllEmployees();
    emit(EmployerDataLoaded());
  }

  Future<void> getEmployersData() async {
    final data = await getUser();

    employer = Employer(
        name: data['name'],
        phone: data['phone_no'],
        email: data['email'],
        id: data['id']);
  }

  Future<void> getAllEmployees() async {
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
