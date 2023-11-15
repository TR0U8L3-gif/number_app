import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_app/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker{}

main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(internetConnectionChecker: mockInternetConnectionChecker);
  });

  group("is connected", () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnection = Future.value(true);
        when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((invocation) => tHasConnection);
        // act
        final result =  networkInfoImpl.isConnected;
        // assert
        verify(() => mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );
  });
}