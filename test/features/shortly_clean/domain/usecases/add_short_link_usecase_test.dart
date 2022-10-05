// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shortly_clean/core/observer/observer.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';

import 'add_short_link_usecase_test.mocks.dart';

// After null safety we should use GenerateMocks for Mockito
// This generated Mock repository is a common repo so we can use it fot RemoveShortlinkUsecase too. (without generating)
@GenerateMocks([
  ShortLinkRemoteRepository
], customMocks: [
  MockSpec<ShortLinkRemoteRepository>(
      as: #FakeRepo, onMissingStub: OnMissingStub.throwException),
])
void main() {
  group('GetUserUseCase', () {
    AddShortLinkToHistoryList? addShortLinkToHistoryList;
    _Observer? observer;

    setUp(() {
      var repo = FakeRepo();
      addShortLinkToHistoryList = AddShortLinkToHistoryList(repo);
      observer = _Observer();
    });

    test('Adds a shortlink to list', () async {
      addShortLinkToHistoryList!.execute(
          observer!, AddShortLinkToHistoryListParams('https://github.com/'));
      await Future.delayed(const Duration(milliseconds: 1000), () {
        // expect(addShortLinkToHistoryListObserver, 2);
        expect(observer!.done, true);
        expect(observer!.error, false);
      });
      // a.dispose();
    });
  });
}

class _Observer implements Observer<void> {
  bool done = false;
  bool error = false;

  @override
  void onComplete() {
    done = true;
    print('Complete');
  }

  @override
  void onError(e) {
    error = true;
    throw e;
  }

  @override
  void onNext(_) {}
}
