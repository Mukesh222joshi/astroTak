import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

class BlocBuilder extends StatelessWidget {
  //stream for this bloc-builder to listen
  final Stream<BlocResponse> stream;

  //widgets for different state
  final Widget defaultView;
  final Widget Function(BuildContext, BlocResponse)? loadingView;
  final Widget Function(BuildContext, BlocResponse)? noInternetView;
  final Widget Function(BuildContext, BlocResponse)? successView;
  final Widget Function(BuildContext, BlocResponse)? failedView;

  //callbacks for different state
  final Function(BuildContext, BlocResponse)? onSuccess;
  final Function(BuildContext, BlocResponse)? onFailed;
  final Function(BuildContext, BlocResponse)? onNoInternet;
  final Function(BuildContext, BlocResponse)? onLoading;

  BlocBuilder({
    required this.stream,
    this.defaultView = const SizedBox(),
    this.loadingView,
    this.noInternetView,
    this.successView,
    this.failedView,
    this.onFailed,
    this.onSuccess,
    this.onLoading,
    this.onNoInternet,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocResponse>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<BlocResponse> snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              _callback(context, snapshot.data!);
            });
            switch (snapshot.data?.state) {
              case BlocState.loading:
                return (loadingView == null)
                    ? defaultView
                    : loadingView!(context, snapshot.data!);
              case BlocState.noInternet:
                return (noInternetView == null)
                    ? defaultView
                    : noInternetView!(context, snapshot.data!);
              case BlocState.success:
                return (successView == null)
                    ? defaultView
                    : successView!(context, snapshot.data!);
              case BlocState.failed:
                return (failedView == null)
                    ? defaultView
                    : failedView!(context, snapshot.data!);
              default:
                return defaultView;
            }
          }
          return defaultView;
        });
  }

  Future<void> _callback(BuildContext context, BlocResponse response) async {
    if (response.state == response.prevState &&
        response.event == response.prevEvent) {
      return;
    }
    response.prevState = response.state;
    response.prevEvent = response.event;

    switch (response.state) {
      case BlocState.failed:
        if (onFailed != null) onFailed!(context, response);
        break;
      case BlocState.success:
        if (onSuccess != null) onSuccess!(context, response);
        break;
      case BlocState.loading:
        if (onLoading != null) onLoading!(context, response);
        break;
      case BlocState.noInternet:
        if (onNoInternet != null) onNoInternet!(context, response);
        break;
      default:
    }
  }
}
