import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/constants/assest_path.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';

class FloatingMenuButton extends StatefulWidget {
  final Function(bool isOpen) onToggle;
  final bool isOpen;
  final bool isGuest;
  final bool isVisible;
  final FloatingMenuButtonNavigation currentNavigation;
  final bool isSamePageNavigation;

  const FloatingMenuButton({
    Key key,
    this.onToggle,
    this.isOpen,
    this.isGuest = false,
    this.isVisible = true,
    this.currentNavigation = FloatingMenuButtonNavigation.HOME,
    this.isSamePageNavigation,
  }) : super(key: key);

  @override
  _FloatingMenuButtonState createState() => _FloatingMenuButtonState();
}

class _FloatingMenuButtonState extends State<FloatingMenuButton>
    with TickerProviderStateMixin {
  double initialRadius = 35;
  double finalRadius = 120;
  double radius;
  double buttonRadius;
  double leftButtonPosition = 5;
  double rightButtonPosition = 5;
  double topButtonPosition = 5;
  double bottomButtonPosition = 5;
  double mainButtonPosition = -100;

  Alignment userAlignment;
  Alignment homeAlignment;
  Alignment bookmarkAlignment;
  Alignment frontAlignment;

  FloatingMenuButtonNavigation selectedNavigation;

  bool isOpen = false;
  AnimationController _controller;
  Duration animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        mainButtonPosition = 15;
      });
    });
    super.initState();
    selectedNavigation = widget.currentNavigation;
    radius = initialRadius;
    buttonRadius = initialRadius - 5;
    userAlignment = Alignment.center;
    homeAlignment = Alignment.center;
    bookmarkAlignment = Alignment.center;
    frontAlignment = Alignment.center;
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
  }

  toggleButton() {
    if (widget.onToggle != null) {
      widget.onToggle(!isOpen);
    }
    isOpen ? setClosed() : setOpened();
  }

  showButton() {
    mainButtonPosition = 15;
  }

  hideButton() {
    mainButtonPosition = -100;
  }

  setOpened() {
    radius = finalRadius;
    leftButtonPosition = 20;
    rightButtonPosition = 70;
    topButtonPosition = 20;
    bottomButtonPosition = 20;
    mainButtonPosition = -50;
    userAlignment = Alignment.centerLeft;
    homeAlignment = Alignment.topCenter;
    bookmarkAlignment = Alignment.bottomCenter;
    frontAlignment = Alignment.centerRight;
    _controller.forward();
    isOpen = !isOpen;
  }

  setClosed() {
    radius = initialRadius;
    leftButtonPosition = 5;
    rightButtonPosition = 5;
    topButtonPosition = 5;
    bottomButtonPosition = 5;
    mainButtonPosition = 15;
    userAlignment = Alignment.center;
    homeAlignment = Alignment.center;
    bookmarkAlignment = Alignment.center;
    frontAlignment = Alignment.center;
    _controller.reverse();
    isOpen = !isOpen;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FloatingMenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      widget.isOpen ? setOpened() : setClosed();
      isOpen = widget.isOpen;
    }
    if (oldWidget.isVisible != widget.isVisible) {
      widget.isVisible ? showButton() : hideButton();
    }
    if (!widget.isSamePageNavigation) {
      selectedNavigation = widget.currentNavigation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          right: mainButtonPosition,
          bottom: 15,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedSize(
                duration: Duration(milliseconds: 100),
                vsync: this,
                child: CircleAvatar(
                  backgroundColor: AppColors.lightOrange,
                  radius: radius,
                ),
              ),
              AnimatedPositioned(
                left: leftButtonPosition,
                top: topButtonPosition,
                bottom: bottomButtonPosition,
                right: rightButtonPosition,
                duration: Duration.zero,
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: animationDuration,
                      alignment: homeAlignment,
                      child: RotationTransition(
                        turns: _controller,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.isSamePageNavigation) {
                                selectedNavigation =
                                    FloatingMenuButtonNavigation.HOME;
                              }

                              toggleButton();
                              if (selectedNavigation !=
                                  FloatingMenuButtonNavigation.HOME) {
                                goToDashboard();
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: selectedNavigation !=
                                    FloatingMenuButtonNavigation.HOME
                                ? AppColors.blueButton
                                : Colors.white,
                            radius: buttonRadius,
                            child: ImageIcon(
                              AssetImage(AppImages.home),
                              color: selectedNavigation ==
                                      FloatingMenuButtonNavigation.HOME
                                  ? AppColors.blueButton
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: animationDuration,
                      alignment: userAlignment,
                      child: RotationTransition(
                        turns: _controller,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.isSamePageNavigation) {
                                selectedNavigation =
                                    FloatingMenuButtonNavigation.PROFILE;
                              }

                              toggleButton();
                              if (selectedNavigation !=
                                  FloatingMenuButtonNavigation.PROFILE) {
                                goToProfile();
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: selectedNavigation !=
                                    FloatingMenuButtonNavigation.PROFILE
                                ? AppColors.blueButton
                                : Colors.white,
                            radius: buttonRadius,
                            child: ImageIcon(
                              AssetImage(AppImages.user),
                              color: selectedNavigation ==
                                      FloatingMenuButtonNavigation.PROFILE
                                  ? AppColors.blueButton
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: animationDuration,
                      alignment: bookmarkAlignment,
                      child: RotationTransition(
                        turns: _controller,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.isSamePageNavigation) {
                                selectedNavigation =
                                    FloatingMenuButtonNavigation.BOOKMARK;
                              }

                              toggleButton();
                              if (selectedNavigation !=
                                  FloatingMenuButtonNavigation.BOOKMARK) {
                                goToBookings();
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: selectedNavigation !=
                                    FloatingMenuButtonNavigation.BOOKMARK
                                ? AppColors.blueButton
                                : Colors.white,
                            radius: buttonRadius,
                            child: ImageIcon(
                              AssetImage(AppImages.bookmark),
                              color: selectedNavigation ==
                                      FloatingMenuButtonNavigation.BOOKMARK
                                  ? AppColors.blueButton
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: animationDuration,
                      alignment: frontAlignment,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            toggleButton();
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.blueButton,
                          radius: buttonRadius,
                          child: isOpen
                              ? ImageIcon(
                                  AssetImage(AppImages.close),
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void goToDashboard() {
    Get.toNamed(Routes.DASHBOARD);
  }

  goToBookings() {
    if (USER_TOKEN.value.length > 1)
      Get.toNamed(Routes.BOOKINGS);
    else
      Get.defaultDialog(
        title: AppStrings.loginRequired,
        middleText: AppStrings.loginRequiredDetailsForShowBookings,
        middleTextStyle: TextStyle(fontSize: 18),
        radius: 5,
        buttonColor: AppColors.lightOrange,
        confirmTextColor: Colors.white,
        textConfirm: AppStrings.login,
        onConfirm: () {
          BookingSessionManager.clearSession();
          SessionManager.clearSession();
          SessionManager.saveUserTypeAsNonGuest();
          USER_TOKEN.value = '';
          USER_DETAILS.value = UserDetails();
          Get.offAllNamed(Routes.LOGIN_AND_SIGNUP);
        },
      );
  }

  goToProfile() {
    Get.toNamed(Routes.MY_ACCOUNT);
  }
}

enum FloatingMenuButtonNavigation { HOME, PROFILE, BOOKMARK }
