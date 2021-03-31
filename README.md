# Codifica di testi
##### Esercizi corso di Codifica di testi, Informatica Umanistica, Università di Pisa, Anno accademico 2020/2021

### Esercizi
* __Esercizio prologo:__ creare un file _.xml_ e inserire un prologo con la dichiarazione XML e un commento con le nostre informazioni
* __Esercizio relazioni gerarchiche:__ scrivere e fare il check di un xml non opportunamente annidato
* __Esercizio correzione:__ aprire il [file XML][1] non ben formattato presente nella [repository del corso][2]:
  * validarlo con un parser XML
  * correggerlo (commentando)
  * aggiungere un figlio (child) a un elmento
  * aggiungere un fratello (sibling) a un elemento
* __Esercizio CDDATA:__ inserire all'interno di un tag un frammento di codice HTML
* __Esercizi DTD:__
  * ___Esercizio DTD 1___: definire un elemento root _TEI_ con elementi figli _header_ (obbligatoria un occorrenza), _facsimile_ (opzionale una occorrenza) e _text_ (obbligatorio almeno un occorrenza). Gli elementi _header_, _facsimile_ e _text_ hanno tutti un content model testuale.
  * ___Esercizio DTD 2___: definire un elemento root _TEI_ con elementi figli:
    *  _header_ (obbligatoria un occorrenza) i cui attributi sono _type_ (fixed, CDDATA, "intestazione") e _lang_ (opzionale, NMTOKEN)
    *  _facsimile_ (opzionale una occorrenza) i cui attributi sono _source_ (obbligatorio) e _ref_ (opzionale, IDREFS)
    *  _testo_ (obbligatorio almeno un occorrenza) un mixed content con possibile elemento _<seg>_. Gli attributi di testo sono id (obbligatorio, ID) e type (opzionale, contenuto testuale)
  * ___Esercizio DTD 3___: 
    *  ___Esercizio DTD 3 A___: includere all'interno di un documento XML la dichiarazione del tipo, definire internamente gli elementi, gli attributi e validare
    *  ___Esercizio DTD 3 B___: inserire nel prologo del documento XML dell'_esercizio DTD 3 A_ la dichiarazione del tipo di documento e validare
    *  ___Esercizio DTD 3 C___: creare un file esterno con estensione _.dtd_ per il documento dell'_esercizio DTD 3 A_ e includerlo nel prologo XML 

[1]: https://github.com/angelodel80/corsoCodifica/blob/master/CTaa20-21/src/doc-no-well.xml "doc-no-well.xml"
[2]: https://github.com/angelodel80/corsoCodifica "Repository del corso"
