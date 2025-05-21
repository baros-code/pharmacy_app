import 'dart:async';

import 'package:flutter/foundation.dart';

import 'logger.dart';
import 'result.dart';

/// Base class for standard use cases.
///
/// Every standard use case should extend this class.
///
/// If any of [TInput], [TOutput] or [TEvent] is not needed,
/// void can be passed as a generic type to be ignored.
abstract class UseCase<TInput, TOutput extends Object, TEvent>
    extends _UseCaseBase<TEvent> {
  UseCase(super.logger);

  /// Executes use case with the given [params] and
  /// returns a FutureOr of a [TOutput] instance.
  FutureOr<Result<TOutput, Failure>> call({TInput? params});
}

/// Private base class for use cases.
abstract class _UseCaseBase<TEvent> {
  _UseCaseBase(this.logger);

  final Logger logger;

  final _eventController = StreamController<TEvent>();

  /// Receives events of type [TEvent] to inform receiver
  /// when an intermediary update occurs during use case execution.
  Stream<TEvent> get onEvent => _eventController.stream;

  /// Publishes the given [event] to the subscribers of [onEvent].
  @protected
  void publish(TEvent event) {
    if (_eventController.hasListener) _eventController.add(event);
  }

  /// Useful to be overriden to stop a long running execution.
  @mustCallSuper
  Future<void> stop() async {
    await _eventController.close();
  }
}
