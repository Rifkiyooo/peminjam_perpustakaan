import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookView'),
          centerTitle: true,
        ),
        body: controller.obx((state) => ListView.separated(
              itemCount: state!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text("${state[index].judul}(${state[index].tahunTerbit}"),
                  subtitle: Text(
                      "Penulis ${state[index].penulis}(${state[index].penerbit}"),
                  trailing: ElevatedButton(
                    child: Text("pinjam"),
                    onPressed: () {
                      Get.toNamed(Routes.ADD_PEMINJAMAN, parameters: {
                        'id': (state[index].id ?? 00).toString(),
                        'judul': (state[index].judul ?? "-")
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            )));
  }
}
