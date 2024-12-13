import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service/pages/search_page.dart';
import 'package:service/storage_service.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final pinCodeController = TextEditingController();


  late TabController _tabController;

  bool loading = false;


  // String? verificationID;

  // void sendOTP() async {
  //   final phoneNumber = '+91${numberController.text}';
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //     }, 
  //     verificationFailed: (FirebaseAuthException e){
  //       print('Error: ${e.message}');
  //     }, 
  //     codeSent: (String verificationId, int? resendToken){
  //       setState(() {
  //         verificationID = verificationId;
  //       });
  //     }, 
  //     codeAutoRetrievalTimeout: (String verificationId){
  //       setState(() {
  //         verificationID = verificationId;
  //       });
  //     }
  //   );
  // }

  // void verifyOTP() async {
  //   final credential = PhoneAuthProvider.credential(
  //     verificationId: verificationID!, 
  //     smsCode: otpController.text
  //     );
  //   try{
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     if(userCredential.user != null)
  //     {
  //       saveUserInfo(userCredential.user!, nameController.text);
  //     }
  //   }
  //   catch(e)
  //   {
  //     print('Error ${e.toString()}');
  //   }
  // }

//   void saveUserInfo(User user, String name) async {
//   try {
//     String phoneNumber = user.phoneNumber!.replaceAll(RegExp(r'\D'), '');
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(phoneNumber).get();
//     if (!userDoc.exists) 
//     {
//       await FirebaseFirestore.instance.collection('users').doc(phoneNumber).set({
//         'name': name,
//         'phone': user.phoneNumber,
//       });
//       print('User info saved successfully!');
    
