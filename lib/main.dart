import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:imba/bloc/activate/activate_bloc.dart';
import 'package:imba/bloc/appointment/appointment_bloc.dart';
import 'package:imba/bloc/lease/lease_bloc.dart';
import 'package:imba/data/data_providers/user_api.dart';
import 'package:imba/secure_storage/secure_storage_manager.dart';

import 'bloc/actions/actions_bloc.dart';
import 'bloc/approve/approve_bloc.dart';
import 'bloc/payment/payment_bloc.dart';
import 'bloc/upload/upload_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc/views/views_bloc.dart';
import 'data/data_providers/actions_api.dart';
import 'data/data_providers/appointment_api.dart';
import 'data/data_providers/lease_api.dart';
import 'data/data_providers/payment_api.dart';
import 'data/data_providers/upload_api.dart';
import 'data/data_providers/viewed_api.dart';
import 'data/models/classifications_response.dart';
import 'data/models/types_response.dart';
import 'data/repositories/actions_repo.dart';
import 'data/repositories/appointment_repo.dart';
import 'data/repositories/create_user_repo.dart';
import 'data/repositories/lease_repo.dart';
import 'data/repositories/payment_repo.dart';
import 'data/repositories/upload_repo.dart';
import 'data/repositories/views_repo.dart';
import 'ui/router/app_router.dart';
import 'ui/widgets/custom_theme.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  static final UploadApi _uploadApi = UploadApi(
    httpClient: http.Client(),
  );
  static final UserApi _userApi = UserApi(httpClient: http.Client());
  static final AppointmentApi _appointmentApi =
      AppointmentApi(httpClient: http.Client());
  static final ActionsApi _actionsApi = ActionsApi(httpClient: http.Client());

  static final PaymentApi _paymentApi = PaymentApi(httpClient: http.Client());

  static final ViewedApi _viewedApi = ViewedApi(httpClient: http.Client());
  static final LeaseApi _leaseApi = LeaseApi(httpClient: http.Client());

  static final SecureStorageManager _secureStorageManager =
      SecureStorageManager();

  final _uploadBloc = UploadBloc(
      uploadRepositoryImpl: UploadRepositoryImpl(
        api: _uploadApi,
      ),
      storage: _secureStorageManager,
      classifications: ClassificationsResponse(classifications: []),
      types: TypesResponse(types: []));

  final _userBloc = UserBloc(
    userRepositoryImpl: UserRepositoryImpl(
      api: _userApi,
    ),
    userPhoneNumber: "",
    storage: _secureStorageManager,
    nationalId: '',
    email: '',
    lastName: '',
    firstName: '',
  );

  final _activateBloc = ActivateBloc(
      uploadRepositoryImpl: UploadRepositoryImpl(
        api: _uploadApi,
      ),
      storage: _secureStorageManager);

  final _appointmentBloc = AppointmentBloc(
      appointmentRepositoryImpl: AppointmentRepositoryImpl(
        api: _appointmentApi,
      ),
      storage: _secureStorageManager);
  final _approveBloc = ApproveBloc(
      appointmentRepositoryImpl: AppointmentRepositoryImpl(
        api: _appointmentApi,
      ),
      storage: _secureStorageManager);

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

  final _leaseBloc = LeaseBloc(
    leaseRepositoryImpl: LeaseRepositoryImpl(
      api: _leaseApi,
    ),
    storage: _secureStorageManager,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(431, 767),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _uploadBloc,
                ),
                BlocProvider.value(
                  value: _userBloc,
                ),
                BlocProvider.value(
                  value: _activateBloc,
                ),
                BlocProvider.value(value: _appointmentBloc),
                BlocProvider.value(value: _actionsBloc),
                BlocProvider.value(value: _paymentBloc),
                BlocProvider.value(value: _viewedBloc),
                BlocProvider.value(value: _leaseBloc),
                BlocProvider.value(
                  value: _approveBloc,
                ),
              ],
              child: MaterialApp(
                // ignore: deprecated_member_use
                useInheritedMediaQuery: true,
                debugShowCheckedModeBanner: false,
                // title: 'IMBA',
                title: 'NYUMBA',
                theme: CustomTheme.lightTheme,
                onGenerateRoute: _appRouter.onGenerateRoute,
              ),
            ));
  }
}
