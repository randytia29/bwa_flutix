part of 'pages.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ScrollController controller = ScrollController();
  final movieBloc = sl<MovieBloc>();

  // late MovieBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (currentScroll == maxScroll) movieBloc.add(FetchMovies());
  }

  @override
  void initState() {
    movieBloc.add(FetchMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bloc = BlocProvider.of<MovieBloc>(context);
    controller.addListener(onScroll);

    return BlocProvider(
      create: (context) => movieBloc,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //note: HEADER
            Container(
              decoration: BoxDecoration(
                  color: accentColor1,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  if (userState is UserLoaded) {
                    if (imageFileToUpload != null) {
                      uploadImage(imageFileToUpload!).then((downloadURL) {
                        imageFileToUpload = null;
                        context
                            .read<UserBloc>()
                            .add(UpdateData(profileImage: downloadURL));
                      });
                    }
                    return Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context)
                                .push(routeTransition(ProfilePage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF5F558B), width: 1)),
                            child: Stack(
                              children: <Widget>[
                                SpinKitFadingCircle(
                                  color: accentColor2,
                                  size: 50,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              ((userState.user.profilePicture ==
                                                          '')
                                                      ? AssetImage(
                                                          'assets/user_pic.png')
                                                      : NetworkImage(userState
                                                          .user
                                                          .profilePicture!))
                                                  as ImageProvider<Object>,
                                          fit: BoxFit.cover)),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  78,
                              child: Text(
                                userState.user.name!,
                                style: whiteTextFont.copyWith(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(routeTransition(WalletPage()));
                              },
                              child: Text(
                                NumberFormat.currency(
                                        locale: 'id_ID',
                                        decimalDigits: 0,
                                        symbol: 'IDR ')
                                    .format(userState.user.balance),
                                style: yellowNumberFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  } else {
                    return SpinKitFadingCircle(
                      color: accentColor2,
                      size: 50,
                    );
                  }
                },
              ),
            ),
            NowPlayingMovie(
              controller: controller,
            ),
            BrowseMovie(),
            // ComingSoonMovie(),
            GetLuckyDay(),
            SizedBox(
              height: 200.h,
            )
          ],
        ),
      ),
    );
  }
}
