// VARIABILI di avanzamento dialogo//

VAR Dialog_CatenaCameraInOsteria_Step = 0
VAR Dialog_VituzzoInOsteria_Step = 0
VAR Dialog_FatimaMercato_Step = 0
VAR Dialog_GoranChiesa_Step = 0

VAR Dialog_CristinaCasaThovezBiblioteca_Step = 0
VAR Dialog_ThovezCasaThovezBiblioteca_Step = 0
VAR Dialog_ThovezCasaThovezStanzaFeste_Step = 0
VAR Dialog_AmministratoreCasaThovezStanzaFeste_Step = 0
VAR Dialog_HelenCasaThovezStanzaFeste_Step = 0
VAR Dialog_GiuseppeCasaThovezStanzaFeste_Step = 0

VAR Dialog_IsaacCasaIsaacInterno_Step = 0

VAR Dialog_FatimaCasaThovezAmministrazione_Step = 0
VAR Dialog_CristinaCasaThovezCameraDaLetto_Step = 0
VAR Dialog_CatenaCasaThovezCameraDaLetto_Step = 0

//VARIABILI DI VITTORIA//
/* REMIND: se soggettoWin = true noi abbiamo perso, quindi l'esito è negativo */
VAR CatenaWin = true
VAR CristinaWin = true
VAR ThovezWin = true
VAR IsaacWin = true
VAR AmministratoreWin = true

//VARIABILI PER IL FINALE
VAR ThovezAiuta = false
VAR ThovezUccisoS = false
VAR ThovezUccisoCristina = false
VAR ThovezUccisoCatena = false
VAR ThovezUccisoFatima = false

//VARIAVBILI PER PERSONAGGE PRESENTI//
// Variabili che indicano quali personaggi sono visibili in scena. Su Unity i gameobject dei personaggi hanno il nome "CatenaCameraDaLetto"

VAR SCameraInOsteria = true
VAR CatenaCameraInOsteria = true

VAR SOsteria = true
VAR VituzzoOsteria = true
VAR AvventoreOsteria = true

VAR SMercato = true
VAR FatimaMercato = true
VAR ArrotinoMercato = true
VAR IsaacMercato = true

VAR SGoranChiesa = true
VAR GoranChiesa = true
VAR PreteChiesa = true
VAR ThovezChiesa = true


VAR SCasaThovezStanzaFeste = true
VAR CatenaCasaThovezStanzaFeste = false
VAR ThovezCasaThovezStanzaFeste = true
VAR AmministratoreCasaThovezStanzaFeste = true
VAR HelenCasaThovezStanzaFeste = true
VAR GiuseppeCasaThovezStanzaFeste = true

VAR SCasaThovezBiblioteca = true
VAR CatenaCasaThovezBiblioteca = true
VAR CristinaCasaThovezBiblioteca = true
VAR ThovezCasaThovezBiblioteca = true

VAR SCasaIsaacInterno = true
VAR CatenaCasaIsaacInterno = true
VAR CristinaCasaIsaacInterno = true
VAR IsaacCasaIsaacInterno = true


VAR SCasaThovezAmministrazione = true
VAR CatenaCasaThovezAmministrazione = true
VAR AmministratoreCasaThovezAmministrazione = true
VAR FatimaCasaThovezAmministrazione = true
VAR GoranCasaThovezAmministrazione = true
VAR CristinaCasaThovezAmministrazione = true

VAR SCasaThovezCameraDaLetto = true
VAR CatenaCasaThovezCameraDaLetto = true
VAR CristinaCasaThovezCameraDaLetto = true
VAR FatimaCasaThovezCameraDaLetto = false
VAR GoranCasaThovezCameraDaLetto = false
VAR ThovezCasaThovezCameraDaLetto = true

VAR SCasaIsaacEsternoInFiamme = true
VAR CatenaCasaIsaacEsternoInFiamme = true
VAR CristinaCasaIsaacEsternoInFiamme = true

//SETTAGGIO ATTO ATTIVO
//VAR AttoCorrente = "GiornoUnoMattina"
EXTERNAL caricaAtto(nomeAtto)

//SETTAGGIO SCENA ATTIVA
//VAR ScenaCorrente = "CameraInOsteria"
EXTERNAL caricaScena(nomeScena)

//CARICAMENTO PARTITA
//VAR caricaPartita = "Catena"
EXTERNAL caricaPartita(nomePersonaggio)

//CARICAMENTO DECKBUILDING
EXTERNAL caricaDeckBuilding()

//POSIZIONE DELLE PERSONAGGE
VAR PersonaggioSx = "S"
VAR PersonaggioDx = "Catena"

