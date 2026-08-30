part of 'base/detail_page_action.dart';

class const DetailToEditAction({
  super.key,
  required final DetailToEditActionViewModel vm,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: vm.tooltip,
      onPressed: () => context.push(vm.location, extra: vm.extra),
    );
  }
}
