import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/screens/register.dart';
import 'package:imba/ui/screens/uploads.dart';
import 'package:imba/utilities/constants.dart';
import 'package:intl/intl.dart';

import '../../bloc/upload/upload_bloc.dart';
import '../../bloc/upload/upload_event.dart';
import '../../bloc/upload/upload_state.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_formatter.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';
import '../widgets/property_error_widget.dart';

class EditProperty extends StatefulWidget {
  final int houseId;
  final String occupationDate;
  final int rent;
  final int deposit;
  final bool occupied;

  const EditProperty(
      {Key? key,
      required this.houseId,
      required this.occupationDate,
      required this.rent,
      required this.deposit,
      required this.occupied})
      : super(key: key);

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  bool isChecked = false;

  DateTime currentDate = DateTime.now();

  final _occupatiionDateController = TextEditingController();
  final _rentController = TextEditingController();
  final _depositController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    isChecked = widget.occupied;
    super.initState();
  }

  final formKey = GlobalKey<FormState>(); //key for form
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _occupatiionDateController.dispose();
    _rentController.dispose();
    _depositController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.deposit);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Container(
                width: 100,
                color: ColorConstants.grey,
                child: Text("EDIT",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: ColorConstants.yellow))),
            actions: [
              IconButton(
                icon: const Logo(
                  imageUrl: 'assets/images/houseicon.png',
                ),
                iconSize: 100,
                onPressed: () {},
              )
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${widget.houseId}",
                          style: GoogleFonts.montserrat(
                              fontSize: 30,
                              decoration: TextDecoration.none,
                              color: ColorConstants.yellow)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      // height:30,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Occupation Date",
                                  style: GoogleFonts.montserrat())),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: _occupatiionDateController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: DateFormat.yMMMMd('en_US')
                                      .format(currentDate),
                                  filled: true,
                                  fillColor: ColorConstants.grey),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                DateFormatter(),
                              ],
                              onChanged: null,
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                    readOnly: false,
                    hintText: '',
                    labelText: 'Rentals',
                    controller: _rentController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter rental';
                    //   }
                    //   return null;
                    // },
                  ),
                  CustomTextField(
                    readOnly: false,
                    hintText: '',
                    labelText: 'Deposit',
                    controller: _depositController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter deposit';
                    //   }
                    //   return null;
                    // },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text('Occupied',
                                style: TextStyle(fontSize: 14))),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          child: BlocListener<UploadBloc, UploadState>(
                              listener: (context, state) {
                            if (state is UploadSuccessState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Edited'),
                                duration: const Duration(seconds: 1),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              ));
                              Navigator.pop(context);
                            }
                            if (state is UploadFailedState) {
                              if (state.message.contains("not registered")) {
                                SchedulerBinding.instance!
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PropertyError(
                                                  errorMessage:
                                                      'Set up profile first')));
                                });
                              }
                            }
                          }, child: BlocBuilder<UploadBloc, UploadState>(
                                  builder: (context, state) {
                            if (state is UploadLoadingState) {
                              return const LoadingIndicator();
                            }
                            if (state is EditUploadSuccessState) {
                              SchedulerBinding.instance!
                                  .addPostFrameCallback((_) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UploadsList()));
                              });
                            }
                            if (state is UploadFailedState) {
                              if (state.message
                                  .contains('Update profile first')) {
                                SchedulerBinding.instance!
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                });
                              }
                            }

                            return CustomElevateButton(
                              name: 'Update',
                              color: ColorConstants.yellow,
                              onSubmit: () {
                                if (formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('updating house'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                                BlocProvider.of<UploadBloc>(context).add(
                                    EditUploadEvent(
                                        token: '',
                                        houseId: widget.houseId,
                                        occupationDate: currentDate.toString(),
                                        rent: _rentController.text,
                                        deposit: _depositController.text,
                                        occupied: isChecked));
                              },
                            );
                          })),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.yellow, // <-- SEE HERE
              onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  TimeOfDay _time = TimeOfDay(
      hour: (DateTime(DateTime.now().hour).hour),
      minute: (DateTime(DateTime.now().minute).minute));

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
