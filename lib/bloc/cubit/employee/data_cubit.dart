import 'package:bloc/bloc.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/employer_model.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/provider/user_endpoints.dart';

part 'data_state.dart';

class EmployeeDataCubit extends Cubit<EmployeeDataState> {
  EmployeeDataCubit() : super(EmployeeDataLoading()) {
    getAllData();
  }

  late final Employee employee;
  late final Employer employer;
  final Map<String, double> location = {
    'lat': 0,
    'long': 0,
  };

  Future<void> getEmployersData() async {
    final data = await getEmployer();

    employer = Employer(
        name: data['name'],
        phone: data['phone_no'],
        email: data['email'],
        id: data['id']);
  }

  void setLocation({required double lat, required double long}) {
    location['lat'] = lat;
    location['long'] = long;
  }

  Future<void> getJobData() async {
    await getEmployeeJob();
  }

  Future<void> getEmployeeData() async {
    final data = await getUser();

    employee = Employee(
        name: data['name'],
        phone: data['phone_no'],
        email: data['email'],
        id: data['id']);
  }

  void getAllData() async {
    await getEmployeeData();
    await getEmployersData();
    await getJobData();
    await employee.getMyTasks();
    emit(EmployeeDataLoaded());
  }
}
