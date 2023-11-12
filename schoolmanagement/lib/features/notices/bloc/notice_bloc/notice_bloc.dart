import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schoolmanagement/features/notices/data/model/noticeModel.dart';
import 'package:schoolmanagement/features/notices/services/noticeApi.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc() : super(const NoticeInitial(isLoading: false)) {
    on<NoticeEvent>((event, emit) async {
      if (event is fetchNoticeEvent) {
        emit(const NoticeInitial(isLoading: true));
        try {
          NoticeApi noticeApi = NoticeApi();
          final List<Notice> noticeList = await noticeApi.getNotices();
          if (noticeList.isEmpty) {
            emit(NoticeErrorState(
                exception: Exception('No notices found'),
                message: 'No notices found',
                isLoading: false));
          } else {
            emit(NoticeLoadedState(
              noticeList: noticeList,
              isLoading: false,
            ));
          }
        } on Exception catch (e) {
          emit(NoticeErrorState(
              exception: e,
              message: 'Error while fetching notices $e',
              isLoading: false));
        }
      }
    });
  }
}
