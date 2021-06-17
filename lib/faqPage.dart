import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constantsUtil.dart';

class NewPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.appBackground,
      appBar: new AppBar(
        backgroundColor: MyAppColors.appBackground,
        title: Text(
          'Domande frequenti di aiuto teorico',
          style: TextStyle(fontFamily: 'Brandon-Grotesque-black'),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Definizione di moto continuo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          'Ogni forma di moto che resti costante nel tempo, senza subire variazione alcuna',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Definizione di velocità angolare'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          "In cinematica, la velocità angolare è una grandezza vettoriale definita come la variazione di un angolo in funzione del tempo",
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tensore delle deformazioni'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          ' La deformazione di un corpo continuo è un qualsiasi cambiamento della configurazione geometrica del corpo che porta ad una variazione della sua forma o delle sue dimensioni in seguito all applicazione di una sollecitazione interna o esterna',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Definizione di corpo rigido'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          'Un corpo rigido è un oggetto materiale le cui parti sono soggette al vincolo di rigidità, ossia è un corpo che sia quando è fermo sia quando cambia posizione non si deforma mai',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Gradi di libertà dei sistemi rigidi'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          'Un corpo rigido nello spazio tridimensionale ha esattamente 6 gradi di libertà: 3 di tipo traslazionale e 3 di tipo rotazionale. e quindi il corpo ha 6 gradi di libertà',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Fluido Perfetto'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          'Un fluido ideale è un fluido che ha densità costante e coefficiente di viscosità nullo, quindi ha la legge di Pascal come legge costitutiva. La più importante conseguenza meccanica è che se il coefficiente di viscosità è nullo, in un fluido ideale non vi sono sforzi di taglio',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Fluido Barotropico'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: MyAppColors.appBackground,
                      body: Center(
                        child: Text(
                          'Un fluido barotropico è un fluido in cui la pressione è costante sulle superfici di uguale densità',
                          style: TextStyle(
                              backgroundColor: MyAppColors.appBackground,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Nuovo extends StatelessWidget {
  final String title;
  Nuovo(this.title);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: MyAppColors.appBackground,
          appBar: new AppBar(
            title: Text('Risposta'),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => NewPage1());
                  Navigator.push(context, route);
                },
              )
            ],
          ),
          body: Container(
            child: (Text(title)),
          ),
        ),
      ),
    );
  }
}
