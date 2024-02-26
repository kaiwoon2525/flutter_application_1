import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/home_screen.dart';

import 'package:flutter_application_1/map.dart';
import 'package:flutter_application_1/widgets/movie_silder_fontsize.dart';
import 'package:flutter_application_1/widgets/trending_bigfontsize.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/movie.dart';

class HomeScreen_Biggerfontsize extends StatefulWidget {
  const HomeScreen_Biggerfontsize({super.key});

  @override
  State<HomeScreen_Biggerfontsize> createState() => _HomeScreenState();
}

late Future<List<Movie>> trandingMovies;
late Future<List<Movie>> ToprateMovies;
late Future<List<Movie>> upcomingMovies;

class _HomeScreenState extends State<HomeScreen_Biggerfontsize> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    trandingMovies = Api().getTrendingMovies();
    ToprateMovies = Api().getToprateMovies();
    upcomingMovies = Api().getupcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/icon.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies github',
                style: GoogleFonts.aBeeZee(fontSize: 35),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: trandingMovies,
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      // final data = snapshot.data;
                      return TrendingSider_fontSize(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Top rated movies',
                style: GoogleFonts.aBeeZee(fontSize: 35),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: ToprateMovies,
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      // final data = snapshot.data;
                      return MovieSilder_BigfontSize(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Upcoming Movies',
                style: GoogleFonts.aBeeZee(fontSize: 35),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      // final data = snapshot.data;
                      return MovieSilder_BigfontSize(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_size),
            label: 'Font Size',
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
      ),
    );
  }
}
