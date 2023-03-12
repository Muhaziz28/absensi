import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:absensi_project_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project_app/app/widgets/empty_state.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('History Presensi'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GetBuilder<AllPresensiController>(
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                            height: 400,
                            child: SfDateRangePicker(
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                      firstDayOfWeek: 1),
                              selectionMode: DateRangePickerSelectionMode.range,
                              showActionButtons: true,
                              onCancel: () => Get.back(),
                              onSubmit: (obj) {
                                if (obj != null) {
                                  if ((obj as PickerDateRange).endDate !=
                                      null) {
                                    controller.pickDate(
                                        obj.startDate!, obj.endDate!);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_alt),
                        const SizedBox(width: 5),
                        Text(
                          'Pilih Tanggal',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: controller.streamAllPresence(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (snapshot.data?.docs.length == 0 ||
                        snapshot.data == null) return EmptyState();
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data?.docs[index]
                            .data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PRESENSI_DETAIL,
                                    arguments: data);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Masuk',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: bold,
                                              color: Colors.green),
                                        ),
                                        Text(
                                            '${data['date'] == null ? '-' : DateFormat.yMMMEd().format(DateTime.parse(data['date']))}'),
                                      ],
                                    ),
                                    Text(
                                      data['check_in']?['date'] == null
                                          ? '-'
                                          : '${DateFormat.jms().format(DateTime.parse(data['check_in']['date']))}',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Keluar',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      data['check_out']?['date'] == null
                                          ? '-'
                                          : '${DateFormat.jms().format(DateTime.parse(data['check_out']['date']))}',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
