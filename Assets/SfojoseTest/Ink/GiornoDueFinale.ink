//ESTERNO CASA DI ISAAC

=== Dialog_CatenaCasaIsaacEsternoInFiamme
{
- IsaacWin && not IsaacABallare: -> IsaacABallare
- not IsaacWin && not IsaacInCasa: -> IsaacInCasa
- else: -> finale
}


    = IsaacABallare
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Guarda quante persone, S.! Isaac è così benvoluto!"
        <b><color=\#3a6954>Catena</color></b>: "La casa, la casa S.! Non c'è più niente da fare!"
            * "Tutta una vita, un piccolo pezzo di vita..."
            * "L'Isaac c'avrà il cuore a pezzi."
            * "Voglio bruciare quella fottuta ducea, tutta!"
            -
        <b><color=\#3a6954>Catena</color></b>: "Però ora sono così felice che è così testone."
        <b><color=\#3a6954>Catena</color></b>: "Domani cosa facciamo?"
            * "Assaltiamo la prigione."
                <b><color=\#3a6954>Catena</color></b>: "Come ai vecchi tempi, mi piace!"
            * "Facciamo scoppiare questa fottuta rivolta."
                <b><color=\#3a6954>Catena</color></b>: "L'ultima cosa che mi mancava di fare prima di morire!"
            * "Lo sappiamo al risveglio."
                <b><color=\#3a6954>Catena</color></b>: "Hai piani che non conosco?"
                * * "No, sono solo sconfortato ora."
                    <b><color=\#3a6954>Catena</color></b>: "Vedrai che troveremo una soluzione anche questa volta!"
                * * "Confido nei sogni."
                    <b><color=\#3a6954>Catena</color></b>: "Come a Smirne?"
                * * "Non ancora, ma so che arriverà."
            - 
            
        <b><color=\#3a6954>Catena</color></b>: "Amore?"
        {
        - ThovezUccisoCristina:
            -> Cristinatradisce
        - not ThovezUccisoCristina:
            -> continua
        }  


    = IsaacInCasa
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Guarda quante persone, S.! Isaac era così benvoluto!"
            * "È così benvoluto, vita mia. Non l'è morto."
        <b><color=\#3a6954>Catena</color></b>: "La casa, la casa S.! Non c'è più niente da fare!"
            * "Tutta una vita, un piccolo pezzo di vita..."
            * "L'Isaac avrà il cuore a pezzi."
            * "Voglio bruciare quella fottuta ducea, tutta!"
            -
        <b><color=\#3a6954>Catena</color></b>: "Non ci ascolta mai, dio cristo, mai! Solo stasera doveva farlo?"
            * "Amore, ancora non sappiamo se è lì dentro."
            -
        <b><color=\#3a6954>Catena</color></b>: "Hai ragione. Forse è andato alla festa e ci ha fregate."
            * "Così ora sarebbe in prigione."
            -
        <b><color=\#3a6954>Catena</color></b>: "Ma almeno sarebbe vivo. Ho bisogno di far qualcosa, cuoricì!"
            * "Anche io amore, ma siamo troppo tese ora."
            {
            - ThovezUccisoCristina:
                -> Cristinatradisce
            - not ThovezUccisoCristina:
                -> continua
            }    
    
    = Cristinatradisce
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Lo sai che lei aveva quel suo stupido piano da subito, vero?"
            * "La Cristina?"
            -
        <b><color=\#3a6954>Catena</color></b>: "Sì. Ti ha fregato come a Napoli, cuoricì."
            * "Non sai di cosa parli, Catè."
                <b><color=\#3a6954>Catena</color></b>: "E la difendi pure, ora?"
                * * "Non è il momento."
                    <b><color=\#3a6954>Catena</color></b>: "O magari sì, almeno litighiamo e mi sfogo!"
            * "Non so cosa pensare."
                <b><color=\#3a6954>Catena</color></b>: "Non serve pensare, è palese!"
            * "Mi sa che c'hai ragione."
                <b><color=\#3a6954>Catena</color></b>: "Spero farai qualcosa. Non la voglio tra i piedi."
            -
        <b><color=\#3a6954>Catena</color></b>: "Scusa, non era il caso di tirare fuori 'sta roba ora. Torniamo in osteria?"
            + [<b>Esci dal prototipo</b>]"Va bene, andiamo."
                ~ PersonaggioSx = "SNarrante"
                ~ PersonaggioDx = ""
                <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"-> DONE
            + {not Dialog_CristinaCasaIsaacEsternoInFiamme.CristinaUccisoThovez.vattene}"Vorrei parlare un attimo con la Cristina."
                <b><color=\#3a6954>Catena</color></b>: "Se proprio devi."
                -> DONE
    
    -> DONE

    = continua
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
        <b><color=\#3a6954>Catena</color></b>: "Siamo state così sciocche, a fidarci di lui."
        <b><color=\#3a6954>Catena</color></b>: "Torniamo all'osteria, non voglio più stare qui."
            + [<b>Esci dal prototipo</b>]"Va bene, andiamo."
                ~ PersonaggioSx = "SNarrante"
                ~ PersonaggioDx = ""
                <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                    ~ caricaAtto("TitoliDiCoda")
                    -> DONE
            + {not CristinaWin && not Dialog_CristinaCasaIsaacEsternoInFiamme.CristinaUccisoThovez.vattene} "Vorrei parlare un attimo con la Cristina."
                <b><color=\#3a6954>Catena</color></b>: "Se proprio ci tieni."
                -> DONE

    = finale
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    <b><color=\#3a6954>Catena</color></b>: "Siamo state così sciocche, a fidarci di lui."
        
        ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Torniamo all'osteria, non voglio più stare qui."
            + [<b>Esci dal prototipo</b>]"Va bene, andiamo."
                ~ PersonaggioSx = "SNarrante"
                <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                    ~ caricaAtto("TitoliDiCoda")
                    -> DONE
            + {not CristinaWin && not Dialog_CristinaCasaIsaacEsternoInFiamme.CristinaUccisoThovez.vattene} "Vorrei parlare un attimo con la Cristina."
                <b><color=\#3a6954>Catena</color></b>: "Devi proprio?"
                -> DONE
            
