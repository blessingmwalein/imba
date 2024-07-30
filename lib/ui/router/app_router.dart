import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:imba/bloc/user/user_bloc.dart';
import 'package:imba/data/data_providers/actions_api.dart';
import 'package:imba/data/data_providers/appointment_api.dart';
import 'package:imba/data/data_providers/terms_api.dart';
import 'package:imba/data/data_providers/user_api.dart';
import 'package:imba/data/models/classifications_response.dart';
import 'package:imba/data/models/types_response.dart';
import 'package:imba/data/repositories/create_user_repo.dart';
import 'package:imba/ui/screens/appointments_infinite.dart';
import 'package:imba/ui/screens/home.dart';
import 'package:imba/ui/screens/property_details.dart';
import 'package:imba/ui/screens/terms_conditions.dart';
import 'package:imba/ui/screens/uploads.dart';
import 'package:imba/ui/widgets/appointment_listview.dart';
import 'package:imba/ui/widgets/custom_listview.dart';
import 'package:imba/ui/widgets/splash.dart';

import '../../bloc/actions/actions_bloc.dart';
import '../../bloc/activate/activate_bloc.dart';
import '../../bloc/appointment/appointment_bloc.dart';
import '../../bloc/approve/approve_bloc.dart';
import '../../bloc/payment/payment_bloc.dart';
import '../../bloc/terms_conditions/terms_bloc.dart';
import '../../bloc/upload/upload_bloc.dart';
import '../../bloc/views/views_bloc.dart';
import '../../data/data_providers/payment_api.dart';
import '../../data/data_providers/upload_api.dart';
import '../../data/data_providers/viewed_api.dart';
import '../../data/repositories/actions_repo.dart';
import '../../data/repositories/appointment_repo.dart';
import '../../data/repositories/payment_repo.dart';
import '../../data/repositories/terms_repo.dart';
import '../../data/repositories/upload_repo.dart';
import '../../data/repositories/views_repo.dart';
import '../../secure_storage/secure_storage_manager.dart';
import '../screens/actions_options.dart';
import '../screens/appointment.dart';
import '../screens/edit_property.dart';
import '../screens/register.dart';
import '../screens/upload_details.dart';
import '../screens/upload_images.dart';
import '../screens/viewed.dart';

class AppRouter {
  static final UserApi _api = UserApi(httpClient: http.Client());
  static final TermsApi _termsApi = TermsApi(httpClient: http.Client());

  static final UploadApi _uploadApi = UploadApi(httpClient: http.Client());
  static final AppointmentApi _appointmentApi =
      AppointmentApi(httpClient: http.Client());
  static final ActionsApi _actionsApi = ActionsApi(httpClient: http.Client());
  static final PaymentApi _paymentApi = PaymentApi(httpClient: http.Client());
  static final ViewedApi _viewedApi = ViewedApi(httpClient: http.Client());

  static final SecureStorageManager _secureStorageManager =
      SecureStorageManager();

  var classifications = ClassificationsResponse(classifications: []);

  final _userBloc = UserBloc(
    userRepositoryImpl: UserRepositoryImpl(
      api: _api,
    ),
    userPhoneNumber: "",
    storage: _secureStorageManager,
    nationalId: '',
    email: '',
    lastName: '',
    firstName: '',
  );

  final _termsBloc = TermsBloc(
    termsRepositoryImpl: TermsRepositoryImpl(
      api: _termsApi,
    ),
    storage: _secureStorageManager,
  );

  final _uploadBloc = UploadBloc(
    uploadRepositoryImpl: UploadRepositoryImpl(
      api: _uploadApi,
    ),
    storage: _secureStorageManager,
    classifications: ClassificationsResponse(classifications: []),
    types: TypesResponse(types: []),
  );
  final _activateBloc = ActivateBloc(
    uploadRepositoryImpl: UploadRepositoryImpl(
      api: _uploadApi,
    ),
    storage: _secureStorageManager,
  );

  final _appointmentBloc = AppointmentBloc(
    appointmentRepositoryImpl: AppointmentRepositoryImpl(
      api: _appointmentApi,
    ),
    storage: _secureStorageManager,
  );
  final _approveBloc = ApproveBloc(
    appointmentRepositoryImpl: AppointmentRepositoryImpl(
      api: _appointmentApi,
    ),
    storage: _secureStorageManager,
  );

  final _actionsBloc = ActionsBloc(
    actionsRepositoryImpl: ActionsRepositoryImpl(
      api: _actionsApi,
    ),
    storage: _secureStorageManager,
  );

  final _paymentBloc = PaymentBloc(
    paymentRepositoryImpl: PaymentRepositoryImpl(
      api: _paymentApi,
    ),
    storage: _secureStorageManager,
  );

  final _viewedBloc = ViewedBloc(
    viewedRepositoryImpl: ViewedRepositoryImpl(
      api: _viewedApi,
    ),
    storage: _secureStorageManager,
  );

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _userBloc,
            ),
          ], child: const Splash()),
        );
      case '/terms':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _termsBloc,
            ),
          ], child: const TermsAndConditions()),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _uploadBloc,
            ),
          ], child: const Home()),
        );
      case '/upload':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _uploadBloc,
                ),
              ],
              child: const UploadDetails(
                classifications: [],
                types: [],
              )),
        );

      case '/uploadsList':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _uploadBloc,
            ),
          ], child: const UploadsList()),
        );
      case '/editUpload':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _uploadBloc,
                ),
              ],
              child: const EditProperty(
                deposit: 0,
                houseId: 0,
                occupationDate: '',
                occupied: false,
                rent: 0,
              )),
        );

      case '/registerUser':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _userBloc,
            ),
            BlocProvider.value(
              value: _uploadBloc,
            ),
          ], child: const Register()),
        );
      case '/uploadImages':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _userBloc,
                ),
                BlocProvider.value(
                  value: _uploadBloc,
                ),
                BlocProvider.value(
                  value: _activateBloc,
                ),
              ],
              child: const UploadImages(
                homeAddress: '',
                houseId: 0,
                type: '',
              )),
        );
      case '/customListView':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _activateBloc,
            ),
          ], child: const CustomListView(uploadsResponse: [])),
        );
      case '/appointment':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _appointmentBloc,
            ),
          ], child: const Appointment()),
        );

      case '/appointmentListView':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _appointmentBloc,
            ),
            BlocProvider.value(
              value: _approveBloc,
            ),
          ], child: const AppointmentListView(requestsList: [])),
        );

      case '/appointmentList':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _appointmentBloc,
            ),
          ], child: const AppointmentInfinite()),
        );
      case '/actions':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _actionsBloc,
            ),
          ], child: const ActionsOptions()),
        );

      case '/payment':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _paymentBloc,
                ),
              ],
              child: const PropertyDetails(
                flag: '',
                id: 0,
              )),
        );

      case '/viewed':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(value: _viewedBloc),
            BlocProvider.value(value: _uploadBloc),
            BlocProvider.value(value: _activateBloc),
          ], child: const Viewed()),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _userBloc,
            ),
          ], child: const Splash()),
        );
    }
  }

  void dispose() {
    _userBloc.close();
    _termsBloc.close();
    _uploadBloc.close();
    _activateBloc.close();
    _appointmentBloc.close();
    _actionsBloc.close();
  }
}
