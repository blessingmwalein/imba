
import '../data_providers/user_api.dart';
import '../models/user_response.dart';

abstract class UserRepository {
  Future<String> getToken({required String macAddress});

  Future<UserResponse> updateUser({required String firstName,
    required String nationalId,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String token});

  Future<UserResponse> getUser({required String token});
}
class UserRepositoryImpl implements UserRepository {
  final UserApi api;

  UserRepositoryImpl({required this.api});

  @override
  Future<String> getToken({required String macAddress}) async {
    return await api.getToken(macAddress);
  }

  @override
  Future<UserResponse> updateUser(
      {required String firstName,
      required String nationalId,
      required String lastName,
      required String email,
      required String phoneNumber,
      required String token}) async {
    return await api.updateUser(
        firstName, lastName, nationalId, phoneNumber, email, token);
  }

  @override
  Future<UserResponse> getUser({required String token}) async {

    return await api.getUser(token);
  }
}
