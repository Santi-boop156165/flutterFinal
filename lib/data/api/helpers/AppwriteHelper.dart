import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteHelper {
  static final Client client = Client()
    ..setEndpoint('https://fra.cloud.appwrite.io/v1')
    ..setProject('6834a5d5001dc085597d')
    ..setSelfSigned(status: true);

  static final Databases database = Databases(client);
  static final Account account = Account(client);
  static final Storage storage = Storage(client);
}