=== Dialog_CristinaCasaIsaacEsternoInFiamme
~ PersonaggioSx = "S"
~ PersonaggioDx = "Cristina"
{
- not inizio: -> inizio
- inizio: -> finale
}

= inizio
    <b><color=\#6d282a>Cristina</color></b>: "Dio, guarda che fiamme!"
    * ["Come ti senti?"]"La a bé, Cristina?"
    -
    <b><color=\#6d282a>Cristina</color></b>: "Mi dispiace, per Isaac. Davvero."
    <b><color=\#6d282a>Cristina</color></b>: {not IsaacWin: "Sono sicura che non fosse in casa. Dio ce lo riporterà, S."|"Lo tireremo fuori da quella prigione."}
        * "Grazie, Cristina. E in merito al Thovez..."
        {
        - !ThovezWin:
            -> ThovezNoCasa
        - ThovezWin:
            -> ThovezSiCasa
        }
 
 =ThovezNoCasa
~ PersonaggioSx = "S"
~ PersonaggioDx = "Cristina"

    <b><color=\#6d282a>Cristina</color></b>: "La pagherà, S., promesso. Non ho mai pensato di voler uccidere qualcuno, eppure..."
        * "Cristina, uccidere non l'è divertente."
            <b><color=\#6d282a>Cristina</color></b>: "Lo so. Ma non tutte le cose giuste lo sono."
        * "Cosa ti ha fatto, Cristina?"
            <b><color=\#6d282a>Cristina</color></b>: "Parliamone dopo. Ora pensiamo ad Isaac."
        * "Se lo farai, fallo vicino a me.["] Fa male, uccidere. Non devi essere sola."
            <b><color=\#6d282a>Cristina</color></b>: "Grazie, S., davvero. Anche per avermi perdonata. Per avermi aiutata."
        
        -
    <b><color=\#6d282a>Cristina</color></b>: "Comunque: Henry è una brava persona. Posso chiedergli aiuto."
        * "Per cosa?"
        -
    <color=\#6d282a>Cristina</color> {not IsaacWin: "Per, per capire cos'è successo. Per risolvere tutto questo."|"Per liberare Isaac dalla prigione."}  
        * "Ti ringrazio, Cristina. Ma voglio solo persone fidate vicino, ora."
        -
    <b><color=\#6d282a>Cristina</color></b>: "E io sono tra loro?"
        * "Ancora non ce l'ho capito."
            <b><color=\#6d282a>Cristina</color></b>: "Lo capisco, S., e farò in modo di riguadagnarmi la tua fiducia."
            {Dialog_CristinaCasaThovezBiblioteca.PrimaDellaPartita.promessa:
            <b><color=\#6d282a>Cristina</color></b>: "Partendo dalla promessa che ti ho fatti ieri sera. Quando vuoi sono pronta a parlare."
            }
        * "Credo di sì eh."
            <b><color=\#6d282a>Cristina</color></b>: "Grazie di cuore. Non ti deluderò."
            {Dialog_CristinaCasaThovezBiblioteca.PrimaDellaPartita.promessa:
            <b><color=\#6d282a>Cristina</color></b>: "E non ho dimenticato quello che ti ho promesso ieri sera."
            }
        * "No eh."
            <b><color=\#6d282a>Cristina</color></b>: "Io... credo tornerò a casa ora. Ci troviamo domattina, all'osteria."
        -
        + [<b>Esci dal prototipo</b>]"È tempo di tornare all'osteria."
            ~ PersonaggioDx = ""
            ~ PersonaggioSx = "SNarrante"
            <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                ~ caricaAtto("TitoliDiCoda")
                -> DONE
        + "Vorrei parlare con la vita mia un attimo." -> DONE
        
 
 
 = ThovezSiCasa
