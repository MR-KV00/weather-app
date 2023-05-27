import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whater/core/presentation/wigets/loading_image.dart';
import 'package:whater/feature/feature_whater/domain/entitis/current_city_entity.dart';
import 'package:whater/feature/feature_whater/presentation/block/cw_status.dart';
import 'package:whater/feature/feature_whater/presentation/block/home_bloc.dart';

import '../../../../core/params/forecast_params.dart';
import '../../../../core/presentation/wigets/image_backround.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../locator.dart';
import '../../data/model/ForcastDaysModel.dart';
import '../../domain/entitis/forecast_days_entity.dart';
import '../../domain/use_cases/get_suggestion_city_usecase.dart';
import '../block/fw_status.dart';
import '../wigets/day_weather_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent("minab"));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (String prefix) {
                textEditingController.text = prefix;
                BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(prefix));
              },
              controller: textEditingController,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                hintText: "Enter a City...",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            suggestionsCallback: (prefix) {
              return getSuggestionCityUseCase(prefix);
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(itemData.name!),
                subtitle: Text("${itemData.region!}, ${itemData.country!}"),
              );
            },
            onSuggestionSelected: (suggestion) {
              textEditingController.text = suggestion.name!;
              BlocProvider.of<HomeBloc>(context)
                  .add(LoadCwEvent(suggestion.name!));
            },
          ),
        ),

        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Center(
                child: LoadingImage(),
              );
            }
            if (state.cwStatus is CwCompleted) {
              ///cast
              final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
              final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;

              /// foreCast
              final ForecastParams forecastParams = ForecastParams(
                  currentCityEntity.coord?.lat, currentCityEntity.coord?.lon);

              /// start
              BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forecastParams));

              final sunrise = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunrise, currentCityEntity.timezone);
              final sunset = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunset, currentCityEntity.timezone);

              return Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: SizedBox(
                        width: width,
                        height: 430,
                        child: PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(
                                      currentCityEntity.name!,
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      currentCityEntity
                                          .weather![0].description!,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: AppBackground.setIconForMain(
                                          currentCityEntity
                                              .weather![0].description)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "${currentCityEntity.main!.temp!.round()}\u00b0",
                                      style: const TextStyle(
                                          fontSize: 50, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Text("max",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${currentCityEntity.main!.tempMax!.round()}\u00b0",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Container(
                                          width: 2,
                                          height: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const Text("min",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${currentCityEntity.main!.tempMin!.round()}\u00b0",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            }

                            if (index == 1) {
                              return Container(
                                color: Colors.blue,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 2,
                        effect: const ExpandingDotsEffect(
                          spacing: 5,
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: Colors.white,
                        ),
                        onDotClicked: (index) {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceOut);
                        },
                      ),
                    ),

                    /// divider
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        color: Colors.white24,
                        height: 2,
                        width: double.infinity,
                      ),
                    ),

                    /// forecast weather 7 days
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Center(
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen: (previous, current) {
                                if (current.cwStatus == current.cwStatus) {
                                  return false;
                                } else {
                                  return true;
                                }
                              },
                              builder: (BuildContext context, state) {

                                /// show Loading State for Fw
                                if (state.fwStatus is FwLoading) {
                                  return const LoadingImage();
                                }

                                /// show Completed State for Fw
                                if (state.fwStatus is FwCompleted) {
                                  /// casting
                                  final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                                  final ForecastDaysEntity forecastDaysEntity = fwCompleted.forecastDaysEntity;
                                  final List<Daily> mainDaily = forecastDaysEntity.daily!;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return DaysWeatherView(
                                        daily: mainDaily[index],
                                      );
                                    },
                                  );
                                }

                                /// show Error State for Fw
                                if (state.fwStatus is FwError) {
                                  final FwError fwError =
                                      state.fwStatus as FwError;
                                  return Center(
                                    child: Text(fwError.message),
                                  );
                                }

                                /// show Default State for Fw
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// divider
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        color: Colors.white24,
                        height: 2,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state.cwStatus is Error) {
              return Container();
            }

            return Container();
          },
        )
      ],
    ));
  }
}
