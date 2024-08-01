import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/layouts/home_layout.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../utilities/constants.dart';
import '../../utilities/encrypt_utils.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/opaque_container.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);

    _firstNameController.text = _decryptUserData(_userBloc.firstName);
    _lastNameController.text = _decryptUserData(_userBloc.lastName);
    _nationalIdController.text = _decryptUserData(_userBloc.nationalId);
    _emailController.text = _decryptUserData(_userBloc.email);
    _phoneNumberController.text = _userBloc.userPhoneNumber;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nationalIdController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

String _decryptUserData(String data) {
  try {
    return data.isEmpty ? '' : decryptAES(data, key);
  } catch (e) {
    // If decryption fails, return the original data
    return data;
  }
}
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _userBloc.add(UpdateUserEvent(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        nationalId: _nationalIdController.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      hasBack: true,
      title: "Profile Page",
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.5,
          child: Column(
            children: [
              const SizedBox(height: 50),
               const CircleAvatar(
                    
                      backgroundColor: Colors.grey,
                      radius: 50, // Adjust the size as needed
                      backgroundImage: AssetImage('assets/images/avatar.jpg',),
                    ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _firstNameController,
                      labelText: 'Firstname',
                      validator: _validateNotEmpty,
                    ),
                    CustomTextField(
                      controller: _lastNameController,
                      labelText: 'Lastname',
                      validator: _validateNotEmpty,
                    ),
                    CustomTextField(
                      controller: _nationalIdController,
                      labelText: 'National ID',
                      validator: _validateNotEmpty,
                    ),
                    CustomTextField(
                      controller: _phoneNumberController,
                      labelText: 'Phone Number',
                      validator: _validatePhoneNumber,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      validator: _validateEmail,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 65,
                width: double.infinity,
                child: BlocListener<UserBloc, UserState>(
                  listener: _handleStateChanges,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is CreateUserLoadingState) {
                        return const LoadingIndicator();
                      }
                      return CustomElevateButton(
                        name: "Submit",
                        color: Colors.black,
                        onSubmit: _onSubmit,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter contact';
    }
    if (!value.startsWith("+")) {
      return 'Enter country code';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  void _handleStateChanges(BuildContext context, UserState state) {
    if (state is UpdateUserSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Updated profile'),
        duration: Duration(seconds: 3),
      ));
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        _userBloc.add(GetUserEvent());
        _userBloc.add(ResetUserEvent());
      });
    } else if (state is CreateUserFailedState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update profile'),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
