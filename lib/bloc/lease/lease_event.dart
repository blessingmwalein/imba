
import 'package:equatable/equatable.dart';

abstract class LeaseEvent extends Equatable {}

class GetInterestsEvent extends LeaseEvent {
  GetInterestsEvent();

  @override
  List<Object> get props => [];
}

class InterestsResetEvent extends LeaseEvent {
  InterestsResetEvent();

  @override
  List<Object> get props => [];
}

class UpdateLeaseEvent extends LeaseEvent {
  final String maintenance;
  final String notice;
  final String period;
  final String fees;
  final String landLordPhone;
  final String tenantPhone;
  final int leaseId;
  final int houseId;

  UpdateLeaseEvent(
      {required this.maintenance,
        required this.notice,
        required this.period,
        required this.fees,
        required this.landLordPhone,
        required this.tenantPhone,
        required this.leaseId,
        required this.houseId
      });

  @override
  List<Object> get props =>
      [maintenance, notice, period, fees, landLordPhone,tenantPhone, leaseId, houseId];
}