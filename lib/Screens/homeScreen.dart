import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weatherProvider.dart';
import '../widgets/fadeIn.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../widgets/weatherDetail.dart';
import 'forecastHourly.dart';
import 'forecastScreen.dart';
import 'splash.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Weather Forecast',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        //backgroundColor: Color(0xFF354B5E),
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            if (weatherProv.isLocationError) {
              return LocationError();
            }
            if (weatherProv.isRequestError) {
              return RequestError();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: themeContext.primaryColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ),
                _isLoading || weatherProv.isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: themeContext.primaryColor,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          controller: _pageController,
                          children: [
                            // First Page of the Page View
                            RefreshIndicator(
                              onRefresh: () async => _refreshData(context),
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                children: [
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 250),
                                    child: MainWeather(),
                                  ),
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 500),
                                    child: WeatherDetail(),
                                  ),
                                  // FadeIn(
                                  //   curve: Curves.easeIn,
                                  //   duration: Duration(milliseconds: 500),
                                  //   child: WeatherInfo(),
                                  // ),
                                  // FadeIn(
                                  //   curve: Curves.easeIn,
                                  //   duration: Duration(milliseconds: 750),
                                  //   child: ForecastHourly(),
                                  // ),
                                ],
                              ),
                            ),
                            // Second Page of the Page View
                            FadeIn(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 750),
                              child: ForecastHourly(),
                            ),
                            //Third Page
                            ForecastScreen(),
                            //Fourth Page
                            LoadingPage(),
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
