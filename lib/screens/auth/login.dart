import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all( 16.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox( height: MediaQuery.of(context).size.height * 0.05),
                Image.asset( 'assets/images/logo.jpeg'),
                SizedBox( height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Welcome back!',
                style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith( fontWeight: FontWeight.w600,
                    color: Colors.black)), 
                const SizedBox( height: 16),
                const Text('Please login to access the system'),
                const SizedBox( height: 32 ),
                Form(
                  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Email address',
                          style: Theme.of( context)
                          .textTheme.titleSmall,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email address'
                          ),
                        ),
                        const SizedBox( height: 24 ),
                        Text(
                          'Password',
                          style: Theme.of(context)
                          .textTheme
                          .titleSmall,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ?
                                    Icons.visibility_off :
                                    Icons.visibility
                              ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                } )
                          ),
                        ),

                        MaterialButton(
                            onPressed: () {

                            },
                          height: 48,
                          minWidth: double.infinity,
                          color: const Color( 0xFFF2994A ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide.none
                          ),
                          elevation: 0,
                          child: const Text(
                            'Login',
                            style: TextStyle( color: Colors.white),
                          ),
                        )
                      ],
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
