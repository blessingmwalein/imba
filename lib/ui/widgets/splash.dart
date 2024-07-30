import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/bloc/user/user_state.dart';
import 'package:mac_address/mac_address.dart';

import '../../bloc/user/user_bloc.dart';
import '../../secure_storage/secure_storage_manager.dart';
import 'custom_elevated_button.dart';
import 'loading_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SecureStorageManager _secureStorageManager = SecureStorageManager();
  var initialValue = "false";

  Future<String> getIsAcceptedValue() async {
    return await _secureStorageManager.isAcceptedTerms();
  }

  String _deviceMAC = '';

  // Platform messages are async in nature
  // that's why we made a async function.
  Future<String> initMacAddress() async {
    String macAddress = '';
    try {
      macAddress = await GetMac.macAddress;
      print("mac address $macAddress");
      setState(() => _deviceMAC = macAddress);
    } on PlatformException {
      'Error getting the MAC address.';
    }
    return macAddress;
  }

  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    getIsAcceptedValue().then((value) => {
          if (value == 'true')
            {Navigator.pushNamed(context, '/home')}
          else
            {
              initMacAddress().then(
                  (value) => userBloc.add(CreateUserEvent(macAddress: value)))
            }
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is CreateUserInitialState) {
            return const LoadingIndicator(page: "splash");
          }
          if (state is CreateUserLoadingState) {
            return const LoadingIndicator();
          } else if (state is CreateUserSuccessState) {
            _secureStorageManager
                .getToken()
                .then((value) => print("This is the tokennnn" + value));
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushNamed(context, '/terms');
            });
          } else if (state is CreateUserFailedState) {
            return CustomElevateButton(
                name: 'Relaunch App',
                color: Colors.black,
                onSubmit: () =>
                    userBloc.add(CreateUserEvent(macAddress: _deviceMAC)));
          }
          return const LoadingIndicator(page: "splash");
          // return Container();
        }),
      ),
    );
  }
}
