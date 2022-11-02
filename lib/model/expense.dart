//import 'package:flutter/material.dart';
import 'package:db_test/model/db_helper.dart';
import 'package:intl/intl.dart';

class Expenses {
  late int expense_id;
  late String expense_category_code;
  //late String expense_genre_code;
  //late String payment_code;
  int? expense_total_money;
  int? expense_consuption_tax;
  late int expense_amount_including_tax;
  late DateTime expense_datetime;
  String? expense_memo;
  late DateTime created_at;
  late DateTime updated_at;

  Expenses({
    required this.expense_id,
    required this.expense_category_code,
    //required this.expense_genre_code,
    //required this.payment_code,
    this.expense_total_money,
    this.expense_consuption_tax,
    required this.expense_amount_including_tax,
    required this.expense_datetime,
    this.expense_memo,
    required this.created_at,
    //required this.updated_at
  });

  Expenses copy({
    required int expense_id,
    required String expense_category_code,
    //required String expense_genre_code,
    //required String payment_code,
    int? expense_total_money,
    int? expense_consuption_tax,
    required int expense_amount_including_tax,
    required DateTime expense_datetime,
    String? expense_memo,
    required DateTime created_at,
    //required DateTime updated_at,
  }) =>
      Expenses(
        expense_id: expense_id ?? this.expense_id,
        expense_category_code: expense_category_code ?? this.expense_category_code,
        //expense_genre_code: expense_genre_code ?? this.expense_genre_code,
        //payment_code: payment_code ?? this.payment_code,
        expense_total_money: expense_total_money ?? this.expense_total_money,
        expense_consuption_tax: expense_consuption_tax ?? this.expense_consuption_tax,
        expense_amount_including_tax: expense_amount_including_tax ?? expense_amount_including_tax,
        expense_datetime: expense_datetime ?? expense_datetime,
        expense_memo: expense_memo ?? expense_memo,
        created_at: created_at ?? created_at,
        //updated_at: updated_at ?? updated_at
      );

  static Expenses fromJson(Map<String, Object?> json) => Expenses(
    expense_id: json[columnExpenseId] as int,
    expense_category_code: json[columnExpenseCategoryCode] as String,
    //expense_genre_code: json[columnExpenseGenreCode] as String,
    //payment_code: json[columnPaymentCode] as String,
    expense_total_money: json[columnExpenseTotalMoney] as int,
    expense_consuption_tax: json[columnExpenseConsuptionTax] as int,
    expense_amount_including_tax: json[columnExpenseAmountIncludingTax] as int,
    expense_datetime: json[columnExpenseDatetime] as DateTime,
    expense_memo: json[columnExpenseMemo] as String,
    created_at: DateTime.parse(json[columnCreatedAt] as DateTime),
    //updated_at: DateTime.parse(json[columnUpdatedAt] as DateTime)
  );

  Map<String, Object> toJson() => {
    columnExpenseId: expense_id,
    columnExpenseCategoryCode: expense_category_code,
    columnExpenseTotalMoney: expense_total_money,
    columnExpenseConsuptionTax: expense_consuption_tax,
    columnExpenseAmountIncludingTax: expense_amount_including_tax,
    columnExpenseDatetime: expense_datetime,
    columnExpenseMemo: expense_memo,
    columnCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(created_at),
    //columnUpdatedAt: updated_at,
  };
}

