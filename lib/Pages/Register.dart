import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back),color: Colors.black , onPressed: () {  },),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Create account!",
                    style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:5.0),
                    child: Text("Register to get started."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputForm(),
                  SizedBox(height: 10,),
                  Policy(),
                  Button(),
                  Center(child: Text("Or Connect Via",style: TextStyle(color: Colors.grey,))),
                  Google(),
                ],
              ),
            ),
      )
    );
  }
}

//Form
class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //1
        const Padding(
          padding: EdgeInsets.only(left:8.0),
          child: Text("Name"),
        ),
        Padding(
            padding: const EdgeInsets.only(left:8.0,right:8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder()
              ),
            ),
          ),

          //2
          const Padding(
          padding: EdgeInsets.only(left:8.0,top: 15),
          child: Text("Email/Username"),
        ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right:8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "E-mail",
                border: OutlineInputBorder()
              ),
            ),
          ),

          //3
          const Padding(
          padding: EdgeInsets.only(left:8.0,top: 15),
          child: Text("Password"),
        ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right:8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: PassState(),
              ),
            ),
          ),

          //4
          const Padding(
          padding: EdgeInsets.only(left:8.0,top: 15),
          child: Text("Confirm Password"),
        ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right:8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                border: OutlineInputBorder(),
                suffixIcon: PassState(),
              ),
            ),
          ),
      ],
    ),
    );
  }
}

//Icon see password
class PassState extends StatefulWidget {
  const PassState({super.key});

  @override
  State<PassState> createState() => _PassStateState();
}

class _PassStateState extends State<PassState> {
  bool _passwordVisible = true;
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _passwordVisible
        ? Icons.visibility
        : Icons.visibility_off,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: () {
        setState(() {
            _passwordVisible = !_passwordVisible;
        });
      },
    );
  }
}

//register button
class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SizedBox(
          height: 35,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Register'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Google extends StatelessWidget {
  const Google({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SizedBox(
          height: 35,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.purple)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    fit:BoxFit.cover
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('Google',style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  bool Tick = false;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: Tick,
                  onChanged: (bool ?value) {
                      setState(() {
                        Tick = value!;
                      });
                  },
                  activeColor: Colors.purple,
                ),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(text:"By registering, you are agreeing with our ",
                      style: TextStyle(color: Colors.grey)
                    ),
                    TextSpan(text: "Terms of Use",
                      style: TextStyle(
                        color: Colors.purple,
                        decoration: TextDecoration.underline
                      ), 
                    ),
                    TextSpan(text: " and ",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    TextSpan(text: "Privacy Policy",
                      style: TextStyle(
                        color: Colors.purple,
                        decoration: TextDecoration.underline
                      ), 
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
    );
  }
}
