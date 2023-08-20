                            /* ---------------------------------
                            
                                    AMMINISTRATORE
                                    
                             ----------------------------------*/

=== Dialog_CatenaCasaThovezAmministrazione
{
- Dialog_FatimaCasaThovezAmministrazione_Step == 0: -> PrimaDellaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1 && not DopoLaPartita: -> DopoLaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1 && DopoLaPartita: -> fallback
}

    
    = PrimaDellaPartita
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
    <b><color=\#3a6954>Catena</color></b>: {~ "Fino a qui è stata facile, cuoricì!"|"Mi sembra proprio che le guardie non lo amano tanto, comunque."|"Ce lo rifacciamo poi un salto in cucina?"|"Ma quanto russava la cuoca?"|{not CristinaWin: "Ma quella si è messa in tiro pure per una retata?"|"Dici che la tua suora con le voglie ci avrebbe aiutate davvero?"}|{IsaacWin: "Spero che Isaac si stia divertendo a quella dannata festa!"|"Te lo immagini ora, Isaac a casa a leggere e annoiarsi?"}}
    
    
    -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
    <b><color=\#3a6954>Catena</color></b>: "Quell'Henry!"
    //testing loop in a wave
    - (opts)
    <b><color=\#3a6954>Catena</color></b>: {"C'è gente che non conosce coraggio."|"Isaac sarà un testone, ma almeno si vive la sua benedetta vita!"|"Come fa una persona a diventare il cane di un'altra?"|"C'hai una pazienza tu a volte: gli darei due ceffoni per farlo svegliare."}
        * "Non l'è facile per tutti, vita mia."
            <b><color=\#3a6954>Catena</color></b>: "Ma se non si è sè stessi in famiglia, dove lo si può essere?"
        * "Il Thovez è una persona molto spiacevole, anche con la sua famiglia."
            <b><color=\#3a6954>Catena</color></b>: "Non è la sua famiglia, sono i suoi servi."
        * "Ti ricordi com'eri quando ci siamo conosciute al bordello?"
            <b><color=\#3a6954>Catena</color></b>: "Hai ragione, cuoricì. A volte è facile dimenticarsi le cose brutte del passato."
        + "Fammi parlare un attimo con le altre, vita mia." -> DONE    
        + {loop} [<b>Passa alla scena successiva</b>]"Andiamo avanti, amore."
            ~ caricaScena("CasaThovezCameraDaLetto")
            -> done

    - (loop)
        {-> opts | ->opts | } <b><color=\#3a6954>Catena</color></b>: "Thovez è una malattia per questa città."
    
    - (done)
        <b><color=\#3a6954>Catena</color></b>: "Bene cuoricino, raggiungiamo quella merda!"
        ~ caricaScena("CasaThovezCameraDaLetto")
    -> DONE

    = fallback
	~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    <b><color=\#3a6954>Catena</color></b>: "{~ Cosa è questa via crucis?|Ancora qui stiamo?|Quando andiamo in camera del Thovez?|{CristinaWin:C'è differenza tra fratello e zerbino.|Cristina sembra difenderlo, non capisco. Cazzo fa Thovez alle persone?}}
        ~ FatimaCasaThovezCameraDaLetto = false
        ~ GoranCasaThovezCameraDaLetto = false
        + "Abbi pazienza, vita mia. Parlo con le altre e andiamo."-> DONE
        * [<b>Passa alla scena successiva</b>]"Bene, andiamo avanti!"
        ~ caricaScena("CasaThovezCameraDaLetto")
        -> DONE


=== Dialog_CristinaCasaThovezAmministrazione
{Dialog_FatimaCasaThovezAmministrazione_Step:
- 0: -> PrimaDellaPartita
- else: -> DopoLaPartita
}

    
    = PrimaDellaPartita
    ~ PersonaggioSx = "Cristina"
    ~ PersonaggioDx = ""
    
    <b><color=\#6d282a>Cristina</color></b>: {~ "La cuoca è una brava donna, ma quanto parla!"|"La tua amata continua a guardarmi male."|"Dici che l'hai convinto poi ieri sera Philip a fidarsi?"|"Quante volte sono venuta di nascosto per queste stanze."|"La madre di Philip mi odia, pensa che lo stia rovinando. Io!"| {IsaacWin: "Mi spiace che il tuo amico non ti abbia ascoltato stamani."|"Ancora poco tempo, e potrai dire al tuo amico che è libero."}}
        -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "Cristina"
    ~ PersonaggioDx = ""
    
    <b><color=\#6d282a>Cristina</color></b>: {~ "Questo ragazzo ha così bisogno d'amore!"|"Perché Philip avvelena tutto quel che tocca?"|"Non giudicare Henry, è un ragazzo tanto dolce, e tanto spaventato."|"Vedo in Henry le mie paure. Cosa brutta è una vita vissuta nel terrore."|"Cristo non ha mai condannato l'amore. Henry dovrebbe avere sia il Suo, sia quello di un altro uomo."|"Le sue parole sembrano le mie quando ti ho conosciuta."} 
        -> DONE


=== Dialog_FatimaCasaThovezAmministrazione
{
- Dialog_FatimaCasaThovezAmministrazione_Step == 0: -> PrimaDellaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1: -> DopoLaPartita

}

    = PrimaDellaPartita
    ~ PersonaggioSx = "Fatima"
    ~ PersonaggioDx = ""
    
    <b><color=\#EF8F06>Fatima</color></b>: {~ "Arrotino faceva spia per Thovez. Faceva. Addio arrotino."|"Amine avrebbe odiato questo stupido posto."|"Questo si crede un re, ma sua casa è grande come canile di mio padre."| {CristinaWin: "Maaa, Catena dice che ti sei ritrovato una vecchia fiamma?" |"Tua nuova amica puzza di guai."} | {IsaacWin: "Ho spedito Vituzzo alla festa di Isaac, ovviamente ha protestato, il grand'uomo."|"Comunque ho presa il jambiyya, eccolo!"}} -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "Fatima"
    ~ PersonaggioDx = ""
    
    <b><color=\#EF8F06>Fatima</color></b>: {~ "Quanto parlate voi, sempre!"|"Da quando che non combattiamo, S.?"|"Amine avrebbe tramortito e via, un atto di carità."|"Thovez non sa cosa sia famiglia, palese palese."|"Avevo capito che giorni di riposo, questi."}
    
        ~ FatimaCasaThovezCameraDaLetto = false
        ~ GoranCasaThovezCameraDaLetto = false
    
    <b><color=\#EF8F06>Fatima</color></b>: "{Goran e io rimaniamo qui a controllare l'area, voi andate avanti!|Con me area qui al sicuro, capo!|Chissà se Goran ha ancora quell'idea di casetta?|Ma tu e Isaac infilate coltello nel burro?|So che non cose mie, ma si vive bene assieme con amore e no sesso?}
        + "Perfetto, parlo con le altre un attimo e avanziamo." -> DONE
        + [<b>Passa alla scena successiva</b>]"Grazie Fatima, vado avanti allora!"
        ~ caricaScena("CasaThovezCameraDaLetto")
        -> DONE


