import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/pages/home_page.dart';
import 'package:login/property_feature/property_post_method.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
//for dropdowns
  String dropdownValue = 'House';
  String dropdownValue2 = 'For Sale';

  File? _image;

  Future getImage() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (_image == null) {
        return;
      }
      final File imageTemp = File(_image.path);
      debugPrint(imageTemp.toString());
      setState(() {
        this._image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image ${e}');
    }
  }

  final _propertyFormKey = GlobalKey<FormState>();

  late String name;
  late String streetaddress;
  late String city;
  late String province;
  late String area;
  late String price;
  String type = 'House';
  late String description;
  String status = 'For Sale';
  late String latitude;
  late String longitude;
  late String image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Post New Property'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _propertyFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Select Property Type: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 16,
                        ),
                        elevation: 20,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            type = dropdownValue;
                          });
                        },
                        items: <String>['House', 'Land']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Select Property Status: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 16,
                        ),
                        elevation: 20,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                            status = dropdownValue2;
                          });
                        },
                        items: <String>['For Sale', 'For Rent', 'For Lease']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.grey[400],
                        height: 40,
                        child: Text(
                          '  Basic Information',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              name = value.toString();
                            },
                            decoration: const InputDecoration(
                              labelText: 'Property Title*',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              area = value.toString();
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Property Area *',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // DropDownField(
                          //   controller: priceunitSelected,
                          //   hintText: 'Select Price Unit',
                          //   hintStyle: TextStyle(
                          //     fontFamily: 'Roboto',
                          //     fontSize: 16,
                          //   ),
                          //   enabled: true,
                          //   itemsVisibleInDropdown: 6,
                          //   items: priceunit,
                          //   onValueChanged: (value) {
                          //     setState(() {
                          //       selectPriceUnit = value;
                          //     });
                          //   },
                          // ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              price = value.toString();
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Property Price *',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.grey[400],
                        height: 40,
                        child: const Text(
                          '  Location',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              streetaddress = value.toString();
                            },
                            decoration: const InputDecoration(
                              labelText: 'Street Address *',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              city = value.toString();
                            },
                            decoration: const InputDecoration(
                              labelText: 'City *',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              province = value.toString();
                            },
                            decoration: const InputDecoration(
                              labelText: 'Province *',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // DropDownField(
                          //   controller: priceunitSelected,
                          //   hintText: 'Select Price Unit',
                          //   hintStyle: TextStyle(
                          //     fontFamily: 'Roboto',
                          //     fontSize: 16,
                          //   ),
                          //   enabled: true,
                          //   itemsVisibleInDropdown: 6,
                          //   items: priceunit,
                          //   onValueChanged: (value) {
                          //     setState(() {
                          //       selectPriceUnit = value;
                          //     });
                          //   },
                          // ),
                          Row(
                            children: [
                              Text(
                                'GPS Coordinates*',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                child: const Text('Pick'),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddProperty())),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(5, 20),
                                    primary: Colors.deepPurpleAccent,
                                    textStyle: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                    )),
                              )
                            ],
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              latitude = value.toString();
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Latitude *',
                              hintStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "This field should not be left empty."),
                            onSaved: (value) {
                              longitude = value.toString();
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Longitude *',
                              hintStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.grey[400],
                        height: 40,
                        child: const Text(
                          '  Detailed Information',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Description *',
                      //       style: TextStyle(
                      //         color: Colors.grey.shade700,
                      //         fontFamily: 'Roboto',
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "This field should not be left empty."),
                        onSaved: (value) {
                          description = value.toString();
                        },
                        decoration: const InputDecoration(
                          labelText: 'Property Description *',
                          labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.grey[400],
                        height: 40,
                        child: const Text(
                          '  Images',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text('Pick Image'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: _image != null
                            ? Image.file(_image!)
                            : Center(
                                child: Text(
                                  'No image Selected',
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    // When the user taps the button, show a snackbar.
                    onTap: () async {
                      // if (_propertyFormKey.currentState!.validate()) {
                      _propertyFormKey.currentState!.save();
                      String data = await PropertyPostMethod(
                        name: name,
                        streetaddress: streetaddress,
                        description: description,
                        city: city,
                        area: area,
                        price: int.parse(price),
                        province: province,
                        longitude: longitude,
                        latitude: latitude,
                        type: type,
                        status: status,
                        image: _image,
                      ).createProperty();
                      debugPrint(data);
                      if (data == "Success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Posted Successfully'),
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        AlertDialog alert = AlertDialog(
                          title: const Text('Invalid Details'),
                          content: const Text('Post could not be created'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      // }
                    },
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 130),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(120, 121, 241, 1)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String selectPriceUnit = '';
final priceunitSelected = TextEditingController();
List<String> priceunit = ["Ropani", "Aana", "Bigha", "Kanal", "Sq ft", "Only"];
