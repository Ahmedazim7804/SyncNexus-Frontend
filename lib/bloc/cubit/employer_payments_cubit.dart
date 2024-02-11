import 'package:bloc/bloc.dart';
import 'package:worker_app/models/payment_model.dart';
import 'package:worker_app/provider/user_endpoints.dart';
import 'package:intl/intl.dart';

part 'employer_payments_state.dart';

class EmployerPaymentsCubit extends Cubit<EmployerPaymentsState> {
  EmployerPaymentsCubit() : super(EmployerPaymentsLoading()) {
    getAllPayments();
  }

  late List<Payment> payments;

  void getAllPayments() async {
    final List<Payment> allPayments = [];

    final rawPayments =
        await getPayments(DateTime.parse("2000-01-01"), DateTime.now());

    DateFormat dateFormat = DateFormat('MMMM dd, yyyy HH:MM');
    for (final rawPayment in rawPayments) {
      final String createdAt =
          dateFormat.format(DateTime.parse(rawPayment['created_at']));

      Payment payment = Payment(
          paymentId: rawPayment['id'],
          amount: rawPayment['amount'],
          paidBy: rawPayment['from_user_id'],
          paidTo: rawPayment['to_user_id'],
          currency: rawPayment['currency'],
          remarks: rawPayment['remarks'],
          createdAt: createdAt,
          approvedAt: rawPayment['approved_at']);

      allPayments.add(payment);
    }

    payments = allPayments;

    emit(EmployerPaymentsLoaded());
  }
}
