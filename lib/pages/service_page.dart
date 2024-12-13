import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service/cart_provider.dart';
import 'package:service/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'dart:convert';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
// import 'package:http/http.dart' as http;



class ServicePage extends StatefulWidget {
  final String serviceName;
  const ServicePage({super.key, required this.serviceName});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String number = '';

  final addressController = TextEditingController();

  int pressed = 0;
  late String userNumber;

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNumber();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addressController.dispose();
    super.dispose();
  }

  void fetchNumber() async
  {
    DocumentSnapshot snapshot = await _firebaseFirestore.
    collection('DistributionService').doc('About').get();
    if(snapshot.exists){
      number = snapshot.get('Number');
    }
  }


// Future<String> getAccessToken() async
// {
//   final servicesAccountJson = 
//   {
//     "type": "service_account",
//     "project_id": "services-9",
//     "private_key_id": "e53b639b32802c66e73defcf8af54ca600c021ed",
//     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDPNRtbuKih2qf5\nMpEK6xvQzhnWu1iOsMlqvraEmlSOy33H8KDLyvRrZ2DsFr3yUGRGgjaf0V+q0EJH\nIeVkuMiDPNBP0bXMfh9NS4umsjZbRpqX1tNAkzdeGkenXF5fL/ksRLgO411etQpf\n2MY58WaSpVFgWk1a/EbvOFH8wpuJXXL99qjQsdw/stVCvrieJFnP+apDCuyLQgWx\nlzL2s3Z6FyF5uR8TntEVVqQDqqkch5OQ1HFmOMFtizZOMesCHLaIUOkZAX72yEEJ\nzwPCj0piO7Vqk4FPWLj9Q6KMBlxNBCUD0oY0UQ2kxpkM+PW0W5NbMYK6yoeXpYX4\nYySD3vThAgMBAAECggEAIdNHEI2QBcAGnMEa+V/RDiCfCjVSKxUEBGd2ryXseNUS\nRvHqpeoPRXs+ULwTrPtfqzz1gthwmBdgQnFvm6YooXfrf6Q529SY8orLFN7Rzcu0\nT+YzXT7LEpMSsGj9ROe1cvsS2udV5jCCrYvbLDlSp8zSAHstVpWJVOLqS2tPbbhm\nltINO9VGdb+Nu6Zp8AbdhFueh1QOiU82oYMEpQjkoNkK8ynazZkVxydQDaFbpoLb\nAVTcdAzZbPWZK3SQwdx95ujj+GSzaeX+1LBmg2gCIIK9KXViuWaMcNpWgYobW5Ci\nXRk+ZOXpjZWgiFTVUTy3Umf4UbAZ98ydhlM/otLLCwKBgQD89Rt5EsPl4tU2emCr\nljxAAIeByhbqOdEc8BlOZ1BtBCy+N4DdT65iwF0BtOEdlo2HMhaADd3mM+QvZbIK\nLY8OcNpU0X5Wm85pkpYaoq5r7piY2DxG+5jnCBwkZhAexNQlU9u/FYTjzlrrV4kS\nSWH9WBpdam9P155JLYXmlxLoTwKBgQDRsyDv4RemodPbmrI3tX1FRXJN7AYRAGOS\nCIIcyoBkt+4yfL3mG6oAChOUYffaIcOAsccBP3AhIxx0FMMES1EiiV5FSMbFwVg4\n9VUX+zgivlJM9mWg4+N6P++39nLvSAj/NAX17uWpFwLzyNu7HtVYP9yuzcSYdbpe\n//F5dSTTzwKBgQCcwrEh2PU589a6CiD6dQIlj65qSnjk8quayViFdBUtWhb4UqEz\nhXvGivuYYSXZFkHi9LFo7i8DyEiy7szk7dLn2hwT0DgBKFFEr6kCHKsHDDfZELha\nLPVWx3nZPL7ksoneEBfwVT+jhXBmxDqX8I4fWIgOODV/P1pCc0m12w3GlQKBgGM9\nOZ4sUUwLk75+1E6m9jTdK74Sr8BGBdkra6ACeYawwOplvFz0xJwmKKP1RR2XEvWJ\nrJs7kW4tNp784Fnc5vXIOrPhQCiAWqcB+5ZQzn0qwrondWsRziqhrWnLGROCbLeR\nwCxmNYuzFzOV398LNX4BIwga2yontN6Wk4meVaJjAoGBAJNtveHj9sXCnVM+MfT7\nYSk09dZthxzById3agqNnETax4jXidlq48osMWVY8LqtmzSb0wq/kc+9+rgMxx7Y\ngvIqk5Rro2mLCO61yu7ENYgSSD7Cl9WxiX7DNkouHV0139/xOHKdZsM77BBvCUKG\nOU5FD9yFAL5C+7qPenB7XV8B\n-----END PRIVATE KEY-----\n",
//     "client_email": "fluttermyname@services-9.iam.gserviceaccount.com",
//     "client_id": "108247893896677397792",
//     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//     "token_uri": "https://oauth2.googleapis.com/token",
//     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttermyname%40services-9.iam.gserviceaccount.com",
//     "universe_domain": "googleapis.com"
//   };
//   List<String> scopes = 
//   [
//     "https://www.googleapis.com/auth/firebase.messaging"
//   ];
//   http.Client client = await auth.clientViaServiceAccount(
//     auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
//     scopes,
//   );
  
