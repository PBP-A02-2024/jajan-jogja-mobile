import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardTempat extends StatelessWidget {
  const CardTempat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 278,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 278,
                height: 100,
                decoration: ShapeDecoration(
                  color: Color(0xFFEBE9E1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Color(0xFFC88709)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              Container(
                width: 80.66,
                height: 63,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.55),
                  ),
                ),
              ),
              SizedBox(
                width: 142,
                height: 18,
                child: Text(
                  '{Nama Tempat........................}',
                  style: TextStyle(
                    color: Color(0xFF7C1D04),
                    fontSize: 13,
                    fontFamily: 'Jockey One',
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                ),
              ),
              SizedBox(
                width: 142,
                height: 29,
                child: Text(
                  '{Alamat...................................................                  ...}',
                  style: TextStyle(
                    color: Color(0xFF7C1D04),
                    fontSize: 9.94,
                    fontFamily: 'Jockey One',
                    fontWeight: FontWeight.w400,
                    height: 0.16,
                  ),
                ),
              ),
              SizedBox(
                width: 50.15,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 4,
                      child: SizedBox(
                        width: 30,
                        height: 10,
                        child: Text(
                          '4.9/5',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF7C1D04),
                            fontSize: 10,
                            fontFamily: 'Jockey One',
                            fontWeight: FontWeight.w400,
                            height: 0.32,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 32,
                      top: 0,
                      child: Container(
                        width: 18.15,
                        height: 18.15,
                        decoration: ShapeDecoration(
                          color: Color(0xFFEFB11D),
                          shape: StarBorder(
                            points: 5,
                            innerRadiusRatio: 0.38,
                            pointRounding: 0.80,
                            valleyRounding: 0,
                            rotation: 0,
                            squash: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}