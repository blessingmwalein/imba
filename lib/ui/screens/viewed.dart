import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imba/ui/layouts/home_layout.dart';

import '../../bloc/views/views_bloc.dart';
import '../../bloc/views/views_event.dart';
import '../../bloc/views/views_state.dart';
import '../../data/models/house_response.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_listview.dart';
import '../widgets/loading_indicator.dart';

class Viewed extends StatefulWidget {
  const Viewed({Key? key}) : super(key: key);

  @override
  State<Viewed> createState() => _ViewedState();
}

class _ViewedState extends State<Viewed> {
  List<HouseResponse> viewedHouses = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ViewedBloc>(context).add(GetViewedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      title: 'Viewed',
      hasBack: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Viewed",
      style: GoogleFonts.montserrat(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorConstants.yellow,
      ),
    );
  }

  Widget _buildDivider() {
    return const Stack(
      children: [
        Divider(),
        SizedBox(
          width: 50,
          child: Divider(thickness: 5, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return BlocListener<ViewedBloc, ViewedState>(
      listener: (context, state) {
        if (state is ViewedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Loaded successfully'),
              duration: Duration(seconds: 1),
            ),
          );
        } else if (state is ViewedFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to load'),
              duration: Duration(seconds: 1),
            ),
          );
          BlocProvider.of<ViewedBloc>(context).add(ViewedResetEvent());
        }
      },
      child: BlocBuilder<ViewedBloc, ViewedState>(
        builder: (context, state) {
          if (state is ViewedLoadingState) {
            return const LoadingIndicator();
          } else if (state is ViewedSuccessState) {
            viewedHouses = state.viewedResponse;
            return viewedHouses.isEmpty
                ? _buildEmptyState()
                : CustomListView(
                    uploadsResponse: viewedHouses,
                    isPage: "viewed",
                  );
          } else if (state is ViewedFailedState) {
            return _buildErrorState(state.message);
          }

          return CustomListView(
            uploadsResponse: viewedHouses,
            isPage: "viewed",
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return  SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty_rounded, size: 100, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Nothing here",
            style: GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 100, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomElevateButton(
            onSubmit: () {
              BlocProvider.of<ViewedBloc>(context).add(GetViewedEvent());
            },
            color: ColorConstants.yellow,
            name: "Retry",
          ),
        ],
      ),
    );
  }
}
