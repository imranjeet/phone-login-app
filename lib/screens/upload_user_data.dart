import 'dart:io';

import 'package:aryago_login_app/api/user_api.dart';
import 'package:aryago_login_app/api/user_storage.dart';
import 'package:aryago_login_app/validators/emailValidator.dart';
import 'package:aryago_login_app/validators/nameValidator.dart';
import 'package:aryago_login_app/widgets/customAuthFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadUserData extends StatefulWidget {
  const UploadUserData({super.key});

  @override
  State<UploadUserData> createState() => _UploadUserDataState();
}

class _UploadUserDataState extends State<UploadUserData> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final UserStorage _userStorage = UserStorage();
  final UsersApi _usersApi = UsersApi();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  File? _imageFile;
  String? _imageName;
  String? _imagePath;
  final picker = ImagePicker();
  bool isLoading = false;

  _getFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
        _imageName = pickedFile.name;
        _imagePath = pickedFile.path;
      });
    }
  }

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      final User? user = auth.currentUser;

      String imageUrl =
          await _userStorage.uploadProfileImage(_imagePath!, _imageName!);

      await _usersApi.uploadingData(
          nameController.text,
          user!.uid,
          user.phoneNumber.toString(),
          emailController.text,
          cityController.text,
          imageUrl);

      setState(() {
        isLoading = false;
      });

      Navigator.pushNamedAndRemoveUntil(context, 'home', ((route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Complete your profile",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// Profile photo
                    GestureDetector(
                      child: Center(
                          child: _imageFile == null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey.shade400,
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_imageFile!),
                                )),
                      onTap: () {
                        /// Get profile image
                        _getFromGallery();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 55,
                      child: Center(
                        child: AuthCustomFormField(
                          keyboardType: TextInputType.name,
                          hintText: "Name",
                          textCapitalization: TextCapitalization.words,
                          validator: nameValidator,
                          controller: nameController,
                          onChanged: (String val) {
                            setState(() {});
                          },
                          onSaved: (name) {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      child: Center(
                        child: AuthCustomFormField(
                          keyboardType: TextInputType.name,
                          hintText: "Email",
                          textCapitalization: TextCapitalization.words,
                          validator: emailValidator,
                          controller: emailController,
                          onChanged: (String val) {
                            setState(() {});
                          },
                          onSaved: (name) {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      child: Center(
                        child: AuthCustomFormField(
                          keyboardType: TextInputType.name,
                          hintText: "City",
                          textCapitalization: TextCapitalization.words,
                          validator: nameValidator,
                          controller: cityController,
                          onChanged: (String val) {
                            setState(() {});
                          },
                          onSaved: (name) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            _imageFile == null
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please select a profile photo!"),
                                    ),
                                  )
                                : _submitForm();
                          },
                          child: const Text("REGISTER",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600))),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
