part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (_, authenticationState) {
          if (authenticationState is Authenticated) {
            String userId = authenticationState.userId;

            context.read<UserBloc>().add(LoadUser(userId));
            context.read<TicketBloc>().add(GetTickets(userId));

            Navigator.of(context).pushReplacement(routeTransition(MainPage()));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 136,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'))),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 16),
                child: Text(
                  'New Experience',
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
              ),
              Text(
                'Watch a new movie much\neasier than any before',
                style: greyTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 250,
                height: 46,
                margin: EdgeInsets.only(top: 70, bottom: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      textStyle: whiteTextFont.copyWith(fontSize: 16)),
                  child: Text(
                    'Get Started',
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(routeTransition(SignUpPage(RegistrationData())));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account? ',
                    style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(routeTransition(SignInPage()));
                    },
                    child: Text(
                      'Sign In',
                      style: purpleTextFont,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
