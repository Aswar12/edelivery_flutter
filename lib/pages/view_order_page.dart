import 'package:edelivery_flutter/pages/view_order.dart';
import 'package:edelivery_flutter/providers/transaction_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage({Key key}) : super(key: key);

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // get order list
    getInit();
  }

  void getInit() async {
    await Provider.of<TransactionProvider>(context, listen: false)
        .getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Orders',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Dimenssions.screenWidth,
            height: Dimenssions.height40,
            child: TabBar(
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              indicatorWeight: 3,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Current',
                ),
                Tab(
                  text: 'History',
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              ViewOrder(
                isCurrent: true,
              ),
              ViewOrder(
                isCurrent: false,
              )
            ]),
          )
        ],
      ),
    );
  }
}
