import 'package:flutter/material.dart';
import 'package:ramyeon_counter/page/regist/view_model/regist_page_vm.dart';

class RamyeonTagRegister extends StatelessWidget {
  RamyeonTagRegister(this.vm, {super.key});

  final RegistPageViewModel vm;
  String tf = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Row(
          children: [
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                vm.addTag(2, tf);
              },
              icon: Icon(Icons.add),
              label: const Text('Tag'),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '会社名',
                ),
                onChanged: (value) {
                  tf = value;
                },
              ),
            ),
          ],
        ),
        ListenableBuilder(
          listenable: vm,
          builder: (context, child) {
            return Wrap(
              children: [
                for (var t in vm.tag.entries)
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: null,
                    icon: Icon(Icons.close),
                    label: Text(t.value),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
