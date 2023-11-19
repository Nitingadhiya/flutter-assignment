import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _prefectureController = TextEditingController();
  final TextEditingController _muncController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  String _selectedCountry = ''; // Selected country from dropdown
  String _selectedCountryCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF5408AD),
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CountryCodePicker(
                      onChanged: (CountryCode? countryCode) {
                        setState(() {
                          _selectedCountry = countryCode!.name!;
                          _selectedCountryCode = countryCode.code!;
                        });
                      },
                      initialSelection: 'IN', // Set initialSelection to null for an empty value
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      boxDecoration: BoxDecoration(border: Border.all(width: 1)),
                    ),
                  ),
                ),
                //Prefecture TextField
                TextFormField(
                  controller: _prefectureController,
                  decoration: const InputDecoration(labelText: 'Prefecture'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Prefecture cannot be empty.';
                    }
                    return null;
                  },
                    textInputAction: TextInputAction.next,

                ),
                //Municipality TextField
                TextFormField(
                  controller: _muncController,
                  decoration: const InputDecoration(labelText: 'Municipality'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Municipality cannot be empty.';
                    }
                    return null;
                  },
                    textInputAction: TextInputAction.next,
                ),
                //Street address TextField
                TextFormField(
                  controller: _streetAddressController,
                  decoration: const InputDecoration(labelText: 'Street Address (subarea - block - house)'),
                  validator: (value) {
                    // Validate street address format (subarea-block-house)
                    if (!RegExp(r'^\w+-\w+-\w+$').hasMatch(value!)) {
                      return 'Invalid format. Expected subarea-block-house.';
                    }
                    return null;
                  },
                    textInputAction: TextInputAction.next,
                ),
                //Apartment TextField
                TextFormField(
                  controller: _apartmentController,
                  decoration: const InputDecoration(labelText: 'Apartment, suite or unit'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Apartment cannot be empty.';
                    }
                    return null;
                  },
                    textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0XFF5408AD)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, save the user's address
                      UserAddress userAddress = UserAddress(
                          streetAddress: _streetAddressController.text,
                          prefecture: _prefectureController.text,
                          apartment: _apartmentController.text,
                          country: _selectedCountry,
                          countryCode: _selectedCountryCode,
                          muncipal: _muncController.text);

                      if (kDebugMode) {
                        print("userAddress:-- $userAddress");
                        print("userAddress:-- ${userAddress.country}");
                      }

                      // TODO: Save the userAddress object as needed

                      // Show a confirmation dialog or navigate to the next screen
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Address Saved'),
                            content: const Text('User address has been saved successfully.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  //If we want to clear form after successfully submitted
                                  // _formKey.currentState?.reset();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save Address'),
                ),
              ],
            ),
          ),
        ));
  }
}

class UserAddress {
  String streetAddress;
  String prefecture;
  String apartment;
  String country;
  String countryCode;
  String muncipal;

  UserAddress({
    required this.streetAddress,
    required this.prefecture,
    required this.apartment,
    required this.country,
    required this.countryCode,
    required this.muncipal,
  });
}