~ PersonaggioSx = "S"
~ PersonaggioDx = "Cristina"
 {
    - !ThovezUccisoCristina:
        -> CristinaNoUccisoThovez
    - ThovezUccisoCristina:
        -> CristinaUccisoThovez
    }
 
 
 = CristinaUccisoThovez
~ PersonaggioSx = "S"
~ PersonaggioDx = "Cristina"

    <b><color=\#6d282a>Cristina</color></b>: "Dillo."
        * "Cosa?"
        -
    <b><color=\#6d282a>Cristina</color></b>: "Che ti ho deluso. Tradito. Uccidendo Thovez."
        * "Avevi le tue ragioni, credo."
            <b><color=\#6d282a>Cristina</color></b>: "Tutto qui?"
            * * "Cosa ti aspetti, che mi ci metta mica ad urlare?"
                <b><color=\#6d282a>Cristina</color></b>: "Almeno saprei che ti importa!"
                * * * "Di cosa? Di una donna che si comporta ancora come una s'cèta?"
                    <b><color=\#6d282a>Cristina</color></b>: "Io... forse è il caso di separarci. Siamo troppo tese."
                * * * "Ora mi importa dell'Isaac, punto."
                    <b><color=\#6d282a>Cristina</color></b>: "Scusa, hai ragione. Scusa."
                * * * "Non sei affatto cambiata."
                    <b><color=\#6d282a>Cristina</color></b>: "Nemmeno tu, cristo. Ma va bene, non è il momento per discutere."
            * * "Non so se l'hai notato, ma sono preoccupato per l'Isaac ora."
                    <b><color=\#6d282a>Cristina</color></b>: "Hai ragione. Hai ragione, sono una sciocca."
            * * "Sì. Non conosco la tua storia, Cristina. Non più."
                    <b><color=\#6d282a>Cristina</color></b>: "Io... grazie, S., davvero."
            
        * "Cambierebbe qualcosa dirtelo?"
            <b><color=\#6d282a>Cristina</color></b>: "Almeno saprei cosa pensi di me."
        * "Sono così stanco di essere incazzato, Cristina.["] Non ne hai idea. Nemmeno mi importa di quello che è accaduto."
            <b><color=\#6d282a>Cristina</color></b>: "E non ti importa di me?"
            <b><color=\#6d282a>Cristina</color></b>: "No, non voglio saperlo, non ora."
        -
        <b><color=\#6d282a>Cristina</color></b>: "Cosa vuoi che faccia, S., dimmelo!"
            * (vattene) "Vattene dalla mia vita."
                <b><color=\#6d282a>Cristina</color></b>: "Speravo in un epilogo diverso. Ma capisco. Addio, S."
                    ~ CristinaCasaIsaacEsternoInFiamme = false
                -> DONE
            * "Dammici il tempo di capire."
                <b><color=\#6d282a>Cristina</color></b>: "Hai ragione, tesoro. Hai ragione."
            -    
        
        <b><color=\#6d282a>Cristina</color></b>: "Comunque: Henry è una brava persona. Posso chiedergli aiuto."
        * "Per cosa?"
        -
        <b><color=\#6d282a>Cristina</color></b>: {not IsaacWin: "Per, per capire cos'è successo. Per risolvere tutto questo."|"Per liberare Isaac dalla prigione."}
        <b><color=\#6d282a>Cristina</color></b>: "Ora sostituirà Thovez."
    
        * "Ti ringrazio, Cristina. Ma voglio solo persone fidate vicino, ora."
        -
        <b><color=\#6d282a>Cristina</color></b>: "E io sono tra loro?"
            * "Ancora non l'ho capito."
                <b><color=\#6d282a>Cristina</color></b>: "Lo capisco, S., e farò in modo di riguadagnarmi la tua fiducia."
                {Dialog_CristinaCasaThovezBiblioteca.PrimaDellaPartita.promessa:
                <b><color=\#6d282a>Cristina</color></b>: "Partendo dalla promessa che ti ho fatti ieri sera. Quando vuoi sono pronta a parlare."
                }
            * "Credo di sì eh."
                <b><color=\#6d282a>Cristina</color></b>: "Grazie di cuore. Non ti deluderò."
                {Dialog_CristinaCasaThovezBiblioteca.PrimaDellaPartita.promessa:
                <b><color=\#6d282a>Cristina</color></b>: "E non ho dimenticato quello che ti ho promesso ieri sera."
                }
            * "No eh."
                <b><color=\#6d282a>Cristina</color></b>: "E di chi ti fidi, S.?"
                    * * ["Della Catena."]
                        -> fiducia("della vita mia, Catena")
                    * * ["Dell'Isaac."]
                        -> fiducia("di quel testone dell'Isaac")
                    * * ["Della mia ciurma."]
                        -> fiducia("della mia ciurma, perché è la mia famiglia")
                    * * ["Solo di me stesso."]
                        -> fiducia("alla fin fine, solo di me stesso")
            -            
            <b><color=\#6d282a>Cristina</color></b>: "Io... credo tornerò a casa ora. Ci troviamo domattina, all'osteria."
            -
            + [<b>Esci dal prototipo</b>]"È tempo di tornare all'osteria."
                ~ PersonaggioSx = "SNarrante"
                ~ PersonaggioDx = ""
                <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                    ~ caricaAtto("TitoliDiCoda")
                    -> END
            + "Ho bisogno di parlare un attimo con la vita mia, aspettami." -> DONE
    
    
    
 = CristinaNoUccisoThovez
