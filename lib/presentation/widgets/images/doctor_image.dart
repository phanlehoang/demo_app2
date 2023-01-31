import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 200,
          width: 200,
          // width: widthDevideMethod(0.7),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/doctor.jpg",
                //    height: 200, width: 200,
                fit: BoxFit.fitHeight),
          )),
    );
  }
}
