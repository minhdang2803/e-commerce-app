class ReturnUrl {
  final String _returnUrl;
  late String _vnpTmnCode;
  late String _vnpAmount;
  late String _vnpBankCode;
  String? _vnpBankTranNo;
  String? _vnpCardType;
  String? _vnpPayDate;
  late String _vnpOrderInfo;
  late String _vnpTransactionNo;
  late String _vnpResponseCode;
  late String _vnpTransactionStatus;
  late String _vnpTxnRef;
  String? _vnpSecureHashType;
  late String _vnpSecureHash;
  ReturnUrl(this._returnUrl) {
    List<String> results = _returnUrl.split('?').last.split(RegExp(r'=|&'));
    int i = 0;
    while (i < results.length) {
      switch (results[i]) {
        case 'vnp_TmnCode':
          _vnpTmnCode = results[i + 1];
          i += 2;
          break;
        case 'vnp_Amount':
          _vnpAmount = results[i + 1];
          i += 2;
          break;
        case 'vnp_BankCode':
          _vnpBankCode = results[i + 1];
          i += 2;
          break;
        case 'vnp_BankTranNo':
          _vnpBankTranNo = results[i + 1];
          i += 2;
          break;
        case 'vnp_CardType':
          _vnpCardType = results[i + 1];
          i += 2;
          break;
        case 'vnp_PayDate':
          _vnpPayDate = results[i + 1];
          i += 2;
          break;
        case 'vnp_OrderInfo':
          _vnpOrderInfo = results[i + 1];
          i += 2;
          break;
        case 'vnp_TransactionNo':
          _vnpTransactionNo = results[i + 1];
          i += 2;
          break;
        case 'vnp_ResponseCode':
          _vnpResponseCode = results[i + 1];
          i += 2;
          break;
        case 'vnp_TransactionStatus':
          _vnpTransactionStatus = results[i + 1];
          i += 2;
          break;
        case 'vnp_TxnRef':
          _vnpTxnRef = results[i + 1];
          i += 2;
          break;
        case 'vnp_SecureHashType':
          _vnpSecureHashType = results[i + 1];
          i += 2;
          break;
        case 'vnp_SecureHash':
          _vnpSecureHash = results[i + 1];
          i += 2;
          break;
        default:
          throw (Exception('The URL is in a wrong format'));
      }
    }
  }
  String get responseDetail {
    String result = '';
    switch (_vnpResponseCode) {
      case '00':
        result = 'Giao dịch thành công';
        break;
      case '07':
        result =
            'Trừ tiền thành công. Giao dịch bị nghi ngờ (liên quan tới lừa đảo, giao dịch bất thường)';
        break;
      default:
    }
    return result;
  }

  String get vnpTmnCode => _vnpTmnCode;
  String get vnpAmount => _vnpAmount;
  String get vnpBankCode => _vnpBankCode;
  String? get vnpBackTranNo => _vnpBankTranNo;
  String? get vnpCardType => _vnpCardType;
  String? get vnpPayDate => _vnpPayDate;
  String get vnpOrderInfo => _vnpOrderInfo;
  String get vnpTransactionNo => _vnpTransactionNo;
  String get vnpResponseCode => _vnpResponseCode;
  String get vnpTransactionStatus => _vnpTransactionStatus;
  String get vnpTxnRef => _vnpTxnRef;
  String? get vnpSecureHashType => _vnpSecureHashType;
  String get vnpSecureHash => _vnpSecureHash;
}
