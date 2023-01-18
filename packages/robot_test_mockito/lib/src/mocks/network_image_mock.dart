import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:robot_test_mockito/src/mocks/mocks.mocks.dart';

/// Runs [body] in separate zone with [MockHttpClient].
R mockNetworkImages<R>(R Function() body) {
  return HttpOverrides.runZoned(
    body,
    createHttpClient: (_) => _createMockImageHttpClient(),
  );
}

MockHttpClient _createMockImageHttpClient() {
  final MockHttpClient client = MockHttpClient();
  final MockHttpClientRequest request = MockHttpClientRequest();
  final MockHttpClientRequest svgRequest = MockHttpClientRequest();

  when(client.getUrl(any)).thenAnswer(
    (Invocation invocation) => Future<HttpClientRequest>.value(request),
  );

  _mockRequestResponse(request: request, image: _transparentImage);

  request.close();
  svgRequest.close();

  return client;
}

void _mockRequestResponse({
  required MockHttpClientRequest request,
  required List<int> image,
}) {
  final MockHttpClientResponse response = MockHttpClientResponse();

  when(request.headers).thenReturn(MockHttpHeaders());
  when(request.close()).thenAnswer(
    (_) => Future<HttpClientResponse>.value(response),
  );
  when(response.compressionState).thenReturn(
    HttpClientResponseCompressionState.notCompressed,
  );
  when(response.contentLength).thenReturn(image.length);
  when(response.statusCode).thenReturn(HttpStatus.ok);
  when(
    response.listen(
      any,
      onError: anyNamed('onError'),
      onDone: anyNamed('onDone'),
      cancelOnError: anyNamed('cancelOnError'),
    ),
  ).thenAnswer((Invocation invocation) {
    final onData = invocation.positionalArguments[0];
    final onDone = invocation.namedArguments[#onDone];
    final onError = invocation.namedArguments[#onError];
    final cancelOnError = invocation.namedArguments[#cancelOnError];

    return Stream<List<int>>.fromIterable(<List<int>>[image]).listen(
      onData as void Function(List<int>)?,
      onDone: onDone as void Function()?,
      onError: onError as Function?,
      cancelOnError: cancelOnError as bool?,
    );
  });
}

final _transparentImage = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEh'
  'QGAhKmMIQAAAABJRU5ErkJggg==',
);
