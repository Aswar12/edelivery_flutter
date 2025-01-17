import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Register!',
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
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font26,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Register and Happy Shoping',
              style: subtitleTextStyle,
            ),
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Container(
              height: Dimenssions.height45,
              padding: EdgeInsets.symmetric(
                horizontal: Dimenssions.height15,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_name.png',
                      width: Dimenssions.height20,
                    ),
                    SizedBox(
                      width: Dimenssions.width15,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: nameController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Full Name',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneNumberInput() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Container(
              height: Dimenssions.height50,
              padding: EdgeInsets.symmetric(
                horizontal: Dimenssions.height15,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_phone.png',
                      width: Dimenssions.height20,
                    ),
                    SizedBox(
                      width: Dimenssions.width15,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: phoneNumberController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Phone Number',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Container(
              height: Dimenssions.height50,
              padding: EdgeInsets.symmetric(
                horizontal: Dimenssions.height15,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_username.png',
                      width: Dimenssions.width20,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: usernameController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Username',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Container(
              height: Dimenssions.height50,
              padding: EdgeInsets.symmetric(
                horizontal: Dimenssions.width15,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_email.png',
                      width: Dimenssions.width20,
                    ),
                    SizedBox(
                      width: Dimenssions.width15,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Email Address',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Container(
              height: Dimenssions.width50,
              padding: EdgeInsets.symmetric(
                horizontal: Dimenssions.width15,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_password.png',
                      width: Dimenssions.width20,
                    ),
                    SizedBox(
                      width: Dimenssions.width15,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Password',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: Dimenssions.width50,
        width: double.infinity,
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: TextButton(
          onPressed: handleSignUp,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign Up',
            style: primaryTextStyle.copyWith(
              fontSize: Dimenssions.font18,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: Dimenssions.height30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Sign In',
                style: purpleTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              nameInput(),
              usernameInput(),
              phoneNumberInput(),
              emailInput(),
              passwordInput(),
              isLoading ? const LoadingButton() : signUpButton(),
              const Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
