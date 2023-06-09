import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementsPage extends StatefulWidget {
  final String uid;

  MeasurementsPage({required this.uid});

  @override
  _MeasurementsPageState createState() => _MeasurementsPageState();
}

class _MeasurementsPageState extends State<MeasurementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(title: Text('Všetky merania')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('measurements').where('uid', isEqualTo: widget.uid).orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Niekde sa stala chyba');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Color(0xFFE0E3E6),
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 14, bottom: 8.0),
                        child: Text(
                          '${data['timestamp'].toDate().day}.${data['timestamp'].toDate().month}.${data['timestamp'].toDate().year} - ${data['currentWeight']} kg',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                        child: Text(
                          'Hrudník: ${data['chestCir']} cm | Pás: ${data['beltCir']} cm \nRuka: ${data['handCir']} cm | Stehno: ${data['thighCir']} cm',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
        },
      ),
    );
  }
}
