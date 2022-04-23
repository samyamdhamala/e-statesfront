import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/pages/display_for_all_property/all_property_listings_page.dart';
import 'package:login/pages/display_for_own_property/own_property_listings.dart';
import 'package:login/property_feature/property_post_method.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);
//for dropdowns
  String dropdownValue = 'House';
  String dropdownValue2 = 'For Sale';
  String dropdownValue3 = 'Aana';

  final ImagePicker _picker = ImagePicker();
  List<File>? _imageFileList = [];
  // File? _image;

  // Future getImage() async {
  //   try {
  //     final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (_image == null) {
  //       return;
  //     }
  //     final File imageTemp = File(_image.path);
  //     debugPrint(imageTemp.toString());
  //     setState(() {
  //       this._image = imageTemp;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image ${e}');
  //   }
  // }

  void selectImages() async {
    var selectedImages = await _picker.pickMultiImage();
    selectedImages!.forEach((image) {
      setState(() {
        _imageFileList!.add(File(image.path));
      });
    });

    print("Image list length : " + _imageFileList!.length.toString());
    setState(() {});
  }

  final _propertyFormKey = GlobalKey<FormState>();
  TextEditingController nae = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController cityText = TextEditingController();
  TextEditingController provinceText = TextEditingController();
  TextEditingController priceText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  TextEditingController areaText = TextEditingController();
  TextEditingController latitudeText = TextEditingController();
  TextEditingController longitudeText = TextEditingController();
  late String name;
  late String streetaddress;
  late String city;
  late String province;
  late String area;
  late String price;
  String type = 'House';
  late String description;
  String status = 'For Sale';
  String unit = 'Aana';
  late String latitude;
  late String longitude;
  late String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[300],
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
                        items: <String>['For Sale', 'For Rent']
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
                            color: Color.fromARGB(188, 56, 55, 55),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: nae,
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
                            onSaved: (value) {
                              setState(() {
                                nae.text = value!;
                                name = nae.toString();
                              });
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Property Area*',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextFormField(
                                      controller: street,
                                      onSaved: (value) {
                                        setState(() {
                                          areaText.text = value!;
                                          area = areaText.toString();
                                        });
                                      },
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "Cannot be Empty"),
                                        PatternValidator((r'(^[0-9]+$)'),
                                            errorText: "Numbers Only"),
                                      ]),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text('Area Unit*',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  Container(
                                    height: 40,
                                    child: DropdownButton<String>(
                                      value: dropdownValue3,
                                      icon: const Icon(
                                        Icons.arrow_downward,
                                        size: 24,
                                      ),
                                      elevation: 50,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.grey.shade700,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue3 = newValue!;
                                          unit = dropdownValue3;
                                        });
                                      },
                                      items: <String>[
                                        'Aana',
                                        'Ropani',
                                        'Sq.Feet',
                                        'Dhur',
                                        'Bigha'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: priceText,
                            onSaved: (value) {
                              setState(() {
                                priceText.text = value!;
                                price = priceText.toString();
                              });
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot be Empty"),
                              PatternValidator((r'(^[0-9]+$)'),
                                  errorText: "Numbers Only"),
                            ]),
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
                            color: Color.fromARGB(188, 56, 55, 55),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: cityText,
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
                            onSaved: (value) {
                              setState(() {
                                street.text = value!;
                                streetaddress = street.toString();
                              });
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
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
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
                            controller: provinceText,
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
                            onSaved: (value) {
                              provinceText.text = value!;
                              province = provinceText.toString();
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
                          Row(
                            children: [
                              Text('GPS Coordinates*',
                                  style: Theme.of(context).textTheme.subtitle1),
                              Spacer(),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.gps_fixed,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        label: const Text('Get Location',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white)),
                                        onPressed: () async {
                                          var p = await Navigator.pushNamed(
                                              context, "/search");
                                          if (p != null) {
                                            notifier.value = p as GeoPoint;
                                            setState(() {
                                              latitudeText.text =
                                                  p.latitude.toString();
                                              longitudeText.text =
                                                  p.longitude.toString();
                                            });
                                          }
                                        },

                                        // onPressed: () async {
                                        //   var p =
                                        //       await showSimplePickerLocation(
                                        //     context: context,
                                        //     isDismissible: true,
                                        //     title:
                                        //         "Select Your Property Location",
                                        //     textConfirmPicker: "Pick",
                                        //     initCurrentUserPosition: false,
                                        //     initZoom: 12,
                                        //     titleStyle: TextStyle(fontSize: 16),
                                        //     initPosition: GeoPoint(
                                        //         latitude: 27.66548398301448,
                                        //         longitude: 85.357267861246),
                                        //     radius: 10,
                                        //   );
                                        //   if (p != null) {
                                        //     notifier.value = p;
                                        //     setState(() {
                                        //       latitudeText.text =
                                        //           p.latitude.toString();
                                        //       longitudeText.text =
                                        //           p.longitude.toString();
                                        //     });
                                        //   }
                                        // },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 84, 93, 218),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: latitudeText,
                                  validator: RequiredValidator(
                                      errorText: "Cannot be Empty"),
                                  onSaved: (value) {
                                    latitudeText.text = value!;
                                    latitude = latitudeText.toString();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'latitude',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: longitudeText,
                                  validator: RequiredValidator(
                                      errorText: "Cannot be Empty"),
                                  onSaved: (value) {
                                    longitudeText.text = value!;
                                    longitude = longitudeText.toString();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'longitude',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                            color: Color.fromARGB(188, 56, 55, 55),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Property Description*',
                              style: Theme.of(context).textTheme.subtitle1),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: descriptionText,
                            maxLines: 4,
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
                            onSaved: (value) {
                              descriptionText.text = value!;
                              description = descriptionText.toString();
                            },
                            decoration: const InputDecoration(
                              hintText:
                                  'Describe your property here, include all details about your property.',
                              fillColor: Color.fromARGB(117, 183, 181, 181),
                              filled: true,
                            ),
                          ),
                        ],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '  Images',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                color: Color.fromARGB(188, 56, 55, 55),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  selectImages();
                                },
                                icon: Icon(
                                  Icons.add_photo_alternate,
                                  color: Color(0xff766FE7),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        color: Color.fromARGB(117, 183, 181, 181),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  itemCount: _imageFileList!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.file(
                                      File(_imageFileList![index].path),
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.3,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: _image != null
                      //       ? Image.file(_image!)
                      //       : Center(
                      //           child: Text(
                      //             'No image Selected',
                      //           ),
                      //         ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    // When the user taps the button, show a snackbar.
                    onTap: () async {
                      if (_propertyFormKey.currentState!.validate()) {
                        _propertyFormKey.currentState!.save();
                        String data = await PropertyPostMethod(
                          name: nae.text,
                          streetaddress: street.text,
                          description: descriptionText.text,
                          city: city,
                          area: areaText.text + ' ' + unit,
                          price: int.parse(priceText.text),
                          province: provinceText.text,
                          longitude: longitudeText.text,
                          latitude: latitudeText.text,
                          type: type,
                          status: status,
                          image: _imageFileList,
                        ).createProperty();
                        debugPrint('This is the sucess data ${data}');
                        if (data == "Sucess") {
                          Fluttertoast.showToast(
                              msg: "Property Posted Sucessfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.greenAccent[100],
                              textColor: Colors.black,
                              fontSize: 14.0);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OwnPropertyListings()));
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
                      }
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

// String selectPriceUnit = '';
// final priceunitSelected = TextEditingController();
// List<String> priceunit = ["Ropani", "Aana", "Bigha", "Kanal", "Sq ft", "Only"];
