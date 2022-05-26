import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:garbage_system/dialogs/add_bin.dart';
import 'package:garbage_system/dialogs/add_bin_images.dart';
import 'package:garbage_system/models/bin_model.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/services/bin_service.dart';
import 'package:garbage_system/services/firestore_service.dart';
import 'package:garbage_system/widgets/normal_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EditBinPage extends StatefulWidget {
  final Place? place;
  const EditBinPage({Key? key, this.place}) : super(key: key);

  @override
  State<EditBinPage> createState() => _EditBinPageState();
}

class _EditBinPageState extends State<EditBinPage> {
  final List<Bin> _bins = [];
  final List<String> _binImages = [];
  bool _isUploading = false;

  final _placeNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.place != null) {
      final query =
          FirestoreService.postsRef.child('${widget.place!.key!}/bins');

      query.get().then((value) {
        _bins.addAll((value.value as List<Object?>).map(
            (snapshot) => Bin.fromJson(snapshot as Map<Object?, Object?>)));
        setState(() {});
      });

      _placeNameController.text = widget.place!.placeName;
      _addressController.text = widget.place!.address;
      _cityController.text = widget.place!.placeName;
      _pinCodeController.text = widget.place!.pinCode;

      _binImages.addAll(widget.place!.binImages.map((e) => '$e'));
    }

    super.initState();
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pinCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bin'),
        actions: [
          if (_isUploading)
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          if (!_isUploading)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) return;
                    if (_bins.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Atleast one bin is required')));
                      return;
                    }
                    if (_binImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Atleast one bin image is required')));
                      return;
                    }
                    setState(() => _isUploading = true);
                    await BinService.addBin(
                      id: widget.place != null ? widget.place!.key : null,
                        placeName: _placeNameController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        pinCode: _pinCodeController.text,
                        bins: _bins,
                        binImages: _binImages);
                    setState(() => _isUploading = false);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    FontAwesome.floppy,
                    size: 15.0,
                  ),
                  label: const Text('Save', style: TextStyle())),
            )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Place detail',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _placeNameController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'Place name required';
                },
                decoration: const InputDecoration(hintText: 'Enter Place Name'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  controller: _addressController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return 'Address required';
                  },
                  decoration: const InputDecoration(hintText: 'Enter Address'),
                  keyboardType: TextInputType.streetAddress),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _cityController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'City required';
                },
                decoration: const InputDecoration(hintText: 'Enter City'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _pinCodeController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'Pincode required';
                },
                decoration: const InputDecoration(hintText: 'Enter Pincode'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bin detail',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        showAddBinDialog(context, onSaved: (bin) {
                          setState(() => _bins.add(bin));
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add bin'))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ..._bins.map((bin) => BinItem(
                        bin: bin,
                        onDelete: (bin) {
                          setState(() => _bins.remove(bin));
                        },
                      ))
                ]),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bin images',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        showAddBinImagesDialog(context, onSaved: (binImages) {
                          setState(() => _binImages.addAll(binImages));
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add image'))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ..._binImages.map((image) => BinImage(
                        image: image,
                        onDelete: (image) {
                          setState(() => _binImages.remove(image));
                        },
                      ))
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class BinItem extends StatelessWidget {
  final Bin bin;
  final Function(Bin) onDelete;
  const BinItem({Key? key, required this.bin, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[400]!)),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(12.0),
          width: 130.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 24.0,
                percent: 0.0 / 100,
                progressColor: Colors.red,
                animation: true,
                animationDuration: 1500,
                center: const SmallText(
                  text: '${0.0 / 100}%',
                  size: 10,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Name: ${bin.name}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Id: ${bin.id}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
            right: 0.0,
            child: Material(
              color: Colors.white,
              shape: CircleBorder(side: BorderSide(color: Colors.grey[400]!)),
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  onDelete(bin);
                },
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    FontAwesome.trash_empty,
                    size: 18.0,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class BinImage extends StatelessWidget {
  final String image;
  final Function(String) onDelete;
  const BinImage({Key? key, required this.image, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 160.0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              image,
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              right: 0.0,
              child: Material(
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: Colors.grey[400]!)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: () {
                    onDelete(image);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      FontAwesome.trash_empty,
                      size: 18.0,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
