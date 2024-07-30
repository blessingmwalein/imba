import '../data_providers/terms_api.dart';

abstract class TermsRepository {
  Future<String> getTerms();

  Future<String> acceptTerms({required String token});
}

class TermsRepositoryImpl implements TermsRepository {
  final TermsApi api;

  TermsRepositoryImpl({required this.api});

  @override
  Future<String> getTerms() async {
    return await api.getTerms();
  }

  @override
  Future<String> acceptTerms({required String token}) async {
    return await api.acceptTerms(token);
  }
}
