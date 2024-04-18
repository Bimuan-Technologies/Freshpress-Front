import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freshpress_customer/ui/dashboard/home/home_ui.dart';
import 'package:freshpress_customer/ui/dashboard/me/me_ui.dart';
import 'package:freshpress_customer/ui/dashboard/service/service_ui.dart';
import 'package:freshpress_customer/ui/dashboard/setting/setting_ui.dart';
import '../../bloc/identity/signin_cubit.dart';
import '../../bloc/identity/signin_state.dart';
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

  late SignInCubit _signInCubit;
  int _selectedItemIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
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

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: FreshPressColors.midBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final w = MediaQuery.of(context).size.width, h = MediaQuery.of(context).size.height;

    return Scaffold(
          bottomNavigationBar: _bottomTab(),
          body: SizedBox(
            height: h,
            child: SingleChildScrollView(
                child: BlocBuilder<SignInCubit, LoginState>(
                  builder: (context, state) {
                    if(state is LoginProgress ){
                      return SizedBox(
                        height: h,
                        width: w,
                        child: const Center(
                          // Adjust height as needed
                          child: LoadingSplash(),
                      ));
                    } else if (state is LoginSuccess){
                      return _pages[_selectedItemIndex];
                    } else if(state is LoginFailure){
                      return _pages[_selectedItemIndex];
                    } else {
                      return _pages[_selectedItemIndex];
                    }
                  },

                )
            ),
          ),
        );
  }
}


class LoadingSplash extends StatefulWidget {
  const LoadingSplash({Key? key}) : super(key: key);

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust duration as needed
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2, // Scale up to 1.2 times the original size
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Delay before animation

    _animationController.repeat(reverse: true); // Repeat the animation indefinitely with reverse

    await Future.delayed(const Duration(seconds: 2)); // Delay after animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: FreshPressColors.lightBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: FreshPressColors.lightBlue,
        body: Center(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  FreshPressImages.logoPath, // Replace with image path
                  height: 150, // Adjust size as needed
                  width: 150,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

