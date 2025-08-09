import 'package:flutter/material.dart';

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
      child: const Column(
        children: <Widget>[
          Text(
            'North America',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Max: 24°  Min: 18°',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection() {
    final List<Map<String, dynamic>> forecasts = [
      {'day': 'Mon', 'temp': 19, 'icon': 'assets/img/weather1.png'},
      {'day': 'Tue', 'temp': 18, 'icon': 'assets/img/weather2.png'},
      {'day': 'Wed', 'temp': 18, 'icon': 'assets/img/weather2.png'},
      {'day': 'Thu', 'temp': 19, 'icon': 'assets/img/weather1.png'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '7-Days Forecasts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18, // Reduced arrow size
              ),
              const SizedBox(width: 4.0), // Reduced spacing
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: forecasts.length,
                    itemBuilder: (context, index) {
                      final forecast = forecasts[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0), // Reduced horizontal margin
                        padding: const EdgeInsets.all(12.0),
                        width: 75, // Reduced width for each forecast card
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
                              style: const TextStyle(color: Colors.white, fontSize: 16),
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
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 4.0), // Reduced spacing
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18, // Reduced arrow size
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(Icons.waves, color: Colors.white70, size: 16),
              SizedBox(width: 8.0),
              Text(
                'AIR QUALITY',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '3-Low Health Risk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'See more',
            style: TextStyle(color: Colors.white70, fontSize: 14),
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
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}