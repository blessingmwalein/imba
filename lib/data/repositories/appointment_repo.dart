import 'package:imba/data/models/meeting_request_response.dart';

import '../data_providers/appointment_api.dart';
import '../models/appointment_response.dart';
import '../models/approve_response.dart';

abstract class AppointmentRepository {
  Future<AppointmentResponse> reserve(
      String token, int houseId, String startDate, String endDate);

  Future<MeetingRequestsResponse> getMeetingAndRequest(
      String token);


Future<ApproveResponse> approveRequest(
    String token, int requestId, bool approved);
}




class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentApi api;

  AppointmentRepositoryImpl({required this.api});

  @override
  Future<AppointmentResponse> reserve(
      String token, int houseId, String startDate, String endDate) async {
    return await api.reserve(token, houseId, startDate, endDate);
  }

  @override
  Future<MeetingRequestsResponse> getMeetingAndRequest(String token) async {

    return await api.getMeetingAndRequest(token);
  }

  @override
  Future<ApproveResponse> approveRequest(String token, int requestId, bool approved) async{
    return await api.approveRequest(token, requestId, approved);
  }


}
