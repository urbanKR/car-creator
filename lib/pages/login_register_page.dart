import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcreator/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        alignLabelWithHint: true, // Align the label with the hint text
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0), // Adjust content padding
        border: OutlineInputBorder(),
      ),
      textAlign: TextAlign.center, // Center align the text within the TextField
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
      isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register instead' : 'Login instead'));
  }

  Widget _buildChessboard(context) {
    return Positioned(
      bottom: 0,
      child: Container(
        key: const Key('chessboard'),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: List.generate(
            4,
                (i) =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    15,
                        (j) =>
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 15,
                          height: 25,
                          decoration: BoxDecoration(
                            color: (i % 2 == 0)
                                ? (j % 2 == 0)
                                ? Colors.black
                                : Colors.white
                                : (j % 2 == 0)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftCircleWidget(context) {
    double circleSize = MediaQuery.of(context).size.width * 0.65;

    return Positioned(
      key: const Key('left_circle'),
      top: -circleSize * 0.5,
      left: circleSize * 0.1,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildRightCircleWidget(context) {
    double circleSize = MediaQuery.of(context).size.width * 0.65;

    return Positioned(
      key: const Key('right_circle'),
      top: -10,
      left: -circleSize * 0.6,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Car Creator',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height + 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _entryField('email', _controllerEmail),
                  _entryField('password', _controllerPassword),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton(),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: _buildChessboard(context),
          // ),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: _buildChessboard(context),
      ),
    );
  }
}