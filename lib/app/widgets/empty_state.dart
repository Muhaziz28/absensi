import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_hl5n0bwb.json',
              height: 200),
          Container(
            child: Column(
              children: [
                Text(
                  'Data Kosong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Silahkan tambahkan data anak anda',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
