import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/medical/4_regimen.dart';
import 'package:demo_app2/data/models/sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:demo_app2/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/procedures_screens/create_procedure.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';


import '../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../logic/global/current_group/current_group_id_cubit.dart';
import '../../../widgets/bars/bottom_navitgator_bar.dart';
import '../../../widgets/bars/patient_navigator_bar.dart';
import '../../../widgets/nice_widgets/0_nice_screen.dart';
import 'nice_date_time.dart';

class PatientProceduresScreen extends StatelessWidget {
  const PatientProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: Column(
          children: [
            //TODO: add a button to add a procedure
            NiceButtons(
              stretch: false,
              width: 50,
              onTap: (_){
                //navigator to create procedure screen
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (createProcedureContext) => CreateProcedure(),),);
              },
             child: //icon to add a procedure
             Icon(Icons.add_box),
             ),
             
            ListProcedures(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class ListProcedures extends StatelessWidget {
  const ListProcedures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .doc(context.read<CurrentProfileCubit>().state.room)
          .collection('patients')
          .doc(context.read<CurrentProfileCubit>().state.id)
          .collection('procedures')
          .snapshots(),
      builder:   (context, snapshot) {
        if (snapshot.hasError) {
    return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
    return Text("Loading");
          }
          if(snapshot.data == null || snapshot.data!.docs.isEmpty) {
    return Text('No data');
          }
          else{
    final procedureRefs = snapshot.data!.docs.reversed;
    //remove procedures name != 'sonde'
    //procedures.removeWhere((element) => element['name'] != 'SondeProcedure');
      return Column(
        children: [
          Text('Procedures'),
          for (var procedureRef in procedureRefs)
          if(procedureRef.data()['name'] == 'SondeProcedure')
             SondeProcedureItem(
              procedure: procedureRef.data(),
              procedureId: procedureRef.id,
              ),
            ],
          
      );
          }
      },
        );
  }
}

class SondeProcedureItem extends StatelessWidget {
  const SondeProcedureItem({
    Key? key,
    required this.procedure,
    required this.procedureId,
  }) : super(key: key);

  final Map<String, dynamic> procedure;
  final String procedureId;

  @override
  Widget build(BuildContext context) {
    final SondeProcedureOnlineCubit sondeProcedureOnlineCubit = SondeProcedureOnlineCubit(
        profile: context.read<CurrentProfileCubit>().state,
        procedureId: procedureId, 
      );
    return BlocBuilder(
      bloc: sondeProcedureOnlineCubit,
      builder: (_context, _procedureState) {
        final procedureState = sondeProcedureOnlineCubit.state;
        if (procedureState.name == 'Đang tải') {
          return Text('Loading');
        }
        //nice date time 
        String time = NiceDateTime.dayMonth(procedureState.beginTime);
        return BlocBuilder(
          bloc: context.read<CurrentProfileCubit>(),
          builder: (_context, state) {
            final profile = _context.read<CurrentProfileCubit>().state;
          Color color = Theme.of(context).canvasColor;
          if (profile.currentProcedureId == procedureState.beginTime.toString()) {
            color = //choose color 
            Colors.greenAccent;
          }
          return Column(
            children: [
            //  Text(profile.currentProcedureId),

              SimpleContainer(
                addColor: color,
                child: Column(
                  children: [
                    // Text(procedureState.toString()),
        
                    ListTile(
                       title: Text(procedureState.name,
                      ),
                        subtitle: Text(EnumToString.enumToString(procedureState.state.status)),
                        trailing: Text(time),
                        onTap: () {
                         //profile update to current procedure
                          context.read<CurrentProfileCubit>().update(
                            {'currentProcedureId':
                                procedureState.beginTime.toString(),
                                'procedureType': procedureState.name 
                                == 'SondeProcedure' ? 'Sonde' : 'TPN',
                            },
                              );
                         
                        },
                    ),
                  ],
                ),
                  
        ),
            ],
          ); 

        }
        );
      },
    );
  }
}