//   auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
//     auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
//     scopes,
//     client
//   );

//   client.close();

//   return credentials.accessToken.data;

// }


//   void sendPushNotification(String token) async 
//   {
//     final String serverAccessTokenKey = await getAccessToken();
//     final url = Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/services-9/messages:send');
//     final Map<String,dynamic> message = {
//       "message": {
//         "token": token,
//         "notification": 
//         {
//           "title": 'SERVICE REQUEST',
//           "body": widget.serviceName,
//         },
//       }
//     };
//     await http.post(
//       url,
//       headers: <String,String>{
//         'Content-Type' : 'application/json',
//         'Authorization' : 'Bearer $serverAccessTokenKey',
//       },
//       body: jsonEncode(message),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.sizeOf(context).width;
    final height =  MediaQuery.sizeOf(context).height;
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.miscellaneous_services_sharp,
              size: 180,
            ),
            SizedBox(
              height: height/20,
            ),
            Text(
              widget.serviceName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w600
              ),
              ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () async {
                userNumber = (await StorageService.getNumber())!;
                DocumentSnapshot doc = await _firebaseFirestore.collection('USERS').doc(userNumber).get();
                // DocumentSnapshot doc2 = await _firebaseFirestore.collection('USERS').doc('7893632039').get();
                int currently = doc['Currently'];
                // String token = doc2['FCMToken'];
                if(currently == 1)
                {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Service Limit'),
                      content: const Text('You have an ongoing service order'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                    }
                  );
                }
                else{
                  if(cartProvider.services.length == 5)
                  {
                   showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('SERVICE LIMIT'),
                        content: const Text('YOU CAN ONLY ADD UPTO 5 SERVICES AT ONCE'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                      }
                    ); 
                  }
                  else if(!cartProvider.checkServiceExists(widget.serviceName))
                  {
                    cartProvider.addService(widget.serviceName);
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ADDED TO CART'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                      }
                    );
                  }
                  else
                  {
                   showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ITEM ALREADY EXISTS'),
                        content: const Text('PLEASE CHECK YOUR CART'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                      }
                    ); 
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                maximumSize: Size(width, height/12), 
                backgroundColor: Colors.blue,      
                foregroundColor: Colors.white,           
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
              ),
              child: const Center(
                child: Text(
                  'REQUEST',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ),
            ),
            SizedBox(
              height: height/25,
            ),
            ElevatedButton(
              onPressed: () async{
                if(number.isNotEmpty){
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: number
                  );
                  if(await canLaunchUrl(url)){
                  await launchUrl(url);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                maximumSize: Size(width, height/12), 
                backgroundColor: Colors.green,                 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.call,
                  size: 50,
                  color: Colors.white, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}