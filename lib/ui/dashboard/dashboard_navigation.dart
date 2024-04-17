import 'package:flutter/material.dart';
import 'package:freshpress_customer/ui/dashboard/home/home_ui.dart';
import 'package:freshpress_customer/ui/dashboard/me/me_ui.dart';
import 'package:freshpress_customer/ui/dashboard/service/service_ui.dart';
import 'package:freshpress_customer/ui/dashboard/setting/setting_ui.dart';

import '../../common/constants/freshpress_color.dart';
import '../../common/constants/freshpress_image_path.dart';
import 'booking/booking_ui.dart';

class DashboardNavigation extends StatefulWidget {

  static const routeName = '/dashboard-bottom-navigation';

  const DashboardNavigation({super.key});

  @override
  State<DashboardNavigation> createState() => _DashboardNavigationState();
}

class _DashboardNavigationState extends State<DashboardNavigation> {

  int _selectedItemIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _pages = [
      const HomeUI(),
      const BookingUI(),
      const ServiceUI(),
      const SettingsUI(),
      const MeUI()
    ];

    setState(() {});
  }


  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null && args.containsKey('initialSelectedIndex')) {
      setState(() {
        _selectedItemIndex = args['initialSelectedIndex'];
      });
    }
  }

  Widget _bottomTab(){
    return BottomNavigationBar(
        currentIndex: _selectedItemIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: FreshPressColors.whiteColor,
        selectedItemColor: FreshPressColors.darkBlue,
        unselectedItemColor: Colors.black54,
        elevation: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 14,
        items:   <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Home', FreshPressImages.homeIcon),
            activeIcon: customBottomNav(context, true, 'Home', FreshPressImages.homeIconColored),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Booking', FreshPressImages.bookingIcon),
            activeIcon: customBottomNav(context, true, 'Booking', FreshPressImages.bookingIconColored),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Service', FreshPressImages.serviceIcon),
            activeIcon: customBottomNav(context, true, 'Service', FreshPressImages.serviceIconColored),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Settings', FreshPressImages.settingsIcon),
            activeIcon: customBottomNav(context, true, 'Settings', FreshPressImages.settingsColored),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Me', FreshPressImages.meIcon),
            activeIcon: customBottomNav(context, true, 'Me', FreshPressImages.meIconColored),
            label: '',
          ),
        ]
    );
  }


  void _onTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  Widget customBottomNav(BuildContext context, bool isActiveIcon, String text, String icon) {
    if (isActiveIcon) {
      return Column(
        children: [
          Image.asset(icon, height: 20, width: 20),
          const SizedBox(height: 5,),
          Text('$text', style: const TextStyle(fontSize: 16, color: FreshPressColors.midBlue, fontWeight: FontWeight.w600)),
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(icon, height: 16, width: 16, color: Colors.black),
          Text('$text', style: TextStyle()),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child:  Scaffold(
          bottomNavigationBar: _bottomTab(),
          body: _pages[_selectedItemIndex],
        ),
      ),
    );
  }
}
