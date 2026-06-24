import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pmp12project/data/models/order_menu_model.dart';
import '../bloc/checkout/checkout_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Page')),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return switch (state) {
            CheckoutInitial() || CheckoutLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CheckoutSuccess() => ListView.builder(
              // Perbaikan: b kecil pada .builder
              itemCount: state.listOrderMenu.length,
              itemBuilder: (context, index) {
                OrderMenuModel orderMenuModel = state.listOrderMenu[index];
                final menu = orderMenuModel.menuRestoModel;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        menu.imageMenu != null && menu.imageMenu!.isNotEmpty
                        ? NetworkImage(menu.imageMenu!)
                        : const AssetImage('assets/placeholder.png')
                              as ImageProvider,
                  ),
                  title: Text('${menu.name} (x${orderMenuModel.quantity})'),
                  subtitle: Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(orderMenuModel.menuRestoModel.price),
                  ),

                  trailing: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                      Text(
                        '${orderMenuModel.quantity}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          context.read<CheckoutBloc>().add(AddMenuRestoPressed(menuRestoModel: menuRestoModel))
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
            CheckoutError() => Center(child: Text(state.message)),
          };
        },
      ),
    );
  }
}
