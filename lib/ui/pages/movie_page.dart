import '../../bloc/user_bloc.dart';
import '../../features/movie/presentation/bloc/movie_bloc.dart';
import '../../injection_container.dart';
import '../../shared/page_transition.dart';
import '../../shared/shared_methods.dart';
import '../../shared/shared_value.dart';
import '../../shared/theme.dart';
import 'profile_page.dart';
import 'wallet_page.dart';
import '../widgets/browse_movie.dart';
import '../widgets/get_lucky_day.dart';
import '../widgets/now_playing_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ScrollController controller = ScrollController();
  final movieBloc = sl<MovieBloc>();

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
    controller.addListener(onScroll);

    return BlocProvider(
      create: (context) => movieBloc,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //note: HEADER
            Container(
              decoration: const BoxDecoration(
                color: accentColor1,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(
                  defaultMargin, 20, defaultMargin, 30),
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
                                .push(routeTransition(const ProfilePage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF5F558B), width: 1)),
                            child: Stack(
                              children: <Widget>[
                                const SpinKitFadingCircle(
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
                                                      ? const AssetImage(
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
                        const SizedBox(
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
                                    .push(routeTransition(const WalletPage()));
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
                    return const SpinKitFadingCircle(
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
            const BrowseMovie(),
            // ComingSoonMovie(),
            const GetLuckyDay(),
            SizedBox(
              height: 200.h,
            )
          ],
        ),
      ),
    );
  }
}
