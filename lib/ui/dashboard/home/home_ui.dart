import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshpress_customer/common/constants/freshpress_color.dart';

import '../../../bloc/user/user_cubit.dart';
import '../../../bloc/user/user_state.dart';
import '../../../common/cache/local_caching.dart';
import '../../../data/models/user/user_detail_response_model.dart';

class HomeUI extends StatefulWidget {
  static const routeName = '/dashboard-home';
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  final LocalCache _localCache = LocalCache();
  late UserCubit _userCubit;
  late UserResponseModel _userResponseModel;

  @override
  void initState(){
    super.initState();
    _userCubit = BlocProvider.of<UserCubit>(context);
    _initHomeFromCache();
  }

  Future<void> _initHomeFromCache() async {
    if(true){
      _initHomeFromDataLayer();
    }
  }

  void _initHomeFromDataLayer() async {
    await _userCubit.fetchUserDetails();
  }

  Future<void> _refresh() async {
    await _userCubit.fetchUserDetails();
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

    return SafeArea(
        child: Scaffold(

          body: RefreshIndicator(
            color: FreshPressColors.lightBlue,
            backgroundColor: FreshPressColors.whiteColor,
            onRefresh: _refresh,
            child:  SingleChildScrollView(
              child: BlocBuilder<UserCubit, UserDetailsState>(
                builder: (context, state) {
                  if(state is UserDetailsProgress){
                    return   SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(color: FreshPressColors.lightBlue,))
                    );
                  } else if(state is UserDetailsSuccess){
                    _userResponseModel = state.data;
                    return buildHomeUI(w, h, _userResponseModel);
                  } else if(state is UserDetailsFailure){
                    return buildHomeUI(w, h,);
                  } else {
                    return buildHomeUI(w, h,);
                  }
                },
              ),
            ),
          ),
        )
    );
  }

  Widget buildHomeUI(double w, double h, [UserResponseModel? userResponseModel]){

    return userResponseModel != null ?

    SizedBox(
      width: w,
      height: h,
      child: Center(child: Text("Bienvenue\n${userResponseModel.userData.email}", textAlign: TextAlign.center, style: TextStyle(color: FreshPressColors.midBlue, fontSize: 28, fontWeight: FontWeight.w500),),),
    ) :  SizedBox(
      width: w,
    );
  }
}
