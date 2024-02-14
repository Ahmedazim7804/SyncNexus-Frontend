import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/employer_model.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/provider/user_endpoints.dart';
import 'package:equatable/equatable.dart';

part 'data_state.dart';

class EmployerDataCubit extends Cubit<EmployerDataState> {
  EmployerDataCubit() : super(EmployerDataLoading()) {
    getAllData();
  }

  late final Employer employer;
  List<Employee> employeesList = [];
  List<Job> jobsList = [];
  List<WorkerTask> tasks = [];

  void getAllData() async {
    await getEmployersData();
    await getAllEmployees();
    await getAllJobs();
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

  Future<void> getAllJobs() async {
    final List<Job> allJobs = [];
    final rawJobs = await getPostedJobs();

    for (final rawJob in rawJobs) {
      Job job = Job(
          jobId: rawJob['id'],
          title: rawJob['title'],
          desc: rawJob['description'],
          employerId: rawJob['employer_id'],
          amount: rawJob['amount'].toString(),
          done: rawJob['done'] == "null" ? rawJob['done'] : null);

      allJobs.add(job);
    }

    jobsList = allJobs;
  }

  Future<void> freeEmployee(Employee employee) async {
    await removeEmployee(employee.id);
    employeesList.remove(employee);
    emit(EmployerDataLoaded());
  }

  Future<void> bindEmployee(Employee employee) async {
    await addEmployee(employee.id, "_");
    employeesList.add(employee);
    emit(EmployerDataLoaded());
  }

  void getAllTasks() async {}
}