=== Dialog_GoranCasaThovezAmministrazione
{
- Dialog_FatimaCasaThovezAmministrazione_Step == 0: -> PrimaDellaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1: -> DopoLaPartita

}

    = PrimaDellaPartita
    ~ PersonaggioSx = "Goran"
    ~ PersonaggioDx = ""
    
     <b><color=\#4B4747>Goran</color></b>: {~ "Don Gianni alla fine darà cibo e protezione a uomini armati del paese."|"Questa sera ho pregato per Isaac."|"Nessun uomo dovrebbe possedere tutto questo, con gente che muore di fame."| {CristinaWin: "Tu sai cosa Fatima pensa di me?"|"Che sai perdonare è bello, è bello che tua nuova amica qui."} | "Giuseppe dice che Thovez ha molta paura in realtà."}
    
    -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "Goran"
    ~ PersonaggioDx = ""
    
    <b><color=\#4B4747>Goran</color></b>: {"La gente dice "Dio" per parlare delle sue paure."|"Però questa cosa della omosessualità non la capisco molto."|"Ma bisogna proteggere famiglia, come fai tu con noi e noi con te."|"Anche se tu a volte troppo autoritario, S.!"| "Però capisco Thovez, a volte bisogna proteggere da cose dentro di noi." | "E forse lui vuole proteggere Henry da suo vizio, da sua malattia."| "Non è anche questo, famiglia?"}
    
        ~ FatimaCasaThovezCameraDaLetto = false
        ~ GoranCasaThovezCameraDaLetto = false
    
    <b><color=\#4B4747>Goran</color></b>: "{Resto con Fatima per tenere sotto controllo questo Henry, tu vai avanti.|Non ti fidi di noi?|S., vai pure, non accadrà nulla.|Ci pensa la tua famiglia ora, me e Fatima!}"
        + "Grazie Goran, parlo un attimo con le altre e andiamo." -> DONE
        * [<b>Passa alla scena successiva</b>]"Vado allora. Non rincoglionire l'Henry, va bene?"
        ~ caricaScena("CasaThovezCameraDaLetto")
        -> DONE  

  

=== Dialog_AmministratoreCasaThovezAmministrazione
{
- Dialog_FatimaCasaThovezAmministrazione_Step == 0: -> PrimaDellaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1 && not DopoLaPartita: -> DopoLaPartita
- Dialog_FatimaCasaThovezAmministrazione_Step == 1 && DopoLaPartita: -> fallback
}

    
    = PrimaDellaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Amministratore"
    
        <b><color=\#6F6510>Henry</color></b>: "S., cosa ci fai qui?"
            * "Sto cercando tuo fratello."
                <b><color=\#6F6510>Henry</color></b>: "{ThovezWin:È in camera sua, a dormire o pregare.|È alla festa dei Woodhouse.}"
            * {not CristinaWin} "La Cristina mi fa fare il grand tour."
                <b><color=\#6F6510>Henry</color></b>: "Cristina? Hai deciso di tradire la fiducia di Thovez?"
                <b><color=\#6d282a>Cristina</color></b>: "Lui ha tradito la mia da tempo, Henry."
            * {CristinaWin} "Prendo spunti per arredare la nave."
                <b><color=\#6F6510>Henry</color></b>: "Non sapevo che le navi avessero lunghi corridoi."
            * "Henry, cosa ci fai qui?"
                <b><color=\#6F6510>Henry</color></b>: "Cosa? Ci vivo, che diavolo!"
            -    
        <b><color=\#6F6510>Henry</color></b>: "Ma questo non risponde alla mia domanda, S.: non dovresti essere qui."
        <b><color=\#6F6510>Henry</color></b>: "Ti chiedo scusa, ma devo chiamare le guardie."
    -
    ~ Dialog_FatimaCasaThovezAmministrazione_Step += 1
    ~ caricaPartita("Amministratore")
    @
    
    -> DopoLaPartita
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Amministratore"
    
        <b><color=\#EF8F06>Fatima</color></b>: "Coi pugnali ce la risolvevamo in un minuto."
    {Partita_Amministratore_Zuffa == true && not AmministratoreWin:
    <b><color=\#6F6510>Henry</color></b>: "Va bene, S. Ma vi prego, non dite niente di, della mia condizione in giro!"
    }
    {Partita_Amministratore_Zuffa == true && AmministratoreWin:
    <b><color=\#6F6510>Henry</color></b>: "Le vostre sono solo illazioni, S., bugie!"
    }
    {Partita_Amministratore_Seduzione == true && not AmministratoreWin:
    <b><color=\#6F6510>Henry</color></b>: "Facciamo che ora vado alla festa dei Mancuso, e non ti ho mai visto."
    }
    {Partita_Amministratore_Seduzione == true && AmministratoreWin:
    <b><color=\#6F6510>Henry</color></b>: "Non tutto è carne, S., non agli occhi di Dio e del suo amore. Vattene da qui!"
    }


    <b><color=\#6F6510>Henry</color></b>: "Non approfittare della mia pazienza, S., vai via. Ora."
            + "Due parole con le compagne e vado."-> DONE
            * [<b>Passa alla scena successiva</b>]"Bene, me la vado a pigliarmela con tuo fratello."
            ~ caricaScena("CasaThovezCameraDaLetto")
            -> DONE

	= fallback
	~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Henry"
    <b><color=\#6F6510>Henry</color></b>: "{Vattene, S.!|Non ti voglio qui.|Fa male, vederti.|Non posso che chiedermi perché...|...perché mio fratello non mi accetta?|Perché non posso vivere e basta?}"
        + "Due parole con le altre e vado." -> DONE
        * [<b>Passa alla scena successiva</b>]"Ragazze, andiamo avanti!"
        ~ caricaScena("CasaThovezCameraDaLetto")
        -> DONE

//PARTITA CON AMMINISTRATORE

=== Partita_Amministratore_Chiacchiera ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Amministratore"

    <b><color=\#354174>S.</color></b>: "<b><color=\#6F6510>Henry</color></b>: Thovez sta minacciando Isaac."
    Herny: "E questo cosa significa?"
    <b><color=\#354174>S.</color></b>: "Non sei mica suo amico?"
    <b><color=\#6F6510>Henry</color></b>: "Ci scambiamo qualche libro, qualche commento sul teatro."
    <b><color=\#354174>S.</color></b>: "E fate qualche festa assieme, ogni tanto."
    <b><color=\#6F6510>Henry</color></b>: "Non so cosa intendi, S."
    <b><color=\#354174>S.</color></b>: "Henry fidati di me, Cristo!"
    <b><color=\#6F6510>Henry</color></b>: "Mi fido di te, ma non di mio fratello."

-> DONE

=== Partita_Amministratore_Seduzione ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Amministratore"

    <b><color=\#354174>S.</color></b>: "Non sei stanco di mentire, Henry? Di vivere mezza vita?"
    <b><color=\#6F6510>Henry</color></b>: "La mia vita è piena, S., non è quella cosa, quella condizione a renderla piena."
    <b><color=\#354174>S.</color></b>: "Non ti manca la vicinanza di qualcuno? Un po' di amore? Di contatto fisico?"
    <b><color=\#6F6510>Henry</color></b>: "Ho i miei libri, la tenuta, i concerti."
    <b><color=\#354174>S.</color></b>: "E dov'è il calore?"
    <b><color=\#6F6510>Henry</color></b>: "Io..."
    <b><color=\#354174>S.</color></b>: "Esatto. Io. Ma è così bello quando c'è un "noi", Henry. Non ti ci manca mica un "noi"? Anche solo per una notte?"
    <b><color=\#6F6510>Henry</color></b>: "Sei il diavolo, S."
    <b><color=\#354174>S.</color></b>: "Sono solo qualcuno che vuole vivere. Tu vuoi vivere, Henry?"
    <b><color=\#6F6510>Henry</color></b>: "Sì."

