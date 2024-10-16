/// Network abnormality
class NetWorkException<T>  implements  Exception {
  int? code;
  String? message;
  T? data;

  NetWorkException(this.code, this.message, {this.data});

  @override
  String toString() {
    return 'Network  exception {code: $code, message: $message, data: $data}';
  }
}