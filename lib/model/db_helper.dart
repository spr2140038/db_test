import 'package:db_test/model/expense.dart';
import 'package:sqflite/sqflite.dart';

const String columnExpenseId = '_expense_id';
const String columnExpenseCategoryCode = 'expense_category_code';
const String columnExpenseTotalMoney = 'expense_total_money';
const String columnExpenseConsuptionTax = 'expense_consuption_tax';
const String columnExpenseAmountIncludingTax = 'expense_amount_including_tax';
const String columnExpenseDatetime = 'expense_datetime';
const String columnExpenseMemo = 'expense_memo';
const String columnCreatedAt = 'created_at';
//const String columnUpdatedAt = 'updated_at';

const List<String> columns = [
  columnExpenseId,
  columnExpenseCategoryCode,
  columnExpenseTotalMoney,
  columnExpenseConsuptionTax,
  columnExpenseAmountIncludingTax,
  columnExpenseDatetime,
  columnExpenseMemo,
  columnCreatedAt,
 //columnUpdatedAt
];

class DBHelper {
  static final DBHelper instance = DBHelper._createInstance();
  static Database? _database;

  DBHelper._createInstance();

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'expense.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE expenses(
        _expense_id INTEGER PRIMARY KEY AUTOINCREMENT,
        expense_category_code TEXT,
        expense_total_money INTEGER,
        expense_consuption_tax INTEGER,
        expense_amount_including_tax INTEGER,
        expense_datetime TEXT,
        expense_memo TEXT,
        created_at TEXT
      )
    ''');
  }

  Future<List<Expenses>> selectAllExpenses() async {
    final db = await instance.database;
    final expensesData = await db.query('expenses');
    return expensesData.map((json) => Expenses.fromJson(json)).toList();
  }

  Future<Expenses> expenseData(int expense_id) async {
    final db = await instance.database;
    var expense = [];
    expense = await db.query(
      'expenses',
      columns: columns,
      where: '_expense_id = ?',
      whereArgs: [expense_id],
    );
    return Expenses.fromJson(expense.first);
  }

  Future insert(Expenses expenses) async {
    final db = await database;
    return await db.insert(
      'expenses',
      expenses.toJson()
    );
  }

  Future update(Expenses expenses) async {
    final db = await database;
    return await db.update(
      'expenses',
      expenses.toJson(),
      where: '_expense_id = ?',
      whereArgs: [expenses.expense_id],
    );
  }

  Future delete(int expenses_id) async {
    final db = await instance.database;
    return await db.delete(
      'expenses',
      where: 'expenses_id = ?',
      whereArgs: [expenses_id],
    );
  }
}


