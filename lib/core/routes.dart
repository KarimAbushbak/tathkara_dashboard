
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tathkara_dashboard/core/resources/manager_strings.dart';
import 'package:tathkara_dashboard/features/all_booking/presntation/view/all_bookings.dart';
import 'package:tathkara_dashboard/features/booking/presntation/view/company_bookings_page.dart';
import 'package:tathkara_dashboard/features/company_login/presntation/view/company_login_view.dart';
import 'package:tathkara_dashboard/features/trip/presntation/view/add_trip_page.dart';
import 'package:tathkara_dashboard/features/trip_details/presntaiton/view/trip_details_view.dart';

import '../config/dependancy_injection.dart';
import '../features/home/presntation/view/home_view.dart';
import '../features/trip_list/presntation/view/trip_list_view.dart';



class Routes {
  static const String splashScreen = '/splash_screen';
  static const String languagePage = '/language_page';
  static const String homeView = '/homeView';
  static const String outBoarding = '/outBoardingView';
  static const String loginView = '/loginView';
  static const String registerView = '/registerView';
  static const String signUpScreen = '/signUpScreen';
  static const String profileView = '/profileView';
  static const String detailsView = '/detailsView';
  static const String settingsView = '/settingsView';
  static const String cartView = '/cartView';
  static const String brandView = '/brandView';
  static const String categoriesView = '/categoriesView';
  static const String favoriteView = '/favoriteView';
  static const String productsView = '/productsView';
  static const String addTripPage = '/addTripPage';
  static const String companyLoginView = '/companyLoginView';
  static const String bookingView = '/bookingView'; 
  static const String companyDashboardPage = '/companyDashboardPage';
  static const String tripListView = '/tripListView';
  static const String tripDetails = '/tripDetails';
  static const String allBooking = '/allBooking';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.addTripPage:
        final companyId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddTripPage(companyId: companyId),
        );
      case Routes.companyLoginView:
        iniCompanyLoginController();
        return MaterialPageRoute(builder: (_) => CompanyLoginView());
      case Routes.homeView:
        iniHome();
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.tripListView:
        initTripList();
        return MaterialPageRoute(builder: (_) => TripListView());
      case Routes.bookingView:
        final args = settings.arguments as Map<String, dynamic>;
        final companyId = args['companyId'] as String;
        final tripId = args['tripId'] as String?; // optional
        return MaterialPageRoute(
          builder: (_) => CompanyBookingsPage(companyId: companyId, tripId: tripId),
        );

      case Routes.tripDetails:
        initTripLDetails();
        return MaterialPageRoute(builder: (_) => TripDetailsView());
      case Routes.allBooking:
        final args = settings.arguments as Map<String, dynamic>;
        final companyId = args['companyId'] as String;
        return MaterialPageRoute(builder: (_) => ReservationsView(companyId: companyId,));
      // case Routes.registerView:
      //   initAuth();
      //   return MaterialPageRoute(builder: (_) => RegisterView());
      // case Routes.signUpScreen:
      //   initAuth();
      //   return MaterialPageRoute(builder: (_) => SignUpScreen());
      // case Routes.homeView:
      //   initHome();
      //   return MaterialPageRoute(builder: (_) => HomeView());
      // case Routes.categoriesView:
      //   initHome();
      //   return MaterialPageRoute(builder: (_) => CategoriesView());
      // case Routes.detailsView:
      //   final product = settings.arguments as Map<String, dynamic>;
      //   initDetails();
      //   return MaterialPageRoute(
      //       builder: (_) => ProductDetailsView(product: product));
      // case Routes.cartView:
      //   initCart();
      //   return MaterialPageRoute(builder: (_) => CartView());
      // case Routes.favoriteView:
      //   initHome();
      //   return MaterialPageRoute(builder: (_) => FavoriteView());
      // case Routes.productsView:
      //   initHome();
      //   return MaterialPageRoute(builder: (_) => ProductsView());
      // case Routes.profileView:
      //   initProfile();
      //   return MaterialPageRoute(builder: (_) => ProfileView());


      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(ManagerStrings.notFoundRoute),
        ),
      ),
    );
  }
}