//     }
//   } catch (e) {
//     print('Error saving/updating user info: $e');
//   }
// }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numberController.dispose();
    nameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: height/6),
        child: SizedBox(
          height: height/2,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  // borderRadius: BorderRadius.circular(12)
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    tabBarTheme: TabBarTheme(
                      dividerColor: Colors.transparent
                    )
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      color: Colors.pink[400],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20)
                        )
                    ),
                    // isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    splashBorderRadius: BorderRadius.circular(20),
                    tabs: const [
                      Tab(
                        text: 'LOGIN',
                        ),
                        Tab(
                        text: 'SIGN UP',
                        ),
                        // Tab(
                        // text:'ADMIN',
                        // ),
                      ]
                    ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20)
                          ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 3
                        )
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        login(context),
                        signUp(context),
                        // login(context)
                        ]
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget login(BuildContext context)
  {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            obscureText: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.person),
              hintText: 'NAME',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          TextField(
            controller: numberController,
            obscureText: false,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              counterText: '',
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.phone),
              hintText: 'PHONE NUMBER',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          TextField(
            controller: emailController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              counterText: '',
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.mail),
              hintText: 'EMAIL',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          // TextField(
          //   controller: pinCodeController,
          //   obscureText: false,
          //   keyboardType: TextInputType.emailAddress,
          //   decoration: InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.grey.shade500
          //       ),
          //       borderRadius: BorderRadius.circular(16),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(color: Colors.black),
          //       borderRadius: BorderRadius.circular(16)
          //     ),
          //     counterText: '',
          //     fillColor: Colors.grey[200],
          //     filled: true,
          //     prefixIcon: Icon(Icons.location_on),
          //     hintText: 'PINCODE',
          //     hintStyle: TextStyle(
          //       color: Colors.grey[700],
          //       fontWeight: FontWeight.w500
          //     )
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width/3.5,
              child: ElevatedButton(
                onPressed: () async
                {
                  setState(() {
                    loading = true;
                  });
                  FocusScope.of(context).unfocus();
                  if(nameController.text.length < 3)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Name too short!'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        margin: EdgeInsets.all(16),
                      ),
                    );
                    setState(() {
                    loading = false;
                    });
                    return;
                  }
                  else if(numberController.text.length != 10)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Number should be 10 digits!'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        margin: EdgeInsets.all(16),
                      ),
                    );
                    setState(() {
                    loading = false;
                    });
                    return;
                  }
                  DocumentReference docRef = FirebaseFirestore.instance.collection('USERS').doc(numberController.text);
                  DocumentSnapshot snapshot = await docRef.get();
                  String? token = await FirebaseMessaging.instance.getToken();
                  if(!snapshot.exists)
                  {
                    await docRef.set({
                      'FCMToken' : token,
                      'Currently' : 0,
                      'Name' : nameController.text
                    });
                    
                  }
                  else
                  {
                    String? fcm = snapshot.get('FCMToken');
                    if(fcm != token)
                    {
                      await docRef.update({
                        'FCMToken': token,
                      });
                    }
                  }
                  await StorageService.storeNumber(numberController.text);
                  await StorageService.storeName(nameController.text);
                  if(emailController.text.isNotEmpty && EmailValidator.validate(emailController.text))
                  {
                    await StorageService.storeMail(emailController.text);
                  }
                  List<dynamic> distributors = (await FirebaseFirestore.instance.collection('DistributionService').doc('About').get())['Numbers'];
                  List<dynamic> admins = (await FirebaseFirestore.instance.collection('ADMIN').doc('About').get())['Numbers'];
                  if(distributors.contains(numberController.text))
                  {
                    await StorageService.storePrivelege(1);
                  }
                  else if(admins.contains(numberController.text))
                  {
                    await StorageService.storePrivelege(2);
                  }
                  else
                  {
                    await StorageService.storePrivelege(0);
                  }
                  if(pinCodeController.text.isNotEmpty)
                  {
                    await StorageService.storePincode(pinCodeController.text);
                  }
                  setState(() {
                    loading = false;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SearchPage(loggedIn: true,)));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: loading? const SizedBox(
                  height: 20.0,
                  child: CircularProgressIndicator(color: Colors.white,)
                  ) :
                  const Text("ENTER"),
              ),
            ),
          ),
        ],
      );
  }

  Widget signUp(BuildContext context)
  {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            obscureText: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.person),
              hintText: 'NAME',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          TextField(
            controller: numberController,
            obscureText: false,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              counterText: '',
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.phone),
              hintText: 'PHONE NUMBER',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          TextField(
            controller: emailController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              counterText: '',
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.mail),
              hintText: 'EMAIL',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          TextField(
            controller: pinCodeController,
            obscureText: false,
            maxLength: 6,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16)
              ),
              counterText: '',
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.location_on),
              hintText: 'PINCODE',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width/3.5,
              child: ElevatedButton(
                onPressed: () async
                {
                  setState(() {
                    loading = true;
                  });
                  FocusScope.of(context).unfocus();
                  if(nameController.text.length < 3)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Name too short!'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        margin: EdgeInsets.all(16),
                      ),
                    );
                    setState(() {
                    loading = false;
                    });
                    return;
                  }
                  else if(numberController.text.length != 10)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Number should be 10 digits!'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        margin: EdgeInsets.all(16),
                      ),
                    );
                    setState(() {
                    loading = false;
                    });
                    return;
                  }
                  DocumentReference docRef = FirebaseFirestore.instance.collection('USERS').doc(numberController.text);
                  DocumentSnapshot snapshot = await docRef.get();
                  String? token = await FirebaseMessaging.instance.getToken();
                  if(!snapshot.exists)
                  {
                    await docRef.set({
                      'FCMToken' : token,
                      'Currently' : 0,
                      'Name' : nameController.text
                    });
                    
                  }
                  else
                  {
                    String? fcm = snapshot.get('FCMToken');
                    if(fcm != token)
                    {
                      await docRef.update({
                        'FCMToken': token,
                      });
                    }
                  }
                  await StorageService.storeNumber(numberController.text);
                  await StorageService.storeName(nameController.text);
                  if(emailController.text.isNotEmpty && EmailValidator.validate(emailController.text))
                  {
                    await StorageService.storeMail(emailController.text);
                  }
                  List<dynamic> distributors = (await FirebaseFirestore.instance.collection('DistributionService').doc('About').get())['Numbers'];
                  List<dynamic> admins = (await FirebaseFirestore.instance.collection('ADMIN').doc('About').get())['Numbers'];
                  if(distributors.contains(numberController.text))
                  {
                    await StorageService.storePrivelege(1);
                  }
                  else if(admins.contains(numberController.text))
                  {
                    await StorageService.storePrivelege(2);
                  }
                  else
                  {
                    await StorageService.storePrivelege(0);
                  }
                  if(pinCodeController.text.isNotEmpty)
                  {
                    await StorageService.storePincode(pinCodeController.text);
                  }
                  setState(() {
                    loading = false;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SearchPage(loggedIn: true,)));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: loading? const SizedBox(
                  height: 20.0,
                  child: CircularProgressIndicator(color: Colors.white,)
                  ) :
                  const Text("ENTER"),
              ),
            ),
          ),
        ],
      );
  }

}