-> DONE

=== Partita_Amministratore_Zuffa ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Amministratore"

    <b><color=\#354174>S.</color></b>: "Thovez sa di te, Henry."
    <b><color=\#6F6510>Henry</color></b>: "E cosa dovrebbe sapere, farabutto?"
    <b><color=\#354174>S.</color></b>: "Delle tue serate, delle feste, dell'Isaac."
    <b><color=\#6F6510>Henry</color></b>: "Sei feccia, S.!"
    <b><color=\#354174>S.</color></b>: "Pota, guarda la realtà Henry! Se non lo fai per l'Isaac, fallo per te."
    <b><color=\#6F6510>Henry</color></b>: "Philip mi protegge!"
    <b><color=\#354174>S.</color></b>: "Il Philip protegge solo i suoi interessi."
    <b><color=\#6F6510>Henry</color></b>: "I nostri, della famiglia."
    <b><color=\#354174>S.</color></b>: "Ha solo una figlia femmina. Cosa pensi è pronto a fare perché la erediti tutto questo?"
    <b><color=\#6F6510>Henry</color></b>: "Che vuol dire?"
    <b><color=\#354174>S.</color></b>: "Che sei l'erede diretto. Ma se finissi in prigione per sodomia, o peggio..."
    <b><color=\#6F6510>Henry</color></b>: "Io..."
    <b><color=\#354174>S.</color></b>: "Lasciaci passare, Henry."
    <b><color=\#6F6510>Henry</color></b>: "È mio fratello, S."
-> DONE



                    /* ---------------------------------
                    
                            
                            CAMERA DA LETTO DI THOVEZ
                    
                    
                     ----------------------------------*/

=== Dialog_CatenaCasaThovezCameraDaLetto
//abbiamo due fasi: ingresso, parole a caso.
//post: parole a caso.
//le due fasi sono diverse a seconda che Thovez sia presente, e/o sia presente Cristina.
//Abbiamo quindi 4 scenari plausibili per due fasi, ma alcune fasi non hanno variazioni:
// se sono tutti e due assenti, c'è un unico dialogo tra Catena e S.
//SE CRISTINA PRESENTE: LE VARIABILI PASSANO DA LEI.
//SE CRISTINA ASSENTE: PASSANO DA CATENA.

{
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 0) && !CristinaWin && ThovezWin: -> ingressoThovezPresenteCristinaPresente
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 0) && !CristinaWin && !ThovezWin:  -> ingressoThovezAssenteCristinaPresente
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 1)  && !CristinaWin && ThovezWin: -> postThovezPresenteCristinaPresente
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 1)  && !CristinaWin && !ThovezWin:  -> postThovezAssenteCristinaPresente
- (Dialog_CatenaCasaThovezCameraDaLetto_Step == 0) && CristinaWin && ThovezWin: -> ingressoThovezPresenteCristinaAssente
- (Dialog_CatenaCasaThovezCameraDaLetto_Step == 1) && CristinaWin && ThovezWin: -> postThovezPresenteCristinaAssente
- else: -> ThovezAssenteCristinaAssente

}


//THOVEZ MUORE
= ingressoThovezPresenteCristinaPresente
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
    <b><color=\#3a6954>Catena</color></b>: {~ "Cuoricì, è una mia impressione o qui l'aria si è fatta tesa?"|"Com'è che prima Cristina ti ha sussurrato qualcosa?"|"Thovez sembra un'altra persona, lontano dai suoi amici ricchi."|"Cristina sembra così spaventata!"|"Dopo tutto questo, Isaac ci deve una settimana di riposo a casa vostra!"|"Mmm, forse ci servivano i coltelli di Fatima."}

-> DONE

= postThovezPresenteCristinaPresente
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
    <b><color=\#3a6954>Catena</color></b>: "Corriamo a casa, cuoricì!"
            * [<b>Passa alla scena successiva</b>]"Guai a chi si metterà sul nostro cammino, amore!"
    	        ~ caricaScena("CasaIsaacEsternoInFiamme")
    	        ~ caricaAtto("GiornoDueFinale")
    	
-> DONE


//CRISTINA LEGGE LE NOTE
= ingressoThovezAssenteCristinaPresente
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
    <b><color=\#3a6954>Catena</color></b>: {~ "Cristina sembra delusa da qualcosa."|"Ero sicura che ci avrebbe teso un'imboscata, sai?"|"La camera è molto semplice, non me lo aspettavo."|"Quella era la moglie? Forse ha un cuore quest'uomo?"|"Oh, oh. Non mi aspettavo le poesie di Domenico Tempio! Sporcaccione di un Thovez!"|"Un piano? Thovez sa suonare il piano? Saprà solo roba di chiesa!"|"Quella suora si muove come se fosse casa sua."}
-> DONE


= postThovezAssenteCristinaPresente
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
    <b><color=\#3a6954>Catena</color></b>: "Corriamo a casa, cuoricì!"
            * [<b>Passa alla scena successiva</b>]"Sì eh, subito."
    	    ~ caricaScena("CasaIsaacEsternoInFiamme")
    	    ~ caricaAtto("GiornoDueFinale")
    -> DONE



//THOVEZ CI PERCULA
= ingressoThovezPresenteCristinaAssente
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
    <b><color=\#3a6954>Catena</color></b>: {~ "Se vuoi possiamo anche menarlo, non serve proprio parlarci, no?"|"Un piano? Thovez sa suonare il piano? Saprà solo roba di chiesa!"|"Hai visto come gli trema la mano? Ci scommetto che è la prima volta che impugna uno spadino!"|"{AmministratoreWin: "Comunque quella medaglietta lì lo rende ancora più ridicolo, per dire."|"Posso dirgli che persino suo fratello lo odia?"}}
    
    -> DONE


= postThovezPresenteCristinaAssente
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"

        <b><color=\#3a6954>Catena</color></b>: "Andiamocene."
        * [<b>Passa alla scena successiva</b>]"Sono pronto a bruciare tutto, vita mia!"
	    ~ caricaScena("CasaIsaacEsternoInFiamme")
	    ~ caricaAtto("GiornoDueFinale")
	    
-> DONE



