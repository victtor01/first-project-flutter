import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/components/custom_input.dart';
import 'package:test/utils/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> stores = [];

  Future<void> _fetchProdutos() async {
    try {
      Response response =
          await ApiService.dio.get("http://10.220.0.8:5039/stores/my");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Resposta: ${response.data}")),
      );

      setState(() {
        stores = response.data;
      });
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Houve um erro $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 60),
                  height: 180,
                  decoration: BoxDecoration(
                      color: AppColors.indigo600,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(50, 40),
                          bottomRight: Radius.elliptical(50, 40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "José Victor",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -30,
              left: 60,
              right: 60,
              child: Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Hamburgueria",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.indigo600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
