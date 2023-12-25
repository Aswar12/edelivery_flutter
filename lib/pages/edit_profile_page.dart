import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    bool isLoading = false;
    nameController.text = user.name;
    userNameController.text = user.username;
    phoneNumberController.text = user.phoneNumber;
    handleUpdateData() async {
      if (authProvider.pickedFile != null) {
        await authProvider.upload();
      }
      if (await authProvider.updateDataUser(
        name: nameController.text,
        username: userNameController.text,
        phoneNumber: phoneNumberController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: mainColor,
            content: const Text(
              'profile anda berhasil di update',
              textAlign: TextAlign.center,
            ),
          ),
        );
        authProvider.fetch();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Update data',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(color: primaryTextColor),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
            onPressed: handleUpdateData,
          )
        ],
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: nameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: user.name,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: userNameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: '@${user.username}',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: emailController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: user.email,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneNumber() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: phoneNumberController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: user.phoneNumber,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => authProvider.pickImage(),
              child: authProvider.pickedFile != null
                  ? Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: defaultMargin,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(authProvider.pickedFile.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: defaultMargin,
                      ),
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
            ),
            nameInput(),
            usernameInput(),
            phoneNumber(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