//CATENA LEGGE LE NOTE
= ThovezAssenteCristinaAssente
    
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S. Narrante</color></b>: "Il male è una cosa piccola piccola il più delle volte. Una robetta che per cose meschine rovina intere vite."
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    <b><color=\#3a6954>Catena</color></b>: {~ "Ero sicura che ci avrebbe teso un'imboscata, sai?"|"La camera è molto semplice, non me lo aspettavo."|"Quella era la moglie? Forse ha un cuore quest'uomo?"|"Oh, oh. Non mi aspettavo le poesie di Domenico Tempio! Sporcaccione di un Thovez!"|"Un piano? Thovez sa suonare il piano? Saprà solo roba di chiesa!"}
    
    <b><color=\#3a6954>Catena</color></b>: "Merda! Cuoricì, ci ha fottute, lo stronzo! Ci ha FOTTUTE!"
        * "Che succede, vita mia?"
        * "Mi preoccupi, amore."
        * ["Calmati e dimmi tutto."]"Sarà mèi che ta sa dét 'na calmàda!"
        -
        
    <b><color=\#3a6954>Catena</color></b>: "Questa roba, credo siano bolle, ordini, non lo so."
    <b><color=\#3a6954>Catena</color></b>: "Una è una risposta di Torrisi, con tanto di sigillo del servizio di guardia."
    <b><color=\#3a6954>Catena</color></b>: "Leggo: "Caro Thovez, non mi piacciono i tuoi ricatti, ma questa è una cosa che faccio con piacere. Stasera dai Mancuso ci sarà di che divertirsi!"
        * {not IsaacWin} "Merda, no! Però l'Isaac sarà a casa, vero?"
        * {IsaacWin} "Merda merda merda no!"
        -
        
    <b><color=\#3a6954>Catena</color></b>: "E, e questa, S., o dio che merda di uomo!"
    <b><color=\#3a6954>Catena</color></b>: "Non so chi fosse il mittente, ma la risposta è: "Non si preoccupi, dopo stanotte non rimarrà nulla della villa di quel garruso!". S. ..."
        * {not IsaacWin} "Dobbiamo correre a casa, subito!"
            <b><color=\#3a6954>Catena</color></b>: "Thovez la pagherà, te lo prometto cuoricì."
             * * [<b>Passa alla scena successiva</b>]"Lo ucciderò con le mie mani! Corriamo a casa!"
                        ~ caricaScena("CasaIsaacEsternoInFiamme")
	                    ~ caricaAtto("GiornoDueFinale")
	                    -> DONE
        * {IsaacWin} "Dobbiamo correre alla festa, Catena!"
            <b><color=\#3a6954>Catena</color></b>: "No amore mio, no, non possiamo. Se facciamo qualche casino lì, Torrisi avrà tutti i motivi per arrestarci."
            * * "Non possiamo non fare nulla!"
                <b><color=\#3a6954>Catena</color></b>: "Non ho detto questo. Ora possiamo fermare qualsiasi cosa stia accadendo a casa vostra."
                <b><color=\#3a6954>Catena</color></b>: "E domattina assaltiamo la prigione. Assieme ai rivoltosi."
                * * * "Te se' fò de cò vita mia!"
                    <b><color=\#3a6954>Catena</color></b>: "E quando mai questo ci ha fermate? Corriamo alla villa però ora, subito!"
                    * * * * [<b>Passa alla scena successiva</b>]"Andiamo!"
                        ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                ~ caricaAtto("GiornoDueFinale")
                        -> DONE 
                * * * "Thovez la pagherà col sangue, promesso!"
                    <b><color=\#3a6954>Catena</color></b>: "Domani sarà tra le mani dei popolani. Vedrai che divertimento!"
                    * * * * [<b>Passa alla scena successiva</b>]"Lo ucciderò con le mie mani! Corriamo a casa!"
                        ~ caricaScena("CasaIsaacEsternoInFiamme")
	                    ~ caricaAtto("GiornoDueFinale")
	                   -> DONE 
	                   
                * * * "Perché non mi ha ascoltato Isaac, perché?"
                    <b><color=\#3a6954>Catena</color></b>: "Perché è Isaac, lo dici sempre anche tu."
                    <b><color=\#3a6954>Catena</color></b>: "Ma ora corriamo a casa di Isaac, vediamo di salvare la casa. Così quando sarà libero, potrà tornare ai suoi libri e alle sue piante. E noi ci prendiamo una vacanza. Una vera vacanza."
                    * * * * [<b>Passa alla scena successiva</b>]"Ti amo, vita mia. Corriamo a casa!"
                        ~ caricaScena("CasaIsaacEsternoInFiamme")
	                    ~ caricaAtto("GiornoDueFinale")
                        -> DONE 
            
 
=== Dialog_CristinaCasaThovezCameraDaLetto
{
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 0) && !CristinaWin && ThovezWin: -> ingressoThovezPresenteCristinaPresente
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 0) && !CristinaWin && !ThovezWin:  -> ingressoThovezAssenteCristinaPresente
- (Dialog_CristinaCasaThovezCameraDaLetto_Step == 1)  && !CristinaWin && ThovezWin: -> postThovezPresenteCristinaPresente
}


//CRISTINA UCCIDE THOVEZ
= ingressoThovezPresenteCristinaPresente
    ~ PersonaggioSx = "Cristina"
    ~ PersonaggioDx = ""

    <b><color=\#6d282a>Cristina</color></b>: {"Permettimi di parlargli, S."|"Devo chiarire delle cose con lui, è importante."|"Abbi fiducia in me."|"Ti chiedo pochi minuti."}

    -> DONE

= postThovezPresenteCristinaPresente
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
  
    
     <b><color=\#6d282a>Cristina</color></b>: "Andiamocene!"
            * [<b>Passa alla scena successiva</b>]"Sì eh."
            
    	~ caricaScena("CasaIsaacEsternoInFiamme")
    	~ caricaAtto("GiornoDueFinale")
    	-
    -> DONE


