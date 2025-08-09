import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF261D4C),
              Color(0xFF4C3691),
              Color(0xFF8B64C2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // Top Section: Location and current temp
              _buildTopSection(),
              // 7-Day Forecast Section
              _buildForecastSection(),
              // Air Quality Section
              _buildAirQualitySection(),
              // Sunrise and UV Index Section
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'North America',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Max: 24°  Min: 18°',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection() {
    // ScrollController to control the ListView
    final ScrollController _scrollController = ScrollController();
    final List<Map<String, dynamic>> forecasts = [
      {'day': 'Mon', 'temp': 19, 'icon': 'assets/img/weather1.png'},
      {'day': 'Tue', 'temp': 18, 'icon': 'assets/img/weather2.png'},
      {'day': 'Wed', 'temp': 18, 'icon': 'assets/img/weather2.png'},
      {'day': 'Thu', 'temp': 19, 'icon': 'assets/img/weather1.png'},
      {'day': 'Fri', 'temp': 20, 'icon': 'assets/img/weather1.png'},
      {'day': 'Sat', 'temp': 22, 'icon': 'assets/img/weather2.png'},
      {'day': 'Sun', 'temp': 21, 'icon': 'assets/img/weather1.png'},
    ];

    // Function to scroll the list to the next item
    void _scrollNext() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 83,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }

    // Function to scroll the list to the previous item
    void _scrollPrevious() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset - 83,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '7-Days Forecasts',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: _scrollPrevious,
              ),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: forecasts.length,
                    itemBuilder: (context, index) {
                      final forecast = forecasts[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        width: 75,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: index == 1 || index == 3
                              ? Border.all(color: Colors.yellow, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${forecast['temp']}°C',
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Image.asset(
                              forecast['icon'],
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              forecast['day'],
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: _scrollNext,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAirQualitySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.waves, color: Colors.white70, size: 16),
              const SizedBox(width: 8.0),
              Text(
                'AIR QUALITY',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '3-Low Health Risk',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'See more',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildInfoCard(
              title: 'SUNRISE',
              value: '5:28 AM',
              subtitle: 'Sunset: 7.25 PM',
              icon: Icons.wb_sunny,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _buildInfoCard(
              title: 'UV INDEX',
              value: '4',
              subtitle: 'Moderate',
              icon: Icons.wb_sunny,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}