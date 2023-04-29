import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:provider/provider.dart';

class CouruselLinker extends StatelessWidget {
  const CouruselLinker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
          ),
          items: snapshot.data?.map((user) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    userHndl.linkerEmail = user.email;
                    Navigator.of(context).pushNamed('/operations');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.yellow.shade800,
                        // image: const DecorationImage(
                        //   image: AssetImage(
                        //       "assets/images/backgrounds/online-users.png"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.userName ?? "",
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF000B49),
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              user.email ?? "",
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF000B49),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
