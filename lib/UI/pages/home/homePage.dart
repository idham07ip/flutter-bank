import 'package:flutter/material.dart';
import 'package:flutter_bank/UI/widgets/homeLatestTransactionItems.dart';
import 'package:flutter_bank/UI/widgets/homeServiceItems.dart';
import 'package:flutter_bank/UI/widgets/homeTipsItems.dart';
import 'package:flutter_bank/UI/widgets/homeUserItems.dart';
import 'package:flutter_bank/bloc/auth/authBloc.dart';
import 'package:flutter_bank/bloc/auth/authState.dart';
import 'package:flutter_bank/shared/sharedMethods.dart';
import 'package:flutter_bank/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: lightBackgroundColor,
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        elevation: 0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          elevation: 0,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: blueTextStyle.copyWith(
            fontSize: 11,
            fontWeight: bold,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 11,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_overview.png',
                width: 20,
                color: blueColor,
              ),
              label: 'Overview',
            ),

            //
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_history.png',
                width: 20,
              ),
              label: 'History',
            ),

            //
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_statistic.png',
                width: 20,
              ),
              label: 'Statistic',
            ),

            //
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_reward.png',
                width: 20,
              ),
              label: 'Reward',
            ),
          ],
        ),
      ),

      //FLOATING_ACTION_BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blueColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
      ),

      //Button_Center_Position
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          //
          buildProfile(context),
          buildWalletCard(),
          buildLevel(),
          buildServices(context),
          buildLatestTransaction(),
          buildSendAgain(),
          buildFriendlyTips(),
        ],
      ),
    );
  }

  //
  Widget buildProfile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            margin: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.username.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: state.user.profilePicture == null
                              ? const AssetImage(
                                  'assets/img_profile.png',
                                )
                              : NetworkImage(
                                  state.user.profilePicture!,
                                ) as ImageProvider,
                        ),
                      ),
                      child: state.user.verified == 1
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: greenLineColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildWalletCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.only(
              top: 30,
            ),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 5.0,
                  offset: const Offset(4, 7),
                ),
              ],
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/card.png',
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.user.name.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  '**** **** **** ${state.user.cardNumber!.substring(12, 16)}',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'Balance',
                  style: whiteTextStyle,
                ),
                Text(
                  formatCurrency(state.user.balance ?? 0),
                  style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  //level/Progress
  Widget buildLevel() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Level 1',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              const Spacer(),
              Text(
                '55% ',
                style: greenTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'of ${formatCurrency(20000)}',
                style: blackTextStyle.copyWith(
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: LinearProgressIndicator(
              value: 0.55,
              minHeight: 6,
              valueColor: AlwaysStoppedAnimation(
                greenLineColor,
              ),
              backgroundColor: lightBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  //Services
  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do Something',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeServiceItem(
                iconUrl: 'assets/ic_topup.png',
                title: 'Top Up',
                onTap: () {
                  Navigator.pushNamed(context, '/topup');
                },
              ),

              //
              HomeServiceItem(
                iconUrl: 'assets/ic_send.png',
                title: 'Send',
                onTap: () {
                  Navigator.pushNamed(context, '/transfer');
                },
              ),

              //
              HomeServiceItem(
                iconUrl: 'assets/ic_withdraw.png',
                title: 'Withdraw',
                onTap: () {},
              ),

              //
              HomeServiceItem(
                iconUrl: 'assets/ic_more.png',
                title: 'More',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const MoreDialog(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  //latest_transaction
  Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Transaction',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(22),
            margin: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              children: [
                HomeLatestTransaction(
                  iconUrl: 'assets/ic_transaction_cat1.png',
                  title: 'Top Up',
                  time: 'Yesterday',
                  value: '+ ${formatCurrency(450000, symbol: '')}',
                ),

                //
                HomeLatestTransaction(
                  iconUrl: 'assets/ic_transaction_cat2.png',
                  title: 'Cashback',
                  time: 'Sept 11',
                  value: '+  ${formatCurrency(22000, symbol: '')}',
                ),

                //
                HomeLatestTransaction(
                  iconUrl: 'assets/ic_transaction_cat3.png',
                  title: 'Withdraw',
                  time: 'Sept 2',
                  value: '-  ${formatCurrency(5000, symbol: '')}',
                ),

                //
                HomeLatestTransaction(
                  iconUrl: 'assets/ic_transaction_cat4.png',
                  title: 'Transfer',
                  time: 'Aug 27',
                  value: '-  ${formatCurrency(123500, symbol: '')}',
                ),

                //
                HomeLatestTransaction(
                  iconUrl: 'assets/ic_transaction_cat5.png',
                  title: 'Electric',
                  time: 'Feb 18',
                  value: '-  ${formatCurrency(12300000, symbol: '')}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Send_again
  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Again',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),

          //
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeUserItems(
                  imgUrl: 'assets/img_friend1.png',
                  username: 'linda',
                ),
                HomeUserItems(
                  imgUrl: 'assets/img_friend2.png',
                  username: 'kokom',
                ),
                HomeUserItems(
                  imgUrl: 'assets/img_friend3.png',
                  username: 'sutedjo',
                ),
                HomeUserItems(
                  imgUrl: 'assets/img_friend4.png',
                  username: 'djajang',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //friendly_tips
  Widget buildFriendlyTips() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friendly Tips',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 17,
            runSpacing: 18,
            children: [
              HomeTipsItems(
                imgUrl: 'assets/img_tips1.png',
                title: 'Best tips for using a credit card',
                url: 'https://www.google.com/',
              ),

              //
              HomeTipsItems(
                imgUrl: 'assets/img_tips2.png',
                title: 'Spot the good pie of finance model',
                url: 'https://www.google.com/',
              ),

              //
              HomeTipsItems(
                imgUrl: 'assets/img_tips3.png',
                title: 'Great hack to get better advices',
                url: 'https://www.google.com/',
              ),

              //
              HomeTipsItems(
                imgUrl: 'assets/img_tips4.png',
                title: 'Save more penny buy this instead',
                url: 'https://www.mywebsitedualipa.com/',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: lightBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 13),

            //
            Wrap(
              spacing: 29,
              runSpacing: 25,
              children: [
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_data.png',
                  title: 'Data',
                  onTap: () {
                    Navigator.pushNamed(context, '/data-provider');
                  },
                ),

                //
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_water.png',
                  title: 'Water',
                  onTap: () {},
                ),

                //
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_stream.png',
                  title: 'Stream',
                  onTap: () {},
                ),

                //
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_movie.png',
                  title: 'Movie',
                  onTap: () {},
                ),

                //
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_food.png',
                  title: 'Food',
                  onTap: () {},
                ),

                //
                HomeServiceItem(
                  iconUrl: 'assets/ic_product_travel.png',
                  title: 'Travel',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
