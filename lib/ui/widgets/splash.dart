import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/user/user_bloc.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/bloc/user/user_state.dart';
import 'package:imba/secure_storage/secure_storage_manager.dart';
import 'package:mac_address/mac_address.dart';
import 'custom_elevated_button.dart';
import 'loading_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SecureStorageManager _secureStorageManager = SecureStorageManager();
  late final UserBloc _userBloc;
  String _deviceMAC = '';

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final isAccepted = await _secureStorageManager.isAcceptedTerms();
    if (isAccepted == 'true') {
      _navigateToHome();
    } else {
      final macAddress = await _initMacAddress();
      _userBloc.add(CreateUserEvent(macAddress: macAddress));
    }
  }

  Future<String> _initMacAddress() async {
    try {
      final macAddress = await GetMac.macAddress;
      setState(() {
        _deviceMAC = macAddress;
      });
      return macAddress;
    } on PlatformException {
      return 'Error getting the MAC address.';
    }
  }

  void _navigateToHome() {
    Navigator.pushNamed(context, '/home');
  }

  void _navigateToTerms() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/terms');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is CreateUserInitialState ||
                state is CreateUserLoadingState) {
              return const LoadingIndicator(page: "splash");
            } else if (state is CreateUserSuccessState) {
              _secureStorageManager.getToken().then(
                    (token) => print("This is the token: $token"),
                  );
              _navigateToTerms();
            } else if (state is CreateUserFailedState) {
              return CustomElevateButton(
                name: 'Relaunch App',
                color: Colors.black,
                onSubmit: () =>
                    _userBloc.add(CreateUserEvent(macAddress: _deviceMAC)),
              );
            }
            return const LoadingIndicator(page: "splash");
          },
        ),
      ),
    );
  }
}
