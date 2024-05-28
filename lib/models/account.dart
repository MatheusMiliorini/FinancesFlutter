class Account {
  int? id;
  String name;
  int initialBalance;
  int balance;
  String currency;

  Account(this.id, this.name, this.initialBalance, this.balance, this.currency);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initialBalance': initialBalance,
      'balance': balance,
      'currency': currency,
    };
  }
}
