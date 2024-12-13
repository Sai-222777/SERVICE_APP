import 'package:flutter/material.dart';
import 'package:service/main.dart';
import 'package:service/pages/service_form.dart';
import 'package:service/pages/ongoing_orders.dart';
import 'package:service/pages/order_history.dart';
import 'package:service/pages/manage_users.dart';
import 'package:service/pages/login_page.dart';
import 'package:service/pages/pending_requests.dart';
import 'dart:async';

import 'package:service/pages/search_page.dart';
import 'package:service/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{
  final PageController pageController = PageController();
  int currentPage = 0;

  // Add the first image again at the end for looping effect
  final List<String> images = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img1.jpg', // Duplicate of the first image
  ];

  bool loggedIn = false;

  late String? name, num, mail, pincode;
  int? privelege = 0;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final pincodeController = TextEditingController();

  bool _isEditingName = false;
  bool _isEditingNum = false;
  bool _isEditingMail = false;
  bool _isEditingPinCode = false;

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeNumber = FocusNode();
  final FocusNode _focusNodeMail = FocusNode();
  final FocusNode _focusNodePincode = FocusNode();

  @override
  void initState() {
    super.initState();
    prevLogin();
    pageController.addListener(() {
      if (pageController.page == images.length - 1) 
      {
          pageController.jumpToPage(0);
          currentPage = 0;
      }
    });

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) 
      {
        setState(() {
          if (currentPage < images.length - 1) {
            currentPage++;
            pageController.animateToPage(
              currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  void prevLogin () async {
    String? number = await StorageService.getNumber();
    if(number!= null && number.length == 10)
    {
      setState(() {
        loggedIn = true;
      });
      num = number;
      name = await StorageService.getName();
      mail = await StorageService.getMail();
      privelege = await StorageService.getPrivelege();
      pincode = await StorageService.getPincode();
    }
  } 

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null && modalRoute is PageRoute) 
    {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    routeObserver.unsubscribe(this);
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    pincodeController.dispose();
    _focusNodeMail.dispose();
    _focusNodeName.dispose();
    _focusNodeNumber.dispose();
    _focusNodePincode.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when coming back to this screen
    super.didPopNext();
    if(!loggedIn)
    {
      prevLogin();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width/3.5,
                child: loggedIn?
                  ElevatedButton(
                    onPressed: () 
                    {
                      StorageService.clearNumber();
                      StorageService.clearName();
                      StorageService.clearMail();
                      StorageService.clearPrivelege();
                      StorageService.clearPincode();
                      setState(() {
                        loggedIn = false;
                        privelege = 0;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text("Logout"),
                  )
                 :ElevatedButton(
                  onPressed: () async
                  {
                    await Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text("Login"),
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width/3.5,
              child: ElevatedButton(
                onPressed: () 
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage(loggedIn: loggedIn,)));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text("Services"),
              ),
            ),
          ),
        ],
      ),
      onDrawerChanged:(isOpened) {
        if(!isOpened)
        {
          _isEditingName = false;
          _isEditingNum = false;
          _isEditingMail = false;
          _isEditingPinCode = false;
          nameController.clear();
          emailController.clear();
          numberController.clear();
          pincodeController.clear();
        }
      },
      drawer:loggedIn ?  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                  ),
                  child: const Icon(
                    Icons.person, 
                    color: Colors.white,
                    size: 80,
                    ),
                ),
              ),
            ),
            ListTile(
              title: Text('Name'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      enabled: _isEditingName,
                      focusNode: _focusNodeName,
                      decoration: InputDecoration(
                        hintText: !_isEditingName ? name : '',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.edit,
                      color: _isEditingName ? Colors.green : Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditingName = !_isEditingName; // Toggle edit mode
                      });
                      if(_isEditingName)
                      {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusNodeName.requestFocus(); // Focus after the UI is updated
                        });
                      }
                    },
                  ),
                ],
              ),
              onTap: () 
              {
              },
            ),
            ListTile(
              title: Text('Number'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: numberController,
                      focusNode: _focusNodeNumber,
                      keyboardType: TextInputType.number,
                      enabled: _isEditingNum,
                      decoration: InputDecoration(
                        hintText: !_isEditingNum ? num : '',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.edit,
                      color: _isEditingNum ? Colors.green : Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditingNum = !_isEditingNum; // Toggle edit mode
                      });
                      if(_isEditingNum)
                      {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusNodeNumber.requestFocus(); // Focus after the UI is updated
                        });
                      }
                    },
                  ),
                ],
              ),
              onTap: () 
              {
              },
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      focusNode: _focusNodeMail,
                      enabled: _isEditingMail,
                      decoration: InputDecoration(
                        hintText: !_isEditingMail ? mail : '',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.edit,
                      color: _isEditingMail ? Colors.green : Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditingMail = !_isEditingMail; // Toggle edit mode
                      });
                      if(_isEditingMail)
                      {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusNodeMail.requestFocus(); // Focus after the UI is updated
                        });
                      }
                    },
                  ),
                ],
              ),
              onTap: () 
              {
              },
            ),
            ListTile(
              title: Text('Pincode'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pincodeController,
                      focusNode: _focusNodePincode,
                      enabled: _isEditingPinCode,
                      decoration: InputDecoration(
                        hintText: !_isEditingPinCode ? pincode : '',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.edit,
                      color: _isEditingPinCode ? Colors.green : Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditingPinCode = !_isEditingPinCode; // Toggle edit mode
                      });
                      if(_isEditingPinCode)
                      {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusNodePincode.requestFocus(); // Focus after the UI is updated
                        });
                      }
                    },
                  ),
                ],
              ),
              onTap: () 
              {
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () 
                {
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Save'),
                ),
              ),
            ),
            if(privelege == 2)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () 
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsers()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('MANAGE USERS'),
                ),
              ),
            ),
            if(privelege != 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () 
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceForm()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('ADD SERVICE'),
                ),
              ),
            ),
          ],
        ),
      ) : null,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              physics: const NeverScrollableScrollPhysics(), // Disable user swiping
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          if(privelege != 0)
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const OngoingOrders()));
                }, 
                icon: Icon(Icons.work,size: 40,color: Colors.grey[600],)
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PendingRequests()));
                }, 
                icon: Icon(Icons.report,size: 40,color: Colors.grey[600],)
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Orderhistory()));
                }, 
                icon: Icon(Icons.history,size: 40,color: Colors.grey[600],)
              ),
            ],
          )
        ],
      ),
    );
  }
}
