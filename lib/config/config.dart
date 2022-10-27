// config
String vnpUrl = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html';
String vnpHashSecret = 'IBZBHIGZBWJTXICGTLDEIBVBDYSYGXEF'; // Get from VNPay
String vnpVersion = '2.0.1';
String vnpCommand = 'pay';
String vnpIpAddr = '172.20.10.5';
String vnpOrderInfo = '';
String vnpReturnUrl = 'vnpaysample://vnpaytesting.com';
String vnpTmnCode = 'PERZLMJ6';
String vnpTxnRef = DateTime.now().millisecondsSinceEpoch.toString();

const List<String> returnParams = [
  'vnp_TmnCode',
  'vnp_Amount',
  'vnp_BankCode',
  'vnp_BankTranNo',
  'vnp_CardType',
  'vnp_PayDate',
  'vnp_OrderInfo',
  'vnp_TransactionNo',
  'vnp_ResponseCode',
  'vnp_TransactionStatus',
  'vnp_TxnRef',
  'vnp_SecureHashType',
  'vnp_SecureHash',
];
