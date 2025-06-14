import 'package:shoe_app/models/product_model.dart';
import 'package:flutter/services.dart' as the_bundle;

class ProductService {
  // Male
  Future<List<Product>> getMaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/men_shoes.json",
    );

    final maleList = productsFromJson(data);

    return maleList;
  }

  // Female
  Future<List<Product>> getFemaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/women_shoes.json",
    );

    final femaleList = productsFromJson(data);

    return femaleList;
  }

  // Kids
  Future<List<Product>> getKidsSneakers() async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/kids_shoes.json",
    );

    final kidsList = productsFromJson(data);

    return kidsList;
  }

  // Single Male
  Future<Product> getMaleSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/men_shoes.json",
    );

    final maleList = productsFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // Single Male
  Future<Product> getFemaleSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/women_shoes.json",
    );

    final maleList = productsFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  // Single Kids
  Future<Product> getKidsSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString(
      "assets/json/kids_shoes.json",
    );

    final maleList = productsFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}
