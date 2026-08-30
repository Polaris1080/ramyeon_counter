part of 'base/detail_page_action.dart';

class const DetailToEditAction({
  super.key,
  required final DetailToEditActionViewModel vm,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: '編集', //【Icon tooltip】
      onPressed: () => context.push(vm.location, extra: vm.extra),
    );
  }
}
