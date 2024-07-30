import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/bloc/upload/upload_bloc.dart';
import 'package:imba/bloc/upload/upload_state.dart';
import 'package:imba/ui/screens/upload_images.dart';
import 'package:imba/utilities/constants.dart';
import 'package:intl/intl.dart';

import '../../bloc/upload/upload_event.dart';
import '../../bloc/user/user_bloc.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_formatter.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';
import '../widgets/property_error_widget.dart';
import '../widgets/upload_details_header.dart';
import 'uploads.dart';

class UploadDetails extends StatefulWidget {
  final List<String> types;
  final List<String> classifications;

  const UploadDetails(
      {Key? key, required this.types, required this.classifications})
      : super(key: key);

  @override
  State<UploadDetails> createState() => _UploadDetailsState();
}

class _UploadDetailsState extends State<UploadDetails> {
  bool isChecked = false;
  var isBorehole = false;
  var isElectricity = false;
  var isSolar = false;
  var isWater = false;
  var isWalled = false;
  var isTiled = false;
  var isGated = false;
  var isOccupied = false;
  var emailController = TextEditingController();
  final _homeAddressController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _rentalsController = TextEditingController();
  final _roomsController = TextEditingController();
  final _occupatiionDateController = TextEditingController();
  final _extraDetailsController = TextEditingController();
  final _depositController = TextEditingController();
  final _contactController = TextEditingController();
  late final UserBloc userBloc;
  @override
  void dispose() {
    emailController.dispose();
    _homeAddressController.dispose();
    _areaController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _rentalsController.dispose();
    _roomsController.dispose();
    _occupatiionDateController.dispose();
    _extraDetailsController.dispose();
    _depositController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  DateTime currentDate = DateTime.now();

// late UploadBloc uploadBloc;
  var classificationsValue = '';
  var typeValue = "";

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    classificationsValue = widget.classifications[0];
    typeValue = widget.types[0];
    _contactController.text = userBloc.userPhoneNumber;

    super.initState();
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>(); //key for form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: const Text('Upload Details',
              style: TextStyle(color: ColorConstants.yellow)),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Logo(
                imageUrl: 'assets/images/houseicon.png',
              ),
              iconSize: 100,
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomUploadDetailsHeaders(
                      header: 'House Details',
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Home Address',
                      controller: _homeAddressController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter house address';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Area',
                      controller: _areaController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter area';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'City',
                      controller: _cityController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const CustomUploadDetailsHeaders(
                      header: 'Occupation Details',
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Rentals',
                      controller: _rentalsController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter rent';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                        readOnly: false,
                        hintText: '',
                        labelText: '# of Rooms',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of rooms';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                        controller: _roomsController),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
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
                      labelText: 'Extra Details',
                      controller: _extraDetailsController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter extra details';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Deposit',
                      controller: _depositController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter deposit';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Type",
                                  style: GoogleFonts.montserrat())),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 30,
                                child: Container(
                                  color: ColorConstants.grey,
                                  child: DropdownButton(
                                    isDense: true,
                                    value: typeValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: widget.types.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        typeValue = newValue.toString();
                                      });
                                    },
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Contact',
                      // type: TextInputType.,
                      controller: _contactController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact';
                        }
                        if (!value.startsWith("+")) {
                          return 'start with country code';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Classification",
                                  style: GoogleFonts.montserrat())),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 30,
                                child: Container(
                                  color: ColorConstants.grey,
                                  child: DropdownButton(
                                    isDense: true,
                                    value: classificationsValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: widget.classifications
                                        .map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        classificationsValue =
                                            newValue.toString();
                                      });
                                    },
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    CustomTextField(
                      readOnly: false,
                      hintText: '',
                      labelText: 'Email',
                      controller: emailController,
                      onChanged: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                          return "invalid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    const CustomUploadDetailsHeaders(
                      header: 'House Features',
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Borehole"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isBorehole,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isBorehole = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Rent Includes Electricity"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isElectricity,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isElectricity = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Solar"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isSolar,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isSolar = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Rent Includes Water"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isWater,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isWater = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Walled"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isWalled,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isWalled = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Gated"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isGated,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isGated = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tiled"),
                              Checkbox(
                                activeColor: ColorConstants.yellow,
                                checkColor: ColorConstants.yellow,
                                value: isTiled,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isTiled = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                        width: 150,
                        child: BlocListener<UploadBloc, UploadState>(
                          listener: (context, state) {
                            if (state is UploadSuccessState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Uploaded'),
                                duration: const Duration(seconds: 3),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UploadsList()));
                            }
                            if (state is UploadFailedState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('failed to upload'),
                                duration: const Duration(seconds: 1),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              ));

                              SchedulerBinding.instance!
                                  .addPostFrameCallback((_) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PropertyError(
                                            errorMessage: state.toString())));
                              });
                            }
                          },
                          child: BlocBuilder<UploadBloc, UploadState>(
                              builder: (context, state) {
                            if (state is UploadLoadingState) {
                              return const LoadingIndicator();
                            }
                            if (state is UploadHouseSuccessState) {
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadImages(
                                            houseId: state.houseResponse.id,
                                            type: state.houseResponse.type,
                                            homeAddress: state
                                                .houseResponse.houseAddress)));
                              });
                            }
                            return CustomElevateButton(
                              name: 'Save',
                              color: ColorConstants.yellow,
                              onSubmit: () {
                                //  Validate returns true if the form is valid, or false otherwise.
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<UploadBloc>(context).add(
                                      UploadHouseEvent(
                                          area: _areaController.text,
                                          type: typeValue,
                                          walled: isWalled,
                                          tiled: isTiled,
                                          solar: isSolar,
                                          token: '',
                                          boreHole: isBorehole,
                                          city: _cityController.text,
                                          classification: classificationsValue,
                                          contact: _contactController.text,
                                          deposit: int.parse(
                                              _depositController.text),
                                          email: emailController.text,
                                          extraDetails:
                                              _extraDetailsController.text,
                                          gated: isGated,
                                          houseAddress:
                                              _homeAddressController.text,
                                          numberRooms:
                                              int.parse(_roomsController.text),
                                          occupationDate:
                                              currentDate.toString(),
                                          occupied: isOccupied,
                                          rent: int.parse(
                                              _rentalsController.text),
                                          rentElectricityInclusive:
                                              isElectricity,
                                          rentWaterInclusive: isWater));
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ]),
                  ]),
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
