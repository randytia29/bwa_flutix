import 'package:bwaflutix/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  NetworkInfoImpl? networkInfo;
  MockInternetConnectionChecker? mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker!);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker?.hasConnection)
          .thenAnswer((realInvocation) => tHasConnectionFuture);

      final result = networkInfo?.isConnected;

      verify(mockInternetConnectionChecker?.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
