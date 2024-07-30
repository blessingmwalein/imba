import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/user/user_event.dart';
import 'package:imba/utilities/encrypt_utils.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../../utilities/constants.dart';
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
  var emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final UserBloc userBloc;
  @override
  void initState() {
    // TODO: implement initState
    userBloc = BlocProvider.of<UserBloc>(context);
    _firstNameController.text =
        userBloc.firstName == "" ? "" : decryptAES(userBloc.firstName, key);
    _lastnameController.text =
        userBloc.lastName == "" ? "" : decryptAES(userBloc.lastName, key);
    _nationalIdController.text =
        userBloc.nationalId == "" ? "" : decryptAES(userBloc.nationalId, key);
    emailController.text =
        userBloc.email == "" ? "" : decryptAES(userBloc.email, key);
    _phoneNumberController.text = userBloc.userPhoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    _firstNameController.dispose();
    _lastnameController.dispose();
    _nationalIdController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorConstants.yellow,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.5,
            child: Column(
              children: [
                //   ),
                Container(
                  width: double.infinity,
                  height: 50,
                ),
                CustomOpaqueContainer(
                  //name: "IMBA",
                  name: "NYUMBA",
                  googleFontStyle: GoogleFonts.montserrat(
                      fontSize: 60.sp,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        readOnly: false,
                        hintText: '',
                        labelText: 'Firstname',
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter firstname';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      CustomTextField(
                        readOnly: false,
                        hintText: '',
                        labelText: 'Lastname',
                        controller: _lastnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter lastname';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      CustomTextField(
                          readOnly: false,
                          hintText: '',
                          labelText: 'National ID',
                          controller: _nationalIdController,
                          onChanged: (value) {
                            if (formKey.currentState!.validate()) {}
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter nationalId';
                            }
                            return null;
                          }),
                      CustomTextField(
                        readOnly: false,
                        hintText: '',
                        labelText: 'Phone Number',
                        // type: TextInputType.number,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact';
                          }
                          if (!value.startsWith("+")) {
                            return 'enter country code';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      CustomTextField(
                        readOnly: false,
                        hintText: '',
                        labelText: 'Email',
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return "invalid email";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 150,
                  child: BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UpdateUserSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Updated profile'),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                      if (state is CreateUserFailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('failed to update profile'),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    },
                    child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                      if (state is CreateUserLoadingState) {
                        return const LoadingIndicator();
                      }
                      if (state is UpdateUserSuccessState) {
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          Navigator.pop(context);
                          BlocProvider.of<UserBloc>(context)
                              .add(GetUserEvent());
                          BlocProvider.of<UserBloc>(context)
                              .add(ResetUserEvent());
                        });
                      }
                      return CustomElevateButton(
                        name: "Submit",
                        color: Colors.black,
                        onSubmit: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<UserBloc>(context).add(
                                UpdateUserEvent(
                                    firstName: _firstNameController.text.trim(),
                                    lastName: _lastnameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phoneNumber:
                                        _phoneNumberController.text.trim(),
                                    nationalId:
                                        _nationalIdController.text.trim()));
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
