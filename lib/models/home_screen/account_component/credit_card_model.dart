class CreditCardModel {
  final String customerName;
  final String expiredDay;
  final String cardNumber;
  final String typeOfCard;
  CreditCardModel({
    required this.cardNumber,
    required this.expiredDay,
    required this.customerName,
    required this.typeOfCard,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      CreditCardModel(
        cardNumber: json['cardNumber'],
        expiredDay: json['expiredDay'],
        customerName: json[' customerName'],
        typeOfCard: json['typeOfCard'],
      );

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiredDay': expiredDay,
      'customerName': customerName,
      'typeOfCard': typeOfCard,
    };
  }
}
