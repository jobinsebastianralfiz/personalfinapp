import 'package:flutter/material.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/services/auth_serrvice.dart';
import 'package:personalfinanceapp/widgets/appbutton.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: AppText(data:'Profile'),
      ),
      body: Center(
        child: FutureBuilder<UserModel?>(
          future: authService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,

                    ),
                    SizedBox(height: 20),
                    AppText(
                     data: 'Name: ${user.name}',
                    color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    AppText(
                     data: 'Email: ${user.email}',
                     color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      data: 'Phone: ${user.phone}',
                      color: Colors.white,
                    ),

                    SizedBox(height: 20,),
                    
                    AppButton(
                        height: 45,
                        width: 250,
                        color: Colors.deepOrange,
                        onTap: ()async{

                         final data=await authService.logOut();

                         if(data==true){

                           Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                         }
                        }, child: AppText(data: "Logout",color: Colors.white,))
                  ],
                );
              } else {
                return Text('No user logged in');
              }
            }
          },
        ),
      ),
    );
  }
}
