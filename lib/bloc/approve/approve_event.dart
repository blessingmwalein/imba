import 'package:equatable/equatable.dart';

abstract class ApproveEvent extends Equatable {}




class ApproveRequestEvent extends ApproveEvent {
  final bool approved;
  final int requestId;


  ApproveRequestEvent({required this.requestId,
    required this.approved
  });

  @override
  List<Object> get props => [
    approved, requestId
  ];
}


class RejectRequestEvent extends ApproveEvent {
  final bool approved;
  final int requestId;


  RejectRequestEvent({required this.requestId,
    required this.approved
  });

  @override
  List<Object> get props => [
    approved, requestId
  ];
}
class ApproveRefreshEvent extends ApproveEvent {
  ApproveRefreshEvent();

  @override
  List<Object> get props => [];
}