//CRISTINA CI LEGGE LA LETTERA 
= ingressoThovezAssenteCristinaPresente
    
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S. Narrante</color></b>: "Il male è una cosa piccola piccola il più delle volte. Una robetta che per cose meschine rovina intere vite."
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    <b><color=\#6d282a>Cristina</color></b>: "S., dovresti leggere qui."
        * "Ehm[."], dopo che te ne sei andata ho smesso di leggere, e non ci ricordo nulla."
        * "Cosa c'è scritto?"
        * "Può farlo la Catena?"
            <b><color=\#6d282a>Cristina</color></b>: "Allora ci penso io."
        -
        
        <b><color=\#6d282a>Cristina</color></b>: "Thovez ha lasciato qui bolle, lettere e indicazioni di cose che sta combinando."
        <b><color=\#6d282a>Cristina</color></b>: "La prima è una risposta del capo delle guardie Torrisi."
        <b><color=\#6d282a>Cristina</color></b>: "Leggo: "Caro Thovez, non mi piacciono i tuoi ricatti, ma questa è una cosa che faccio con piacere. Stasera dai Mancuso ci sarà di che divertirsi!"
        ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Fottuto bastardo!"
        * {not IsaacWin} "Merda, no! Però Isaac sarà a casa, vero?"
        * {IsaacWin} "Merda merda merda no!"
        -
        
        ~ PersonaggioDx = "Cristina"    
        <b><color=\#6d282a>Cristina</color></b>: "E qui... oh, no, non è possibile!"
        ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Fammi vedere!"
        ~ PersonaggioDx = "Cristina"
        <b><color=\#6d282a>Cristina</color></b>: "Manca il mittente, ma è carta di riciclo. Dice solo: "Non si preoccupi, dopo stanotte non rimarrà nulla della villa di quel garruso!""
            * {not IsaacWin} "Dobbiamo correre a casa, subito!"
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Thovez la pagherà, te lo prometto cuoricì."
                ~ PersonaggioDx = "Cristina"
                <b><color=\#6d282a>Cristina</color></b>: "Arriveremo noi prima del giudizio di Dio!"
                 * * [<b>Passa alla scena successiva</b>]Lo ucciderò con le mie mani! Corriamo a casa!"
                            ~ Dialog_CristinaCasaThovezCameraDaLetto_Step += 1
                            ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                    ~ caricaAtto("GiornoDueFinale")
    	                    -> DONE
    	                    
            * {IsaacWin} "Dobbiamo correre alla festa!"
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "No amore mio, no, non possiamo. Se facciamo qualche casino lì, Torrisi avrà tutti i motivi per arrestarci."
                ~ PersonaggioDx = "Cristina"
                <b><color=\#6d282a>Cristina</color></b>: "Catena ha ragione. In prigione saremmo inutili."
                * * "Non possiamo non fare nulla!"
                    ~ PersonaggioDx = "Catena"
                    <b><color=\#3a6954>Catena</color></b>: "Non ho detto questo. Ora possiamo fermare qualsiasi cosa stia accadendo a casa vostra."
                    <b><color=\#3a6954>Catena</color></b>: "E domattina assaltiamo la prigione. Assieme ai rivoltosi."
                    ~ PersonaggioDx = "Cristina"
                    <b><color=\#6d282a>Cristina</color></b>: "Lascia fuori la politica, Catena."
                    * * * ["È una follia, vita mia!"]"Te se' fò de cò, vita mia!"
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Cristina, non è il momento."
                        <b><color=\#3a6954>Catena</color></b>: "Cuoricì, quando mai una follia ci ha fermate? Corriamo alla villa però ora, subito!"
                        * * * * [<b>Passa alla scena successiva</b>]"Andiamo!"
                        ~ Dialog_CristinaCasaThovezCameraDaLetto_Step += 1
                        ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                ~ caricaAtto("GiornoDueFinale")
                        -> DONE 
                    * * * "Il Thovez la pagherà col sangue, promesso!"
                        ~ PersonaggioDx = "Cristina"
                        <b><color=\#6d282a>Cristina</color></b>: "Che Dio ci perdoni!"
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Domani sarà tra le mani dei popolani. Vedrai che divertimento!"
                        * * * * [<b>Passa alla scena successiva</b>]"Lo ucciderò con le mie mani! Corriamo a casa!"
                            ~ Dialog_CristinaCasaThovezCameraDaLetto_Step += 1
                            ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                    ~ caricaAtto("GiornoDueFinale")
    	                   -> DONE
                    * * * "Perché non mi ha ascoltato l'Isaac, perché?"
                        ~ PersonaggioDx = "Cristina"
                        <b><color=\#6d282a>Cristina</color></b>: "Tu cosa avresti fatto, al suo posto?"
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Perché è Isaac, lo dici sempre anche tu."
                        <b><color=\#3a6954>Catena</color></b>: "Ma ora corriamo a casa di Isaac, vediamo di salvare la casa. Così quando sarà libero, potrà tornare ai suoi libri e alle sue piante. E noi ci prendiamo una vacanza. Una vera vacanza."
                        * * * * [<b>Passa alla scena successiva</b>]"Corriamo a casa!"
                            ~ Dialog_CristinaCasaThovezCameraDaLetto_Step += 1
                            ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                    ~ caricaAtto("GiornoDueFinale")
                        -> DONE 




=== Dialog_ThovezCasaThovezCameraDaLetto
{
- !CristinaWin && ThovezWin: -> ingressoThovezPresenteCristinaPresente
- CristinaWin && ThovezWin: -> ingressoThovezPresenteCristinaAssente
}


