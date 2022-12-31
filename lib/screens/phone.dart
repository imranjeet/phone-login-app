import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verificationId = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  bool isLoading = false;
  var phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const Text(
                "Let's get started..",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/india.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: "Phone",
                      ),
                    )),
                    isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () async {
                              if (phoneNumber.length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please Enter a Valid 10 digit Mobile Number!"),
                                  ),
                                );
                              } else if (phoneNumber[0] != "6" &&
                                  phoneNumber[0] != "7" &&
                                  phoneNumber[0] != "8" &&
                                  phoneNumber[0] != "9") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please Enter a Valid Mobile Number!"),
                                  ),
                                );
                              } else {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: '+91 $phoneNumber',
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      MyPhone.verificationId = verificationId;
                                      Navigator.pushNamed(context, 'verify')
                                          .then((v) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please enter correct phone number!"),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Container(
                                height: 55,
                                width: 55,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ))),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Enter your mobile number to continue.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   height: 45,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           primary: Colors.green.shade600,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10))),
              //       onPressed: () {
              //         Navigator.pushNamed(context, 'verify');
              //       },
              //       child: const Text("Send the code")),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
