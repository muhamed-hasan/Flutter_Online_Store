import 'package:flutter/material.dart';
import 'package:online_store/constants/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [
                      KColorsConsts.gradiendFStart,
                      KColorsConsts.gradiendLStart
                    ],
                    [KColorsConsts.gradiendFEnd, KColorsConsts.gradiendLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: const MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: const Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  //  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://image.flaticon.com/icons/png/128/869/869636.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: const ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email Address',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: const ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: _submitForm,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 10),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                      color: KColorsConsts.backgroundColor),
                                ),
                              )),
                              onPressed: _submitForm,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.account_circle_rounded,
                                    size: 18,
                                  )
                                ],
                              )),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
