import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/models/property_model.dart';
import 'package:login/pages/display_for_own_property/own_property_listings.dart';
import 'package:login/property_feature/update_own_property.dart';

class UpdateProperty extends StatefulWidget {
  final PropertyModel property;
  const UpdateProperty({required this.property});

  @override
  State<UpdateProperty> createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends State<UpdateProperty> {
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  //for dropdowns
  String dropdownValue = 'House';
  String dropdownValue2 = 'For Sale';

  final _updatepropertyFormKey = GlobalKey<FormState>();
  TextEditingController nae = TextEditingController();
  TextEditingController streetTxt = TextEditingController();
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
  late String latitude;
  late String longitude;

  @override
  void initState() {
    super.initState();
    nae.text = widget.property.name;
    cityText.text = widget.property.city;
    provinceText.text = widget.property.province;
    priceText.text = widget.property.price.toString();
    descriptionText.text = widget.property.description;
    areaText.text = widget.property.area;
    latitudeText.text = widget.property.latitude;
    longitudeText.text = widget.property.longitude;
    dropdownValue = widget.property.type;
    dropdownValue2 = widget.property.status;
    streetTxt.text = widget.property.streetaddress;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Property'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _updatepropertyFormKey,
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
                          TextFormField(
                            controller: areaText,
                            onSaved: (value) {
                              setState(() {
                                areaText.text = value!;
                                area = areaText.toString();
                              });
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot be Empty"),
                            ]),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Property Area*',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              ),
                            ),
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
                            controller: streetTxt,
                            validator:
                                RequiredValidator(errorText: "Cannot be Empty"),
                            onSaved: (value) {
                              setState(() {
                                streetTxt.text = value!;
                                streetaddress = streetTxt.toString();
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
                            controller: cityText,
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
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.gps_fixed,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: const Text('Get Location',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),

                                onPressed: () async {
                                  var p = await Navigator.pushNamed(
                                      context, "/search");
                                  if (p != null) {
                                    notifier.value = p as GeoPoint;
                                    setState(() {
                                      latitudeText.text = p.latitude.toString();
                                      longitudeText.text =
                                          p.longitude.toString();
                                    });
                                  }
                                },
                                // onPressed: () async {
                                //   var p = await showSimplePickerLocation(
                                //     context: context,
                                //     isDismissible: true,
                                //     title: "Select Your Property Location",
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
                                //       latitudeText.text = p.latitude.toString();
                                //       longitudeText.text =
                                //           p.longitude.toString();
                                //     });
                                //   }
                                // },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 84, 93, 218),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
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
                  InkWell(
                    // When the user taps the button, show a snackbar.
                    onTap: () async {
                      if (_updatepropertyFormKey.currentState!.validate()) {
                        _updatepropertyFormKey.currentState!.save();
                        String data = await UpdateOwnProperty(
                          id: widget.property.id.toString(),
                          name: nae.text,
                          streetaddress: streetTxt.text,
                          description: descriptionText.text,
                          city: cityText.text,
                          area: areaText.text,
                          province: provinceText.text,
                          longitude: longitudeText.text,
                          latitude: latitudeText.text,
                          type: type,
                          status: status,
                          price: int.parse(priceText.text),
                        ).updateProperty();
                        debugPrint('This is the sucess data ${data}');
                        if (data == "success") {
                         
                          Fluttertoast.showToast(
                              msg: "Updated Sucessfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.greenAccent[100],
                              textColor: Colors.black,
                              fontSize: 14.0);
                          Navigator.pop(context);
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
                          'Update',
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
