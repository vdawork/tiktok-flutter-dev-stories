import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SignUpForm extends StatefulWidget {

  const SignUpForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<SignUpForm> {
  final LocalStorage storage = new LocalStorage('sign_storage.json');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String _nickname;
  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };


  @override
  void initState() {
    _nickname = storage.getItem('nickname');
    print('initState');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nickname',
              ),
              initialValue: _nickname,
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Nickname is required';
                }
              },
              onChanged: (value) {
                setState(() {
                  _nickname = value;
                });
              }),
          const SizedBox(height: 6.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full name',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Full name is required';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Register'),
              ),
              // const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    bool valid = _formKey.currentState.validate();
    print('Form valid: ${valid.toString()}');
    print('Form submitted _nickname-${_nickname}');
    storage.setItem("nickname", _nickname);

  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: SignUpForm(),
    );
  }
}
