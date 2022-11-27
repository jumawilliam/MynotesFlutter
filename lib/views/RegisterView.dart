import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypersonalnotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  
  @override
  void initState() {
    // TODO: implement initState
    _email= TextEditingController();
    _password=TextEditingController();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text('Register')
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                 options: DefaultFirebaseOptions.currentPlatform,
               ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          
            case ConnectionState.done:
            
         return Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText:  'Enter your email here',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
              ),
              
            ),
            TextButton(onPressed: () async {
              
              final email= _email.text;
              final password=_password.text;
              try{
              final UserCredential=
              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
              print(UserCredential);
              }on FirebaseAuthException catch(e){
                  if(e.code=='invalid-email'){
                    print('The email address is badly formatted');
                  }else if(e.code=='email-already-in-use'){
                    print('The email is already taken');
                  print(e);
                  }else if(e.code=='internal-error'){
                    print('something wrong has happened');
                  }
                  
              }
              
            },
            child: const Text('Register'),
            ),
          ],
        );

        default:
        return const Text('Loading');
          }
  
         
        },
        
      ),
    );
  }
}