//CRISTINA E THOVEZ
= ingressoThovezPresenteCristinaPresente
    
    ~ Dialog_CristinaCasaThovezCameraDaLetto_Step += 1
        ~ PersonaggioSx = "SNarrante"
        
        <b><color=\#354174>S. Narrante</color></b>: "Quando siamo distanti, pensiamo di essere gli unici ad avere una vita, ad essere cambiati. Cristina mi ha insegnato quanto questa cosa sia stupida."
        ~ PersonaggioSx = "S"
        ~ PersonaggioDx = "Thovez"
        <b><color=\#81482e>Thovez</color></b>: "Che ci fai con loro, suorina?"
        ~ PersonaggioDx = "Cristina"
        <b><color=\#6d282a>Cristina</color></b>: "Cerco la libertà, quella vera."
        ~ PersonaggioDx = "Thovez"
        <b><color=\#81482e>Thovez</color></b>: "Sei sempre stata una sciocca, Cristina. Come Isaac. Ti circondi di sciocchi S., quando con il tuo temperamento potresti avere il mondo."
            * "Cosa c'azzecca l'Isaac?"
            * "La Cristina almeno ha un cuore, a differenza tua."
            * "Ho già il mondo che mi interessa, Philip."
            -
            
            ~ PersonaggioDx = "Thovez"
            <b><color=\#81482e>Thovez</color></b>: "Sapevo di non dovermi fidare di te, sai? E così mi sono, diciamo, attivato per un piano di sicurezza."
            * "Cosa stai blaterando?"
            -
            
        <b><color=\#81482e>Thovez</color></b>: "A quest'ora il nostro caro capo della vigilanza insieme ai suoi uomini è a casa dei Mancuso per una bella raccolta di pervertiti, tra cui il tuo caro maritino. Che domani se ne andrà a Londra. Chissà come lo accoglieranno le leggi inglesi!"
        
        * {not IsaacWin} "Non so di cosa parli, Isaac è a casa sua."
            
                <b><color=\#81482e>Thovez</color></b>: "Non serve che lo copri, S., so che stasera c'era una festa di pervertiti a casa dei Mancuso, e lui non ne perde mai una."
                    ~ PersonaggioDx = "Cristina"
                    <b><color=\#6d282a>Cristina</color></b>: "Philip, ci siamo assicurate che Isaac rimanesse a casa sua!"
                    ~ PersonaggioDx = "Thovez"
                    <b><color=\#81482e>Thovez</color></b>: "Non è possibile."
                    * * "Non ti piace mica sbagliare, vero?"
                        <b><color=\#81482e>Thovez</color></b>: "Non così, io..."
                        <b><color=\#81482e>Thovez</color></b>: "Dovete correre a casa, subito!"
                        * * * "Cosa stai blaterando, Philip?"
                        <b><color=\#81482e>Thovez</color></b>: "Ho fatto un errore, un errore madornale! Ho chiesto ad un uomo fidato di bruciare casa vostra. Come monito, io..."
                        <b><color=\#81482e>Thovez</color></b>: "Ma se lo merita, no? È un invertito, e gli spetta l'inferno. Vero?"
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Se stai scherzando, ricco di merda..."
                        ~ PersonaggioDx = "Cristina"
                        <b><color=\#6d282a>Cristina</color></b>: "Philip Thovez, sei un male per questo mondo. E nel nome di Dio, estirperò la blasfemia che sei."
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "No, che fai, no!"
                            * * * * "Cristina, cosa hai diavolo hai fatto?"
                                ~ PersonaggioDx = "Cristina"
                                ~ ThovezCasaThovezCameraDaLetto = false
                                <b><color=\#6d282a>Cristina</color></b>: "Doveva morire, S.! Quest'uomo è il diavolo!"
                            * * * * "Era il tuo piano sin dall'inizio, vero?"
                                ~ PersonaggioDx = "Cristina"
                                ~ ThovezCasaThovezCameraDaLetto = false
                                <b><color=\#6d282a>Cristina</color></b>: "No amica mia, te lo giuro. No."
                            * * * * "Catena, dacci il tuo fazzoletto a Cristina."
                                ~ ThovezUccisoCristina = true
                                ~ ThovezCasaThovezCameraDaLetto = false
                                ~ PersonaggioDx = "Catena"
                               <b><color=\#3a6954>Catena</color></b>: "Ci hai usate, vero?"
                               ~ PersonaggioDx = "Cristina"
                               <b><color=\#6d282a>Cristina</color></b>: "No, io... io volevo solo spiegazioni. Ma questa cosa mi ha sconvolta."
                             - - - -  
                           * * * * * [<b>Passa alla scena successiva</b>]"Dobbiamo correre a casa, ora. Salvare Isaac!"
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Non è finita qui, suora dei miei stivali!"
                                ~ caricaScena("CasaIsaacEsternoInFiamme")
        	                    ~ caricaAtto("GiornoDueFinale")
        	                    -> DONE
        
        * {IsaacWin} "Non so di cosa parli."
                ~ PersonaggioDx = "Thovez"
                <b><color=\#81482e>Thovez</color></b>: "Poco mi importa. Domani Isaac sarà su una nave per Londra, dove la giustizia si occuperà di lui."
                    ~ PersonaggioDx = "Cristina"
                    <b><color=\#6d282a>Cristina</color></b>: "Tu non hai idea di cosa sia la giustizia, Philip."
                    ~ PersonaggioDx = "Thovez"
                    <b><color=\#81482e>Thovez</color></b>: "Chiudi la bocca, cagna!"
                        * * "Cosa mi trattiene dall'ucciderti, ora?"
                            <b><color=\#81482e>Thovez</color></b>: "La gentaglia come te abbaia ma non morde, S."
                        * * "Questo è il momento in cui chiedi qualcosa in cambio, vero?"
                            <b><color=\#81482e>Thovez</color></b>: "Oh no, S., la mia fiducia nei tuoi confronti è ufficialmente finita."
                        * * "Sai che non finisce qui, vero?"
                        - -
                    ~ PersonaggioDx = "Thovez"        
                    <b><color=\#81482e>Thovez</color></b>: "Oh, non darti la pena di provare a salvarlo, S., anche perché non avrebbe una casa dove tornare."                    
                        * * "Cosa intendi?"
                        - -
                    ~ PersonaggioDx = "Thovez"    
                    <b><color=\#81482e>Thovez</color></b>: "Alcuni gentiluomini ora stanno provvedendo ad una ristrutturazione totale. Sai, un po' di fuoco, un cambiamento radicale."
                    ~ PersonaggioDx = "Catena"
                    <b><color=\#3a6954>Catena</color></b>: "Razza di animale!"
                    ~ PersonaggioDx = "Cristina"
                    <b><color=\#6d282a>Cristina</color></b>: "S., dobbiamo andare alla casa e fermarli!"
                        * * "No, dobbiamo andare a salvare Isaac!"
                            ~ PersonaggioDx = "Catena"
                            <b><color=\#3a6954>Catena</color></b>: "Cuoricì, non possiamo. Se andiamo ora, in tre, ci fregano subito."
                                * * * "Ma non possiamo non fare nulla!"
                                ~ PersonaggioDx = "Cristina"
                                <b><color=\#6d282a>Cristina</color></b>: "Domattina ci attiveremo per liberarlo, promesso."
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Con l'aiuto dei rivoltosi."
                        * * "Hai ragione, dobbiamo correre!"
                        * * "Dividiamoci[!"]: io vado a salvare Isaac, voi la casa."
                            ~ PersonaggioDx = "Catena"
                            <b><color=\#3a6954>Catena</color></b>: "No, S., dobbiamo rimanere unite."
                            ~ PersonaggioDx = "Cristina"
                            <b><color=\#6d282a>Cristina</color></b>: "E non ha senso andare ora. Ci faremmo fregare subito, così in tre."
                                * * * "Ci sono il Goran e la Fatima!"
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Ma saremmo comunque di meno. Sempre che arriviamo in tempo."
                                ~ PersonaggioDx = "Cristina"
                                <b><color=\#6d282a>Cristina</color></b>: "Esatto. Prendiamoci il tempo per fare un piano, e domattina lo salviamo!"
                        - -
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Siete una manica di illuse."
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Che facciamo di questo cretino?"
                        -
                        *  "Dì a Fatima di consegnarlo ai rivoltosi."
                            ~ PersonaggioDx = "Thovez"
                            <b><color=\#81482e>Thovez</color></b>: "Mi uccideranno! Non puoi farlo, non puoi farlo!"
                                * * * "Sì che posso farlo, vigliacco."
                                    ~ PersonaggioDx = "Cristina"
                                    <b><color=\#6d282a>Cristina</color></b>: "No, non posso permettere che la scampi di nuovo!"
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "Cazzo fai? No, no!"
                                    ~ PersonaggioDx = "Cristina"
                                    <b><color=\#6d282a>Cristina</color></b>: "Ora finalmente sarai nell'inferno che meriti!"
                                    ~ ThovezCasaThovezCameraDaLetto = false
                                    ~ ThovezUccisoCristina = true
                                    * * * * "Era il tuo piano sin da subito, ucciderlo?"
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "No S., no."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Non ti credo."
                                    * * * * "Cristina, perché l'hai fatto?"
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "Perché avrebbe trovato un modo per spuntarla. Il mondo è migliore senza di lui."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Ci hai usate!"
                                    * * * * "Catena, aiutala a pulirsi."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "E perché dovrei?"
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "Non potevo non farlo, Catena. Credimi."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "No, non posso crederti. Ci hai usate, dall'inizio di questa storia."
                                    - - -
                                    * * * [<b>Passa alla scena successiva</b>]"Dobbiamo correre alla casa. Poi affronteremo il resto."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Ti tengo d'occhio, suorina dei miei stivali."
                                        ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                                ~ caricaAtto("GiornoDueFinale")
    	                                -> DONE
	           
                    *  "Dì al Goran di portarlo da don Carlo.["] La polizia è corrotta, ma forse il vescovo può ascoltarci. O ascoltare il preosto."
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Ti fidi di un prete?"
                        * * "Mi fido della cosa più sensata da fare ora.["] Dobbiamo correre alla villa il prima possibile."
                            ~ PersonaggioDx = "Cristina"
                            <b><color=\#6d282a>Cristina</color></b>: "No, non posso permettere che la scampi di nuovo!"
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Cazzo fai? No, no!"
                                ~ PersonaggioDx = "Cristina"
                                <b><color=\#6d282a>Cristina</color></b>: "L'unica cosa che andava fatta. Dio, abbi pietà della mia anima."
                                ~ ThovezUccisoCristina = true
                                ~ ThovezCasaThovezCameraDaLetto = false
                                * * * "Era il tuo piano sin da subito, ucciderlo?"
                                    ~ PersonaggioDx = "Cristina"
                                    <b><color=\#6d282a>Cristina</color></b>: "È così silenzioso, uccidere qualcuno?"
                                * * * "Cristina, perché?"
                                    ~ PersonaggioDx = "Cristina"
                                    <b><color=\#6d282a>Cristina</color></b>: "Perché avrebbe trovato un modo per spuntarla. Il mondo è migliore senza di lui."
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "Ci hai usate!"
                                * * * "Catena, aiutala a pulirsi."
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "E perché dovrei?"
                                    ~ PersonaggioDx = "Cristina"
                                    <b><color=\#6d282a>Cristina</color></b>: "Non potevo non farlo, Catena. Credimi."
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "No. Ci hai usate, dall'inizio di questa storia."
                                - - -    
                                * * * * [<b>Passa alla scena successiva</b>]"Dobbiamo correre alla casa. Poi affronteremo il resto."
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "Ti terrò sotto controllo, suorina dei miei stivali."
                                    ~ caricaScena("CasaIsaacEsternoInFiamme")
    	                            ~ caricaAtto("GiornoDueFinale")
    	                            -> DONE
	                            
                    *  "Lo giustiziamo."
                            ~ PersonaggioDx = "Cristina"
                            <b><color=\#6d282a>Cristina</color></b>: "Permettimi di farlo, S., per favore."
                     
                            * * (siuccidere) "Sei sicura? Non è una cosa da poco."
                                ~ PersonaggioDx = "Cristina"
                                <b><color=\#6d282a>Cristina</color></b>: "Sì. Sono sicura che Dio mi perdonerà per questo."
                                    * * * "Catena, dacci alla Cristina il tuo pugnale."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Suorina, mi stupisci!"
                                        ~ ThovezUccisoCristina = true
                                        ~ ThovezCasaThovezCameraDaLetto = false
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "Ecco, speravo... speravo fosse più difficile."
                                                * * * * "Lo sarà nelle notti a venire, Cristina."
                                
                            * * "No, Cristina. Ti rovineresti la vita."
                                ~ PersonaggioDx = "Cristina"
                                <b><color=\#6d282a>Cristina</color></b>: "Non ho bisogno di un altro padrone, S.!"
                                    * * * "Io ti ho avvisata."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Oh merda, che disastro!"
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "Ecco, speravo... speravo fosse più difficile."
                                            ~ ThovezUccisoCristina = true
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                                * * * * "Lo sarà nelle notti a venire, Cristina."
                                    * * * "Fidati di me."
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Sei stato gentile, S.: l'avrei fatto soffrire di più!"
                                            ~ ThovezUccisoS = true
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                    * * * "Lo farò io, Cristina."
                                        ~ PersonaggioDx = "Cristina"
                                        <b><color=\#6d282a>Cristina</color></b>: "Non posso, mi dispiace S.!"
                                        ~ ThovezUccisoCristina = true
                                        ~ ThovezCasaThovezCameraDaLetto = false
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "No, merda! Che disastro hai fatto, suorina?"
                                            * * * * "Come ti senti, ora?"
                                                ~ PersonaggioDx = "Cristina"
                                                <b><color=\#6d282a>Cristina</color></b>: "Libera."
                                                ~ PersonaggioDx = "Catena"
                                                <b><color=\#3a6954>Catena</color></b>: "Goditela, perché hai rinunciato a notti libere per mesi e mesi."
                            - -
                            * * [<b>Passa alla scena successiva</b>]"Dobbiamo correre a spegnere l'incendio, subito!"
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Io tengo d'occhio la suorina, non mi fido per nulla di questa!"
                                ~ caricaScena("CasaIsaacEsternoInFiamme")
	                            ~ caricaAtto("GiornoDueFinale")
                                -> DONE