~ PersonaggioSx = "S"
~ PersonaggioDx = "Cristina"

    <b><color=\#6d282a>Cristina</color></b>: "Grazie, per prima. Per non avermi fatto uccidere Thovez."
        * "Ricordo ancora il mio primo omicidio.["] E pure la vita mia se lo ricorda sicuro. Per quanto possibile, voglio evitarlo a chi voglio bene."
        -
    <b><color=\#6d282a>Cristina</color></b>: "Non...non sarebbe stato il primo."
        * "Cosa?"
        * "Non immaginavo!"
        * "Tu?"
        -
    <b><color=\#6d282a>Cristina</color></b>: "Ma non mi va di parlarne ora."
    
    <b><color=\#6d282a>Cristina</color></b>: "Piuttosto: Henry è una brava persona. Posso chiedergli aiuto."
    <b><color=\#6d282a>Cristina</color></b>: "Ora sostituirà Thovez."
        * "Per cosa?"
        -
    { IsaacWin: 
        Cristina: "Per, per capire cos'è successo. Per risolvere tutto questo."
            * "Tu credi sia ancora vivo?"
                Cristina: "Lo sento, S., Dio non può averlo abbandonato così."
            -> continua     
            * "Cosa rimane da risolvere?"
                Cristina: "Tutto: fintanto che siamo vive, tutto."
            -> continua 
            * "Ricostruire tutta la sua villa?"
                Cristina: "Anche. Tutto, pur di non restar qui a piangere e basta."
            -> continua    
    - else:
        Cristina: "Per liberare assieme Isaac dalla prigione."
            * "No, è e rimane un Thovez."
            -> continua 
            * "Assieme?"
            -> continua 
            * "Sperando è ancora vivo."
            -> continua
    }    
  
    
    = continua
        * "Ti ringrazio, Cristina. Ma voglio solo persone fidate vicino, ora."
        -
        <b><color=\#6d282a>Cristina</color></b>: "E io sono tra loro?"
        * "Ancora non l'ho capito."
            <b><color=\#6d282a>Cristina</color></b>: "Lo capisco, S., e farò in modo di riguadagnarmi la tua fiducia."
        * "Credo di sì eh."
            <b><color=\#6d282a>Cristina</color></b>: "Grazie di cuore. Non ti deluderò."
        * "No eh."
            <b><color=\#6d282a>Cristina</color></b>: "Io... credo tornerò a casa ora. Ci troviamo domattina, all'osteria."
        -
        + [<b>Esci dal prototipo</b>]"È tempo di tornare all'osteria."
            ~ PersonaggioSx = "SNarrante"
            <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                ~ caricaAtto("TitoliDiCoda")
                -> END
        + "Scambio due parole con la vita mia e ci sono." -> DONE
 -> DONE
    
    = finale
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    <b><color=\#6d282a>Cristina</color></b>: "{Non ci rimane che riposare un po'|Recuperiamo un po' di energie.|Andiamo a dormire, S.}"
        + [<b>Esci dal prototipo</b>]"È tempo di tornare all'osteria."
            ~ PersonaggioSx = "SNarrante"
            ~ PersonaggioDx = ""
            <b><color=\#354174>S. Narrante</color></b>: "Ora è il caso che mi riposi un poco, ma presto torno a raccontarti la mia storia. A presto!"
                ~ caricaAtto("TitoliDiCoda")
                -> END
        + "Due parole con la vita mia, e arrivo." -> DONE
    
=== fiducia(chi) ===
"Mi fido solo {chi}!"
->-> 

