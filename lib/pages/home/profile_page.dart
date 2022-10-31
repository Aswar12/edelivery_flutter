import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';

import '../../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    bool isLoading = false;
    handleLogout() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.logOut()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Anda Berhasil Logout!',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Logout!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              Dimenssions.width20,
            ),
            child: Row(
              children: [
                Container(
                  width: Dimenssions.width55,
                  height: Dimenssions.width55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        user.profilePhotoUrl,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimenssions.width15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: primaryTextStyle.copyWith(
                          fontSize: Dimenssions.font20,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: subtitleTextStyle.copyWith(
                          fontSize: Dimenssions.font16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: handleLogout,
                  child: Image.asset(
                    'assets/button_exit.png',
                    width: Dimenssions.width20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(fontSize: Dimenssions.font14),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Dimenssions.width30,
          ),
          decoration: BoxDecoration(
            color: backgroundColor3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimenssions.height20,
              ),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                  fontSize: Dimenssions.font16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: menuItem(
                  'Edit Profile',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/add-address');
                },
                child: menuItem(
                  'Add Address',
                ),
              ),
              menuItem(
                'Your Orders',
              ),
              SizedBox(
                height: Dimenssions.height30,
              ),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontSize: Dimenssions.font16,
                  fontWeight: semiBold,
                ),
              ),
              menuItem(
                'Privacy & Policy',
              ),
              menuItem(
                'Term of Service',
              ),
              menuItem(
                'Rate App',
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
