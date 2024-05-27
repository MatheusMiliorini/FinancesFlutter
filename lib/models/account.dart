class Account {
  final int? id;
  final String name;
  final int initialBalance;
  final int balance;
  final String currency;

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
