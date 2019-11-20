import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AbrirChamado extends StatefulWidget {
  final String tipoEdicao;
  final DocumentSnapshot dadosChamado;

  AbrirChamado(this.tipoEdicao, this.dadosChamado);

  @override
  _AbrirChamadoState createState() => _AbrirChamadoState();
}

class _AbrirChamadoState extends State<AbrirChamado> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var _valueClassificacao="Hardware";
  var _tiposClassificacao = ["Hardware","Software","Rede","Impressoras","Telefonia"];

  var _valueTipoChamado="Incidente";
  var _tipoChamado = ["Incidente", "Melhoria", "Requisição de Serviço"];


  TextEditingController tituloChamado = TextEditingController();
  TextEditingController descricaoChamado = TextEditingController();
  TextEditingController setorChamado = TextEditingController();

  File _image ;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery );

    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async{
    String fileName = _image.path;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
      ),
      body: Builder(
        builder: (context)=>SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _tituloChamado("Título"),
                _sizedBox(15, 15),
                _descricaoChamado("Descrição"),
                _sizedBox(15, 15),
                _setorChamado("Setor / Local da ocorrência"),
                _sizedBox(15, 15),
                Text("Categoria: "),
                _categoriaMenu(),
                _sizedBox(15, 15),
                Text("Tipo: "),
                _tipoServicoMenu(),
                buttonBarAbrirCancelar(),
                Container(
                  //snapshot.data.documents.lenght
                  child: (_image!=null)?Image.file(
                    _image,
                    fit: BoxFit.fill,
                  ):Text("Nenhum arquivo Anexado", style: TextStyle(color: Colors.red,),),
                )

              ],
            ),
          ),
        ),
      ),
    );

  }

  DropdownButton<String> _categoriaMenu() {
    return DropdownButton<String>(
      items: _tiposClassificacao.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),

      hint: Text("selecione uma categoria"),
      onChanged: (value) {
        setState(() {
          _valueClassificacao = value;
        });
      },
      isExpanded: true,
      value: _valueClassificacao,
      elevation: 2,
      iconSize: 40.0,

    );
  }

  DropdownButton<String> _tipoServicoMenu() {
    return DropdownButton<String>(
      items: _tipoChamado.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _valueTipoChamado = value;
        });
      },
      isExpanded: true,
      hint: Text("Selecione um tipo"),
      value: _valueTipoChamado,
      elevation: 2,
      iconSize: 40.0,
    );
  }

  IconButton buttonCamera() {
    return IconButton(
              icon: Icon(Icons.attach_file),
              iconSize: 50,
              onPressed: () {
                getImage();
//                tooltip: 'Pick Image';

              },
    );
  }

  ButtonBar buttonBarAbrirCancelar() {
    return ButtonBar(

              children: <Widget>[
                Column(children: <Widget>[
                  Text("Anexar"),
                  buttonCamera(),
                ],),

                _botaoCancelarChamado(),
                _botaoAbrirChamado(),
              ],
            );
  }

  RaisedButton _botaoAbrirChamado() {
    return RaisedButton(
      child: Text("Concluir"),
      color: Colors.indigo,
      onPressed: () {

        if (formkey.currentState.validate()){
          Firestore.instance.collection("chamados").add({
            "titulo": tituloChamado.text,
            "descricao": descricaoChamado.text,
            "setor": setorChamado.text,
            "classificacao": _valueClassificacao,
            "tipo": _valueTipoChamado,
            "status": "1",
            "urlImagem": _image.path,
            "dataAbertura": getDiaMesAno(),
            "horaAbertura": getHoraMinuto(),
          });

          uploadPic(context);
          Navigator.of(context).pop();
        }
      },
    );
  }

  RaisedButton _botaoCancelarChamado() {
    return RaisedButton(
      child: Text("Cancelar"),
      color: Colors.red,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  TextFormField _descricaoChamado(String label) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
      controller: descricaoChamado,
      validator: (value) => value.isEmpty ? "infome a descrição!" :  null
    );
  }

  TextFormField _tituloChamado(String label) {
    return TextFormField(
//      textInputAction: TextInputAction.next,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: tituloChamado,
      validator: (value) => value.isEmpty ? "infome o título!" :  null,
    );
  }

  TextFormField _setorChamado(String label) {
    return TextFormField(
//      textInputAction: TextInputAction.next,
      decoration:
      InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: setorChamado,
      validator: (value) => value.isEmpty ? "infome o título!" :  null,
    );
  }

  SizedBox _sizedBox(double largura, double altura) => SizedBox(
        height: altura,
        width: largura,
  );

  Future<void> retrieveLostData() async {
    final LostDataResponse response =
    await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
  }

  String getDiaMesAno() {
    String dia = DateTime.now().day.toString();
    String mes = DateTime.now().month.toString();
    String ano = DateTime.now().year.toString();
    String diamesano = (dia + '/' + mes + '/' + ano);

    return diamesano;
  }

  String getHoraMinuto() {
    String hora = DateTime.now().hour.toString();
    String minuto = DateTime.now().minute.toString();

    String horaChamado = (hora+ ':' + minuto);

    return horaChamado;
  }

}

class ArquivoImagem extends StatelessWidget {
  const ArquivoImagem({
    Key key,
    @required File image,
  })
      : _image = image,
        super(key: key);

  final File _image;

  @override
  Widget build(BuildContext context) {
    if (Image.file(_image) != null) {
      return new Image.file(_image);
    }return new Image.asset("images/abase.jpg");
  }


//cor vermelho abase(169, 36, 37)
//cor azul abase (62, 64, 149)
}