import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/screens/search_results.dart';
import 'package:intl/intl.dart';

import '../../bloc/user/user_bloc.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_drop_down_button.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_search_range.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_formatter.dart';
import '../widgets/house_details_widget.dart';
import '../widgets/logo.dart';
import 'edit_property.dart';

class Search extends StatefulWidget {
  final List<String> types;
  final List<String> classifications;

  const Search({Key? key, required this.types, required this.classifications})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isChecked = false;

  final contactText = TextEditingController();
  bool validate = false;
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _contactController = TextEditingController();
  final _minRentController = TextEditingController();
  final _maxRentController = TextEditingController();
  final _minRoomsController = TextEditingController();
  final _maxRoomsController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _SearchFieldController = TextEditingController();
  var classificationsValue = '';
  var typeValue = "";
  var isBorehole = false;
  var isSolar = false;
  var isWater = false;
  var isElectricity = false;
  var isGated = false;
  var isTiled = false;
  var isWalled = false;
  var isDeposit = false;
  late final UserBloc userBloc;
  var isStartSelected = false;
  var isEndSelected = false;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    _contactController.text = userBloc.userPhoneNumber;
    classificationsValue = widget.classifications[0];
    typeValue = widget.types[0];

    super.initState();
  }

  @override
  void dispose() {
    contactText.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _contactController.dispose();
    _minRentController.dispose();
    _maxRentController.dispose();
    _minRoomsController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();

    super.dispose();
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>(); //key for form
  DateTime currentDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
          backgroundColor: Colors.white,
          title: Container(
              color: ColorConstants.grey,
              child: Text("SEARCH",
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
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: _SearchFieldController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Enter search value',
                      ),
                    ),
                  )
                ]),
              ),

              CustomTextField(
                readOnly: false,
                hintText: '',
                labelText: 'Area',
                controller: _areaController,
                onChanged: (value) {
                  if (formKey.currentState!.validate()) {}
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
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter city';
                //   }
                //   return null;
                // },
              ),
              //  const   CustomTextField(hintText: '', labelText: 'Type',),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text("Type", style: GoogleFonts.montserrat())),
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
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                readOnly: false,
                hintText: '',
                labelText: 'Contact',
                controller: _contactController,
                onChanged: (value) {
                  if (formKey.currentState!.validate()) {}
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact';
                  }
                  if (!value.startsWith("+")) {
                    return 'enter country code';
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
                              items: widget.classifications.map((String items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  classificationsValue = newValue.toString();
                                });
                              },
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SearchRangeTextfield(
                name: 'Rentals',
                maxHint: 'max',
                minHint: 'min',
                minController: _minRentController,
                maxController: _maxRentController,
                onChanged: (value) {
                  if (formKey.currentState!.validate()) {}
                },
              ),

              SearchRangeTextfield(
                name: 'Number of Rooms',
                maxHint: 'max',
                minHint: 'min',
                minController: _minRoomsController,
                maxController: _maxRoomsController,
                onChanged: (value) {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Occupation Date"),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _startDateController,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText:
                                  DateFormat.yMMMMd('en_US').format(startDate),
                              filled: true,
                              fillColor: ColorConstants.grey),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            DateFormatter(),
                          ],
                          validator: (value) {
                            if (isStartSelected == false) {
                              return 'Please select start date';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              isStartSelected = true;
                            });
                            _selectDate(context, 'start');
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _endDateController,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText:
                                  DateFormat.yMMMMd('en_US').format(endDate),
                              filled: true,
                              fillColor: ColorConstants.grey),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            DateFormatter(),
                          ],
                          validator: (value) {
                            if (isStartSelected == false) {
                              return 'Please select end date';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              isStartSelected = true;
                            });
                            _selectDate(context, 'end');
                          },
                        ),
                      ),
                    ])
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HouseDetails(
                  text1: 'Borehole',
                  text2: 'Rent Includes Electricity',
                  onChanged1: (bool? value) {
                    setState(() {
                      isBorehole = value!;
                    });
                  },
                  onChanged2: (bool? value) {
                    setState(() {
                      isElectricity = value!;
                    });
                  },
                  isText1: isBorehole,
                  isText2: isElectricity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HouseDetails(
                  text1: 'Solar',
                  text2: 'Rent Includes Water',
                  onChanged1: (bool? value) {
                    setState(() {
                      isSolar = value!;
                    });
                  },
                  onChanged2: (bool? value) {
                    setState(() {
                      isWater = value!;
                    });
                  },
                  isText1: isSolar,
                  isText2: isWater,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HouseDetails(
                  text1: 'Walled',
                  text2: 'Gated',
                  onChanged1: (bool? value) {
                    setState(() {
                      isWalled = value!;
                    });
                  },
                  onChanged2: (bool? value) {
                    setState(() {
                      isGated = value!;
                    });
                  },
                  isText1: isWalled,
                  isText2: isGated,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HouseDetails(
                  text1: 'Tiled',
                  text2: 'Deposit',
                  onChanged1: (bool? value) {
                    setState(() {
                      isTiled = value!;
                    });
                  },
                  onChanged2: (bool? value) {
                    setState(() {
                      isDeposit = value!;
                    });
                  },
                  isText1: isTiled,
                  isText2: isDeposit,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(
                    width: 150,
                    child: CustomElevateButton(
                      name: 'FIND',
                      color: ColorConstants.yellow,
                      onSubmit: () {
                        setState(() {
                          contactText.text.isEmpty
                              ? validate = true
                              : validate = false;
                        });
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResults(
                                      minNumberRooms:
                                          _minRoomsController.text.trim(),
                                      maxNumberRooms:
                                          _maxRoomsController.text.trim(),
                                      area: _areaController.text.trim(),
                                      city: _cityController.text.trim(),
                                      type: typeValue,
                                      classification: classificationsValue,
                                      contact: _contactController.text.trim(),
                                      electricityInclusive: isElectricity,
                                      isBorehole: isBorehole,
                                      isDeposit: isDeposit,
                                      isGated: isGated,
                                      isSolar: isSolar,
                                      isTiled: isTiled,
                                      isWalled: isWalled,
                                      searchValue:
                                          _SearchFieldController.text.trim(),
                                      maxRent: _maxRentController.text.trim(),
                                      minRent: _minRentController.text.trim(),
                                      page: 0,
                                      size: 0,
                                      token: '',
                                      waterInclusive: isWater,
                                      startDate: startDate.toString(),
                                      endDate: endDate.toString())));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Fill out missing fields'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context, String pos) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
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
        pos == 'start' ? startDate = pickedDate : endDate = pickedDate;
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