//THOVEZ CI PERCULA 
= ingressoThovezPresenteCristinaAssente
    
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S. Narrante</color></b>: "Il male è una cosa piccola piccola il più delle volte. Una robetta che per cose meschine rovina intere vite."
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
    <b><color=\#81482e>Thovez</color></b>: "Sapevo che non dovevo fidarmi di voi."
    <b><color=\#81482e>Thovez</color></b>: "Fortuna sono sempre un passo avanti."
        * "Ma se sei nella camera da letto?"
        * "Dice l'uomo sul precipizio."
        * "Deve essere bello vivere nella tua testa."
        -
    <b><color=\#81482e>Thovez</color></b>: "Ridi pure, S.. Di sicuro non riderà Sir Isaac."
        * "A proposito dell'Isaac..."
        -
    <b><color=\#81482e>Thovez</color></b>: "Ora sarà in una bella cella, assieme ai suoi amici Mancuso, in attesa di un trasferimento coatto a Londra. Ti avevo detto di non prendermi in giro, S."
    
        * {not IsaacWin} "Non so di cosa parli, l'Isaac è a casa sua."
        
            <b><color=\#81482e>Thovez</color></b>: "Non serve che lo copri, S., so che stasera c'era una festa di pervertiti a casa dei Mancuso, e lui non ne perde mai una."
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Possiamo assicurarti che questa sera è a casa sua."
                ~ PersonaggioDx = "Thovez"
                <b><color=\#81482e>Thovez</color></b>: "Non è possibile."
                * * "Non ti piace sbagliare, vero?"
                    <b><color=\#81482e>Thovez</color></b>: "Non così, io..."
                    <b><color=\#81482e>Thovez</color></b>: "Dovete correre a casa, subito!"
                    * * * "Cosa stai blaterando, Philip?"
                    <b><color=\#81482e>Thovez</color></b>: "Ho fatto un errore, un errore madornale! Ho chiesto a un uomo fidato di bruciare casa vostra. Come monito, io..."
                    <b><color=\#81482e>Thovez</color></b>: "Ma se lo merita, no? È un invertito, e gli spetta l'inferno. Vero?"
                    ~ PersonaggioDx = "Catena"
                    <b><color=\#3a6954>Catena</color></b>: "Se stai scherzando, ricco di merda..."
                    ~ PersonaggioDx = "Thovez"
                        * * * * "Non stai scherzando, vero?"
                            <b><color=\#81482e>Thovez</color></b>: "No, dovete correre a fermare tutto questo, subito."
                            ~ PersonaggioDx = "Catena"
                            <b><color=\#3a6954>Catena</color></b>: " Ti fidi di lui?"
                            * * * * * "No. E per questo dobbiamo andare."
                                ~ PersonaggioDx = "Thovez"
                                <b><color=\#81482e>Thovez</color></b>: "Prendete i miei cavalli. Correte!"
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Non sarà questo gesto a salvarti la vita!"
                                ~ ThovezAiuta = true
                                * * * * * * [<b>Passa alla scena successiva</b>]"Andiamo vita mia. Te la farò pagare, Philip!"
                                ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                ~ caricaScena("CasaIsaacEsternoInFiamme")
	                            ~ caricaAtto("GiornoDueFinale")
	                            -> DONE
                                
                            * * * * * "Non ho detto di lasciarlo libero."
                            <b><color=\#81482e>Thovez</color></b>: "Ma vi sto aiutando!"
                            ~ PersonaggioDx = "Catena"
                            <b><color=\#3a6954>Catena</color></b>: "Sei stato tu a fare tutto questo, razza di cane."
                                * * * * * * "Così legato, non avrai modo di andare lontano."
                                    <b><color=\#3a6954>Catena</color></b>: "Lo faccio nascondere da Fatima?"
                                    * * * * * * * "No, consegnalo ai rivoltosi. Ci penseranno loro."
                                        ~ PersonaggioDx = "Thovez"
                                        <b><color=\#81482e>Thovez</color></b>: "Mi uccideranno! Non puoi farlo, non puoi farlo!"
                                        * * * * * * * * [<b>Passa alla scena successiva</b>]
                                    "Catè, ci vediamo fuori da casa di Isaac."
                                            ~ PersonaggioDx = "Catena"
                                            <b><color=\#3a6954>Catena</color></b>: "Sarò un fulmine, cuoricì"
                                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
            	                            ~ caricaAtto("GiornoDueFinale")
            	                            -> DONE
            	                            
                            * * * * * "No, e per questo la pagherà comunque."
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Allora dobbiamo correre, subito! Che ne facciamo di lui?"
                                * * * * * * "Dì alla Fatima di consegnarlo ai rivoltosi."
                                    ~ PersonaggioDx = "Thovez"
                                    <b><color=\#81482e>Thovez</color></b>: "Mi uccideranno! Non puoi farlo, non puoi farlo!"
                                        * * * * * * * [<b>Passa alla scena successiva</b>]"Sì che posso farlo, vigliacco."
                                    "Catè, ci vediamo fuori da casa di Isaac."
                                            ~ PersonaggioDx = "Catena"
                                            <b><color=\#3a6954>Catena</color></b>: "Sarò un fulmine, cuoricì."
                                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
            	                            ~ caricaAtto("GiornoDueFinale")
            	                            -> DONE
                                * * * * * * "Dì al Goran di portarlo da don Carlo.["] La polizia è corrotta, ma forse il vescovo può ascolarci. O ascoltare il preosto."
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "Ti fidi di un prete?"
                                    * * * * * * * [<b>Passa alla scena successiva</b>]"Mi fido della cosa più sensata da fare ora. Dobbiamo correre alla villa il prima possibile."
                                        <b><color=\#3a6954>Catena</color></b>: "Ci vediamo alla villa allora, cuoricì. Corri!"
                                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
            	                            ~ caricaAtto("GiornoDueFinale")
            	                            -> DONE
                                    
                                * * * * * * "Lo giustiziamo."
                                        ~ PersonaggioDx = "Thovez"
                                        <b><color=\#81482e>Thovez</color></b>: "No no no razza di farabutta, no!"
                                        ~ PersonaggioDx = "Catena"
                                        <b><color=\#3a6954>Catena</color></b>: "Vuoi che lo faccia io?"
                                        * * * * * * * "No, ci penso io."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoS = true
                                        * * * * * * * "Sii rapida, amore."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoCatena = true
                                        * * * * * * * "Lascia che la Fatima ci si diverta."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoFatima = true
                                        - - - - - - -
                                        * * * * * * * "Che la tua anima bruci in eterno, Philip!"
                                        - - - - - - -
                                        * * * * * * * [<b>Passa alla scena successiva</b>]"Corriamo a casa, vita mia!"
                                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
                	                        ~ caricaAtto("GiornoDueFinale")
            	                        -> DONE

        * {IsaacWin} "Non so di cosa parli."
        
            <b><color=\#81482e>Thovez</color></b>: "Poco mi importa. Domani Isaac sarà su una nave per Londra, dove la giustizia si occuperà di lui."
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Io ti uccido, Thovez!"
                ~ PersonaggioDx = "Thovez"
                <b><color=\#81482e>Thovez</color></b>: "Tieni a bada il tuo cane, S.!"
                    * *"Potrei sempre ammazzarti io, Thovez."
                        <b><color=\#81482e>Thovez</color></b>: "Non credo proprio. Gentaglia come te lascia sempre che siano gli altri a fare il lavoro sporco.
                    * *"Questo è il momento in cui chiedi qualcosa in cambio, vero?"
                        <b><color=\#81482e>Thovez</color></b>: "Oh no, S., la mia fiducia nei tuoi confronti è ufficialmente finita."
                    * * "Catena, respira. Così hai più energie per strozzarlo."
                    - -
            <b><color=\#81482e>Thovez</color></b>: "E non darti la pena di provare a salvarlo, S., anche perché non avrebbe una casa dove tornare."
                    * *"Cosa intendi dire?"
                    - -
                        <b><color=\#81482e>Thovez</color></b>: "Che gli incidenti capitano, soprattutto con un bel tetto di paglia e un po' di fuoco vicino."
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Infame! Schifoso infame!"
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Se inizi a correre, forse riesci ancora ad assistere al falò!"
                    * *"Catena, dobbiamo salvar l'Isaac, subito!"
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "No, cuoricì. Così ci faremmo arrestare anche noi, e non potremmo fare nulla."
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Il tuo cane non è così stupido, sembra."
                    - -
                    * * "Non possiamo non fare nulla."
                    - -
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Non ho detto questo. Domattina assaltiamo la prigione. Assieme ai rivoltosi."
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Come se ve lo lasciassi fare."
                        ~ PersonaggioDx = "Catena"
                        <b><color=\#3a6954>Catena</color></b>: "Come se potessi farci qualcosa. Cuoricì, che facciamo di questo infame?"
                            * * "Dì alla Fatima di consegnarlo ai rivoltosi."
                                ~ PersonaggioDx = "Thovez"
                                    <b><color=\#81482e>Thovez</color></b>: "Mi uccideranno! Non puoi farlo, non puoi farlo!"
                                        * * * [<b>Passa alla scena successiva</b>]"Sì che posso farlo, vigliacco."
                "Catè, ci vediamo fuori da casa di Isaac."
                                            ~ PersonaggioDx = "Catena"
                                            <b><color=\#3a6954>Catena</color></b>: "Sarò un fulmine, cuoricì"
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
            	                            ~ caricaAtto("GiornoDueFinale")
            	                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
            	                            -> DONE
            	                            
                            * * "Dì al Goran di portarlo da don Carlo.["] La polizia è corrotta, ma forse il vescovo può ascolarci. O ascoltare don Carlo."
                                ~ PersonaggioDx = "Catena"
                                <b><color=\#3a6954>Catena</color></b>: "Ti fidi di un prete?"
                                * *  * [<b>Passa alla scena successiva</b>] "Mi fido della cosa più sensata da fare ora. Dobbiamo correre alla villa il prima possibile."
                                    <b><color=\#3a6954>Catena</color></b>: "Ci vediamo alla villa allora, cuoricì. Corri!"
                                        ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                        ~ caricaScena("CasaIsaacEsternoInFiamme")
        	                            ~ caricaAtto("GiornoDueFinale")
        	                            -> DONE
                                            
                            * * "Lo giustiziamo."
                                    ~ PersonaggioDx = "Thovez"
                                    <b><color=\#81482e>Thovez</color></b>: "No no no razza di farabutta, no!"
                                    ~ PersonaggioDx = "Catena"
                                    <b><color=\#3a6954>Catena</color></b>: "Vuoi che lo faccia io?"
                                        * * *"No, ci penso io."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoS = true
                                        * * * "Sii rapida, amore."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoCatena = true
                                        * * * "Lascia che la Fatima si diverta."
                                            ~ ThovezCasaThovezCameraDaLetto = false
                                            ~ ThovezUccisoFatima = true
                                        - - -
                                        * * * "Che la tua anima bruci in eterno, Thovez!"
                        
                                        -
                                        * * *[<b>"Corriamo a casa, Catè!"</b>]
                                            ~ Dialog_CatenaCasaThovezCameraDaLetto_Step += 1
                                            ~ caricaScena("CasaIsaacEsternoInFiamme")
                	                        ~ caricaAtto("GiornoDueFinale")
            	                        -> DONE   
            

