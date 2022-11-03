import 'package:db_test/view/expense_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/db_helper.dart';
import '../model/expense.dart';

class ExpenseDetailEdit extends StatefulWidget {
  final Expenses? expenses;

  const ExpenseDetailEdit({Key? key, this.expenses}) : super(key: key);

  @override
  State<ExpenseDetailEdit> createState() => _ExpenseDetailEditState();
}

class _ExpenseDetailEditState extends State<ExpenseDetailEdit> {
  late int expense_id;
  //late String expense_category_code;
  late int expense_total_money;
  late int expense_consuption_tax;
  late int expense_amount_including_tax;
  late DateTime expense_datetime;
  late String expense_memo;
  late DateTime created_at;
  //final List<String> _list = <String>['男の子', '女の子', '不明']; // 性別のDropdownの項目を設定
  //late String _selected; // Dropdownの選択値を格納するエリア
  //String value = '不明'; // Dropdownの初期値
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    expense_id = widget.expenses?.expense_id ?? 0;
    //expense_category_code = widget.expenses?.expense_category_code ?? '未設定';
    expense_total_money = widget.expenses?.expense_total_money ?? 0;
    expense_consuption_tax = widget.expenses?.expense_consuption_tax ?? 0;
    expense_amount_including_tax = widget.expenses?.expense_amount_including_tax ?? 0;
    expense_datetime = widget.expenses?.expense_datetime ?? DateTime.now();
    expense_memo = widget.expenses?.expense_memo ?? '';
    created_at = widget.expenses?.created_at ?? DateTime.now();
  }

// Dropdownの値の変更を行う
  //void _onChanged(String? value) {
    //setState(() {
      //_selected = value!;
      //gender = _selected;
    //});
  //}

// 詳細編集画面を表示する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('支出編集'),
        actions: [
          buildSaveButton(), // 保存ボタンを表示する
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(children: [
            // 名前の行の設定
            const Expanded(                   // 見出し（名前）
              flex: textExpandedFlex,
              child: Text('合計金額',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                         // 名前入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: expense_total_money ,
                //decoration: const InputDecoration(
                  //hintText: '名前を入力してください',
                //),
                //validator: (name) => name != null && name.isEmpty
                    //? '名前は必ず入れてね'
                    //: null, // validateを設定
                onChanged: (expense_total_money) => setState(() => this.expense_total_money = expense_total_money),
              ),
            ),
          ]),
          // 性別の行の設定
          Row(children: [
            const Expanded(                     // 見出し（性別）
              flex: textExpandedFlex,
              child: Text('消費税',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                           // 性別をドロップダウンで設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: expense_consuption_tax,
                onChanged: (expense_amount_including_tax) => setState(() => this.expense_consuption_tax = expense_consuption_tax),
              ),
            ),
          ]),
          Row(children: [
            const Expanded(                 // 見出し（誕生日）
              flex: textExpandedFlex,
              child: Text('税込金額',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                     // 誕生日入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: expense_amount_including_tax,
                //decoration: const InputDecoration(
                  //hintText: '誕生日を入力してください',
                //),
                onChanged: (expense_amount_including_tax) =>
                    setState(() => this.expense_amount_including_tax = expense_amount_including_tax),
              ),
            ),
          ]),
          Row(children: [
            const Expanded(                     // 見出し（メモ）
                flex: textExpandedFlex,
                child: Text('日付',
                  textAlign: TextAlign.center,
                )
            ),
            Expanded(                           // メモ入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: expense_datetime,
                //decoration: const InputDecoration(
                  //hintText: 'メモを入力してください',
                //),
                onChanged: (expense_datetime) => setState(() => this.expense_datetime = expense_datetime),
              ),
            ),
          ]),
          Row(children: [
            const Expanded(                     // 見出し（メモ）
                flex: textExpandedFlex,
                child: Text('メモ',
                  textAlign: TextAlign.center,
                )
            ),
            Expanded(                           // メモ入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: expense_memo,
                //decoration: const InputDecoration(
                //hintText: 'メモを入力してください',
                //),
                onChanged: (expense_memo) => setState(() => this.expense_memo = expense_memo),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

// 保存ボタンの設定
  Widget buildSaveButton() {
    //final isFormValid = name.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: const Text('保存'),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          //primary: isFormValid ? Colors.redAccent : Colors.grey.shade700,
        ),
        onPressed: createOrUpdateExpense, // 保存ボタンを押したら実行する処理を指定する
      ),
    );
  }

// 保存ボタンを押したとき実行する処理
  void createOrUpdateExpense() async {
    final isUpdate = (widget.expenses != null);     // 画面が空でなかったら

    if (isUpdate) {
      await updateExpense();                        // updateの処理
    } else {
      await createExpense();                        // insertの処理
    }

    Navigator.of(context).pop();                // 前の画面に戻る
  }

  // 更新処理の呼び出し
  Future updateExpense() async {
    final expense = widget.expenses!.copy(              // 画面の内容をcatにセット
      expense_id: expense_id,
      expense_total_money: expense_total_money,
      expense_consuption_tax: expense_consuption_tax,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_datetime: expense_datetime,
      expense_memo: expense_memo,
      created_at: created_at,
    );

    await DBHelper.instance.update(expense);        // catの内容で更新する
  }

  // 追加処理の呼び出し
  Future createExpense() async {
    final expense = Expenses(                           // 入力された内容をcatにセット
      expense_id: expense_id,
      expense_total_money: expense_total_money,
      expense_consuption_tax: expense_consuption_tax,
      expense_amount_including_tax: expense_amount_including_tax,
      expense_datetime: expense_datetime,
      expense_memo: expense_memo,
      created_at: created_at,
    );
    await DBHelper.instance.insert(expense);        // catの内容で追加する
  }
}