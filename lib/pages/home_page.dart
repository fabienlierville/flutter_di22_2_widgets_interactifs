import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TextField
  String? changed;
  String? submitted;
  bool obscureText = true;
  final _passwordController = TextEditingController();
  //Checkbox
  Map<String, bool> listeCourse = {
    "Carottes": false,
    "Bananes": false,
    "Yaourt": false,
    "Pain": false,
  };
  //RadioBox
  RadioChoix choixRadio = RadioChoix.Avion;
  Icon iconRadio = Icon(Icons.airplanemode_active);
  //Switch
  bool interrupteur = false;

  @override
  void initState() {
    _passwordController.addListener(_afficherLaValeurDuChamp);
    _passwordController.text = "Coucou";
    super.initState();
  }

  void _afficherLaValeurDuChamp(){
    setState(() {
      changed = _passwordController.text;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Widgets Interactifs")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _passwordController..text,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Saisir votre mail",
                    hintText: "test@test.com",
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: (obscureText) ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    )
                  ),
                  obscureText: obscureText,
                  /*
                  onChanged: (String value){
                    setState(() {
                      this.changed = value;
                    });
                  },
                  onSubmitted: (String value){
                    setState(() {
                      this.submitted = value;
                    });
                  },
          
                   */
                ),
                Text("changed = ${changed}"),
                Text("submitted = ${submitted}"),
                Divider(),
                Container(
                  child: Column(
                    children: checkList(),
                  ),
                ),
                Divider(),
                iconRadio,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: RadioChoix.Avion,
                      onChanged: (RadioChoix? choix){
                        setState(() {
                          choixRadio = choix!;
                          iconRadio = Icon(Icons.airplanemode_active);
                        });
                      },
                      groupValue: choixRadio,
                      activeColor: Colors.green,
                    ),
                    Text("Avion", style: TextStyle(color: (choixRadio == RadioChoix.Avion) ? Colors.green : Colors.blue),),
                    Radio(
                      value: RadioChoix.Bateau,
                      onChanged: (RadioChoix? choix){
                        setState(() {
                          choixRadio = choix!;
                          iconRadio = Icon(Icons.directions_boat);
                        });
                      },
                      groupValue: choixRadio,
                      activeColor: Colors.green,
                    ),
                    Text("Bateau", style: TextStyle(color: (choixRadio == RadioChoix.Bateau) ? Colors.green : Colors.blue),),
                    Radio(
                      value: RadioChoix.Voiture,
                      onChanged: (RadioChoix? choix){
                        setState(() {
                          choixRadio = choix!;
                          iconRadio = Icon(Icons.directions_car);
                        });
                      },
                      groupValue: choixRadio,
                      activeColor: Colors.green,
                    ),
                    Text("Voiture", style: TextStyle(color: (choixRadio == RadioChoix.Voiture) ? Colors.green : Colors.blue),),
                  ],
                ),
                Divider(),
                Switch(
                    value: interrupteur,
                    inactiveTrackColor: Colors.red,
                    activeColor: Colors.green,
                    onChanged: (bool? b){
                      setState(() {
                        interrupteur = b!;
                      });
                    }
                ),
                Text(interrupteur?"Pour":"Contre")
              ],
            ),
          ),
        ),
      
      ),
    );
  }

  List<Widget> checkList(){
    List<Widget> l = [];
    listeCourse.forEach((aliment, achete) {
      Row row = Row(
        children: [
          Checkbox(
              value: achete,
              onChanged: (bool? b){
                setState(() {
                  listeCourse[aliment] = b!;
                });
              }
          ),
          Text(aliment, style: TextStyle(decoration: (achete) ? TextDecoration.lineThrough : TextDecoration.none),)
        ],
      );
      l.add(row);
    });

    return l;
  }
}

enum RadioChoix {
  Voiture,
  Avion,
  Bateau
}
