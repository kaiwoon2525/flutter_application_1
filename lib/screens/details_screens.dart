import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/widgets/back_button.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, required this.movie});
  int currentIndex = 0;

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const backbutton(),
          backgroundColor: Colours.scaffoldBgColor,
          expandedHeight: 500,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              movie.title,
              style: GoogleFonts.belleza(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                '${Constants.imagePath}${movie.backdrop_path}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.belleza(
                        fontSize: 27, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    movie.overview,
                    style: GoogleFonts.belleza(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Row(
                      // One row end one row start
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                'Release date: ',
                                style: GoogleFonts.belleza(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                movie.release_date,
                                style: GoogleFonts.belleza(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            Text(
                              'Rate',
                              style: GoogleFonts.belleza(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              '${movie.vote_average.toStringAsFixed(1)}/10',
                              style: GoogleFonts.belleza(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
            // Navigate to the home screen page
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (index == 1) {
            // Navigate to the search screen page
            // Assuming you have a '/search' route defined
            Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 2) {
            // Navigate to the favorites screen page
            // Assuming you have a '/favorites' route defined
            Navigator.pushReplacementNamed(context, '/favorites');
          }
        },
      ),
    );
  }
}
