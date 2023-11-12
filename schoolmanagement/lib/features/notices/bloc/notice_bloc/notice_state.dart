part of 'notice_bloc.dart';

sealed class NoticeState extends Equatable {
  final bool isLoading;
  final String? message;
  const NoticeState({required this.isLoading, this.message});

  @override
  List<Object> get props => [
        isLoading,
        message ?? "",
      ];
}

final class NoticeInitial extends NoticeState {
  const NoticeInitial({required super.isLoading});
}

class NoticeLoadedState extends NoticeState {
  final List<Notice> noticeList;
  const NoticeLoadedState({
    required this.noticeList,
    required isLoading,
  }) : super(isLoading: isLoading);
  NoticeLoadedState copyWith({
    bool? isLoading,
    List<Notice>? noticeList,
  }) {
    return NoticeLoadedState(
      isLoading: isLoading ?? this.isLoading,
      noticeList: noticeList ?? this.noticeList,
    );
  }
}

class NoticeErrorState extends NoticeState {
  final Exception? exception;
  const NoticeErrorState({
    required this.exception,
    required message,
    required isLoading,
  }) : super(isLoading: isLoading, message: message);
}

class NoticeEmptyState extends NoticeState {
  const NoticeEmptyState({
    required isLoading,
  }) : super(isLoading: isLoading);
}
