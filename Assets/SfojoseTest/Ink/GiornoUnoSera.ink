/* ---------------------------------

   PRIMA PARTE: ARRIVO A CASA DI THOVEZ

 ----------------------------------*/

/** CATENA **/
=== Dialog_CatenaCasaThovezStanzaFeste
{
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 0) && not ingresso: -> ingresso
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 0) && ingresso: -> fallbackCatena
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 1) && (Dialog_AmministratoreCasaThovezStanzaFeste || Dialog_HelenCasaThovezStanzaFeste || GiuseppeCasaThovezStanzaFeste): -> biblioteca
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 1): -> DopoLePresentazioni
}

//Questa parte dipende totalmente dalla presenza o meno di Catena alla serata. Di conseguenza non deve contenere elementi utili dopo.

    = ingresso
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
        <b><color=\#3a6954>Catena</color></b>: "Cuoricì, sarò pure una poveraccia, ma questa roba è pacchiana, vero?"
            * "Mi ricorda la stanza di quel capitano inglese[."], quello che c'aveva messo tutta quella roba leopardata e le statue dei s'cèti dipinte a mano."
                <b><color=\#3a6954>Catena</color></b>: "Mmm, va bene, forse qui non è così pacchiana."
            * "Però quel tavolo ci starebbe bene nelle cucine, non trovi?"
                <b><color=\#3a6954>Catena</color></b>: "Così poi Goran ci rompe con la sua crociata alle ostentazioni!"
            * "Da quanto è che non ti vedi il laboratorio dell'Isaac?"
                <b><color=\#3a6954>Catena</color></b>: "Ma il nostro bimbo può, glielo perdoniamo."
        -
        <b><color=\#3a6954>Catena</color></b>: "Comunque non vedo in giro gente armata, solo vecchi babbioni."
            * "Guarda che qui son tutti più giùen, vita mia!"
            <b><color=\#3a6954>Catena</color></b>: "Appunto!"
                * * "Stasera ti ci torni a letto da sola."
                    <b><color=\#3a6954>Catena</color></b>: "Ma fa freddo, cuoricì!"
                * * "Parla quella che c'ha ancora i denti da latte."
                    <b><color=\#3a6954>Catena</color></b>: "Ecco perché voglio sempre le tue zinne."
                * * "Laggiù però c'è una ragazzina."
                    <b><color=\#3a6954>Catena</color></b>: "Credo sia una delle figlie del Thovez."
            - 
        <b><color=\#3a6954>Catena</color></b>: "Ed ecco che arriva il simpatico padrone di casa."
            * "Vado a parlargli."
                <b><color=\#3a6954>Catena</color></b>: "{~ Fammi un cenno e lo prendo a botte!| La fortuna buona ce la dà il mio spadino, cuoricì!|E puzza più di Vituzzo!|Per chi mi hai presa, scusa?}"
    
        -> DONE
        
    = fallbackCatena
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
        <b><color=\#3a6954>Catena</color></b>: "{~Son nervosa come le api stasera.|Ma hai visto quella bambina? Ha un faccino così gentile, impossibile che sia figlia di Thovez.|Ma chi è quel tizio all'angolo che osserva tutti con sospetto?|Mmm, sento profumo di pesce. Quanto mi manca il mare!}"
    
    -> DONE
    
    = DopoLePresentazioni
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
        <b><color=\#3a6954>Catena</color></b>: {"Studiati la situazione, cuoricì!"|"Sembra che Thovez ha un amante."|"L'amministratore è suo fratello, ma lo tratta come un animale"|"Dici che qualche posata me la posso cacciare nelle tasche?"|"Che gruppo di tamarri."|"Secondo me la figlia di Thovez prega sempre perché schiatti."}
        
        -> DONE
    
    
    =biblioteca
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        
        <b><color=\#3a6954>Catena</color></b>: "Che ne dici se ci isoliamo un po' la' tra i libri?"
        + "Mi guardo ancora un poco in giro." -> DONE
        + [<b>Ti sposti in biblioteca</b>]"Ottima idea."
        	~ caricaScena("CasaThovezBiblioteca")
        -
    -> DONE




/** THOVEZ **/
=== Dialog_ThovezCasaThovezStanzaFeste
~ ThovezCasaThovezBiblioteca = false
{
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 0): -> ingresso
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 1) && (Dialog_AmministratoreCasaThovezStanzaFeste || Dialog_HelenCasaThovezStanzaFeste || GiuseppeCasaThovezStanzaFeste): -> biblioteca
- (Dialog_ThovezCasaThovezStanzaFeste_Step == 1): -> DopoLePresentazioni
}

    = ingresso
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S. Narrante</color></b>: "C'è gente che decide di influenzare la tua vita anche se non vuoi, anche se la vuoi lontana. Come il maledetto Philip Thovez."
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
    <b><color=\#81482e>Thovez</color></b>: "Ma dove si è cacciato quell'incompetente di Torrisi? E vuole farsi chiamare capo delle guardie!"
    <b><color=\#81482e>Thovez</color></b>: "Ma guarda chi ci rallegra con la sua nobile presenza: Lady S.! Mi addolora sapere che Lord Isaac non riuscirà a raggiungerci questa sera."
        {CatenaWin:
        <b><color=\#81482e>Thovez</color></b>: "Ma vedo che non avete avuto problemi a trovare un accompagnamento altrettanto... peculiare."
        }
        
       * "Come me la perdo una serata con il meglio di Bronte?["] Di cosa vuoi parlarmi, Philip?"
            <b><color=\#81482e>Thovez</color></b>: "Di affari, milady. Lucrosi per voi e per me. Datemi il tempo di fare da buon padrone di casa e vediamoci in biblioteca tra mezz'ora."
       * "Non è da me starmene buono davanti a una minaccia, Philip."
            <b><color=\#81482e>Thovez</color></b>: "Diretta come sempre, vedo. E sia. Voglio parlare di affari. Datemi il tempo di fare da buon padrone di casa e vediamoci in biblioteca tra mezz'ora."
       * "Sono sicuro che l'Isaac si sta comunque divertendo.["] Magari con vostro fratello."
            <b><color=\#81482e>Thovez</color></b>: "Non apprezzo queste insinuazioni, milady. E Henry è qui con me, come sempre."
            <b><color=\#81482e>Thovez</color></b>: "Comunque: datemi una mezz'ora, il tempo di salutare tutti gli ospiti importanti di questa serata. Troviamoci poi in biblioteca."
       -
        * "Va bene, mi farò due chiacchiere coi tuoi ospiti."
            <b><color=\#81482e>Thovez</color></b>: "Non mi metta in cattiva luce, milady."
        * "Credo mi riempirò la pancia."
            <b><color=\#81482e>Thovez</color></b>: "Spero che un palato fine come il suo possa gradire la nostra ricercata cucina."
        * "Non farmi aspettare troppo, Thovez.["] Non sono famoso per la pazienza."
            <b><color=\#81482e>Thovez</color></b>: "Potreste cominciare dandomi del Lei, con il diritto che mi spetta per il mio rango."
                * * "Come vuole, Philip."
                * * "Non sapevo di essere a corte."
                * * "Quando inizi a darmi del lui, Philip."
            <b><color=\#81482e>Thovez</color></b>: "Sei un personaggio faticoso, S. Davvero faticoso."
        -    
    ~ Dialog_ThovezCasaThovezStanzaFeste_Step += 1
    -> DONE
    

    
    = DopoLePresentazioni
    ~ PersonaggioSx = "Thovez"
    ~ PersonaggioDx = ""
    
    <b><color=\#81482e>Thovez</color></b>: "{~ Non vede che sto parlando?|Perché don Gianni non si è presentato?"|"Non riesco a trovare il vescovo.|Il divano è sgualcito. Mia madre è davvero un'incapace.|Henry sta parlando troppo con quel paggio.|Questa casa è un vero gioiello, grazie al mio buongusto.|Che onore essere la voce e la mano del duca Nelson!|Ci sono troppi movimenti nel bosco, non mi piacciono!|Spero che Torrisi non mi faccia fare una cattiva figura col vescovo.}"
    
    -> DONE
    
    = biblioteca
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
    
    <b><color=\#81482e>Thovez</color></b>: "{~Aspettami in biblioteca, S.|Guarda che i libri non ti mangiano.|Ho bisogno ancora di qualche minuto, devo trovare il capogendarme.|Questo salotto non è adatto a una persona del tuo lignaggio, S.|{CatenaWin:La sua compagna ha uno sguardo minaccioso.|Mia figlia doveva essere a letto, perché non mi ubbidisce?}}"
        + "Mi faccio ancora una girata, Philip." -> DONE
        + [<b>Ti sposti in biblioteca</b>]"Capita l'antifona, ci vediamo in biblioteca."
        	~ caricaScena("CasaThovezBiblioteca")
        -> DONE



/** AMMINISTRATORE **/
=== Dialog_AmministratoreCasaThovezStanzaFeste
{
- Dialog_ThovezCasaThovezStanzaFeste_Step == 0: -> ingresso
- Dialog_ThovezCasaThovezStanzaFeste_Step == 1 && not DopoLePresentazioni: -> DopoLePresentazioni
- else: -> biblioteca
}


    = ingresso
    ~ PersonaggioSx = "Amministratore"
    ~ PersonaggioDx = ""
        <b><color=\#6F6510>Henry</color></b>: {~"Chiedo scusa, ma non è un buon momento."|"Philip stasera è più nervoso del solito!" |"Dove si è cacciato Smith? Deve spiegargli la questione delle radici!"|"Quanto vorrei essere altrove."|"Spero che qualcuno lo faccia ragionare, si sta mettendo il paese contro."|"Smith non è così male, ci tiene a quelle piante."|"Quanto vorrei andare a vivere a Londra."|"Chissà come se la sta passando Isaac."|"A quest'ora dovevo essere a vedere lo Sgricci, maledetto Philip!"|"Questa casa è tremenda. Philip dovrebbe lasciare la gestione a nostra madre."}
    
    
    -> DONE
    
    = DopoLePresentazioni
    ~ PersonaggioSx = "Amministratore"
    ~ PersonaggioDx = "Thovez"
    
        <b><color=\#81482e>Thovez</color></b>: "Henry, eccoti. Temevo che mi steste evitando! Qual'è la situazione dei vigneti?"
        <b><color=\#6F6510>Henry</color></b>: "Beh, ecco... Non buonissima. L'idea di quello smidollato di Smith di arare tra le viti ha fatto più danni che altro."
        <b><color=\#81482e>Thovez</color></b>: "Su col morale, fratello. Non appena avrò risolto la quisquilia dei boschi potremo finalmente sradicare tutti quegli inutili alberi ed estendere i vigneti, e allora sì che inizieremo a produrre!"
        <b><color=\#81482e>Thovez</color></b>: "Avvocato Giuffrida, ma che piacere! Henry, continuiamo dopo."
    -> DONE    
  
    
    =biblioteca
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Amministratore"
    
    <b><color=\#6F6510>Henry</color></b>: "{Non fare aspettare mio fratello, S. Philip è un uomo impaziente.|Sapevi che la nostra biblioteca ha libri rarissimi?|Peccato che col lavoro da fare, sia impossibile leggere tutti quei libri.|Ho prestato diversi volumi ad Isaac, ha davvero buongusto.|Philip vuole buttare dei volumi del deSade, li trova blasfemi.|Ma la blasfemia è l'unica cosa divertente in questo buco.|Potrei dare fondo alla riserva di vino stasera. Non il nostro, è tremendo.}"
        + "Infastidire Philip l'è una piccola gioia, Henry."-> DONE
        * [<b>Ti sposti in biblioteca</b>]"Capita l'antifona, ci vediamo in biblioteca."
        	~ caricaScena("CasaThovezBiblioteca")
        -
    -> DONE



/** HELEN **/

=== Dialog_HelenCasaThovezStanzaFeste
{Dialog_ThovezCasaThovezStanzaFeste_Step:
- 0: -> ingresso
- 1 && DopoLePresentazioni: -> biblioteca
- 1: -> DopoLePresentazioni
}


    = ingresso
    ~ PersonaggioSx = "Helen"
    ~ PersonaggioDx = ""
    
    <b><color=\#ACEAF8>Helen</color></b>: "{Ciao! Io sono Helen, ho cinque anni una bambola e una panchina. Sembri interessante, ma hai un naso strano.|Conosci il mio papà? È il padrone di casa|Non ti ho mai visto alle altre feste.|Hai visto dei bambini? Qui son tutti vecchi!}""
     ->DONE
    
    = DopoLePresentazioni
    <b><color=\#ACEAF8>Helen</color></b>: "{Che noiaaaaaaaaaaaaaaaaaa!|Papà preferisce sempre i vecchi ai disegni, ma sono belli i miei disegni!|Ma se sei un pirata dov'è la gamba di legno e la bandana?|Odio questo vestito, mi sembra di essere una bambola di porcellana!|Uffaaa, voglio andare viaaaaa!}"

    -> DONE


    
    =biblioteca
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Helen"
    
    <b><color=\#ACEAF8>Helen</color></b>: "{La biblioteca è enorme, c'è persino una testa di lelefante!|Se sto zitta e mi metto dietro la scala nessuno mi vede.|Una volta ho fatto uno scherzo a nonna ed è caduta dalla scala.|Papà mi ha sgridato, ma poi ha detto che la prossima volta devo farlo più forte.|Mi porti in biblioteca?}"
        + "Ciao Helen, vado a fare due passi."  -> DONE
        * [<b>Ti sposti in biblioteca</b>]"Si è fatta l'ora. Alla biblioteca!"
            	~ caricaScena("CasaThovezBiblioteca")
        -
        -> DONE


/** GIUSEPPE **/

=== Dialog_GiuseppeCasaThovezStanzaFeste

{Dialog_ThovezCasaThovezStanzaFeste_Step:
- 0: -> ingresso
- 1 && DopoLePresentazioni: -> biblioteca
- 1: -> DopoLePresentazioni
}


    = ingresso
    ~ PersonaggioSx = "Giuseppe"
    ~ PersonaggioDx = ""
    
        <b><color=\#D42525>Giuseppe</color></b>: "{Come va, S.?|A vedere qui dentro non sembra neanche che tutta l'isola sia pronta a una rivolta.|Come sta Goran?|Sto quasi tutto il tempo a Catania, ma è bello tornare in paese.}"
    
    -> DONE
    
    = DopoLePresentazioni

    ~ PersonaggioSx = "Giuseppe"
    ~ PersonaggioDx = ""
    
    <b><color=\#D42525>Giuseppe</color></b>: "{Ogni tanto organizzo delle piccole riunioni dove si parla di, insomma, sai di cosa.|Thovez non lascia in pace mio fratello Rosario. Vuole che distrugga in tribunale il comitato civico per i diritti sul legname.|L'unica cosa che posso fare è temporeggiare in attesa che la situazione cambi.|Coi soldati catanesi in paese? Speriamo che vadano via presto.|Ti aspetto alle riunioni, S.}"

    
    -> DONE
    
    
    =biblioteca
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Giuseppe"
    
    <b><color=\#D42525>Giuseppe</color></b>: "{Quella Helen è una strana bambina. Ha sempre la testa tra le nuvole|Certo che Thovez è proprio ossessionato dall'ammiraglio Nelson. Questa casa sembra un museo!|{CatenaWin:Perdonatemi la sfacciataggine, ma potrei sapere il nome di quell'affascinante donna che vi accompagna?|Madre Thovez è il più severo generale che abbia mai visto.}|Avete assaggiato questo vino? È disgustoso!}"
        + "Ho qualcuno con cui parlare, Giuseppe. A dopo." -> DONE
        + [<b>Ti sposti in biblioteca</b>]"Grazie della compagnia, ma adesso ho appuntamento col Thovez. A presto!"
        	~ caricaScena("CasaThovezBiblioteca")
        -
    -> DONE


/* ---------------------------------

   SECONDA PARTE: BIBLIOTECA 

 ----------------------------------*/




/* ---------------------------------

                CRISTINA
            
 ----------------------------------*/
-> Dialog_CristinaCasaThovezBiblioteca

=== Dialog_CristinaCasaThovezBiblioteca
{Dialog_CristinaCasaThovezBiblioteca_Step:
- 0: -> PrimaDellaPartita
- 1: -> DopoLaPartita
- 0 && PrimaDellaPartita: -> Rifiuto
}

    = PrimaDellaPartita
    
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S. Narrante</color></b>: "E quando pensi che il passato sia definitivamente chiuso..."
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    <b><color=\#6d282a>Cristina</color></b>: "S.? Sei davvero tu?"
        * (affetto) "Cristina, dio, quanto tempo! Cosa ci fai qui?"
        * "Cristina?"
        * (disprezzo) "Ah, ti sei ancora viva?"
        -
    <b><color=\#6d282a>Cristina</color></b>: "{not disprezzo: Sì. Io...oh, è così bello rivederti, S.!|Mi aspettavo un'accoglienza diversa. Ma forse me lo merito.}"
    {CatenaWin:
    ~ PersonaggioDx = "Catena"
    }
    {CatenaWin:
    <b><color=\#3a6954>Catena</color></b>: "Quella Cristina? Quella che ti ha smollato a Napoli?"
    }
    {CatenaWin:
    <b><color=\#3a6954>Catena</color></b>: "Dopo tutto quello che hai fatto per lei?"
    }
    ~ PersonaggioDx = "Cristina"
    <b><color=\#6d282a>Cristina</color></b>: "Oh..."
    <b><color=\#6d282a>Cristina</color></b>: {CatenaWin: "È così che parli di me? E io che ben speravo di aver trovato un volto amico."|"Avevo così bisogno di vedere un volto amico."}
    * "Un volto amico?"
        <b><color=\#6d282a>Cristina</color></b>: "Hai ragione, di certo non merito la tua amicizia."
        * * {not disprezzo} "No no, oh, madóna mé.["] Perché sei qui che dici che non ci sono le persone fidate?"
        * * {disprezzo} ["Dopo quello che mi hai fatto..."]"Va a fas benedì! Non meriti niente da me." -> Rifiuto
        * * {disprezzo} [Prendi un grosso respiro.] "No ma possiamo essere civili. Come vanno le cose, ora?"
        - -
    * {not disprezzo}"Cristina, io, io ..["] Cazzo, sembro un pappagallo. E' bello rivederti, credo."
        <b><color=\#6d282a>Cristina</color></b>: "Credi?"
            * * "Pota, non ci siamo manco dette addio[."]. Anzi, tu non l'hai fatto."
            <b><color=\#6d282a>Cristina</color></b>: "Forse è stato uno sbaglio venire a salutarti."
                * * * "No, io...["] Scusa. Non ti aspettavo qui, non ero pronto."
                    {CatenaWin:
                    ~ PersonaggioDx = "Catena"
                    }
                    {CatenaWin:
                    <b><color=\#3a6954>Catena</color></b>: "Scusa? Le chiedi pure scusa?"
                    }
                    ~ PersonaggioDx = "Cristina"
                    {CatenaWin: 
                    <b><color=\#6d282a>Cristina</color></b>: "La tua amica ha ragione, non ti devi scusare. Ma sono così felice che tu sia qui!"
                    }
        * * "Ti aspettavi mica delle feste[?"] dopo tutto quello che è accaduto, vero?"
        -> Rifiuto
    * {not disprezzo}"Dio, sei ancora più bella!["] Scusa, è fuori luogo ma cazzo, sei bellissima!"
        <b><color=\#6d282a>Cristina</color></b>: "E tu sei ancora più sfacciata. E non hai perso lo sguardo furbetto da våulp."
        * * "Da volpe?["] Chi è che è vestita come una regina e chi con gli avanzi dell'Isaac?"
        <b><color=\#6d282a>Cristina</color></b>: "Non dovresti parlare di cose che non capisci."
        * * * "Cosa non capisco?"
    * {disprezzo}"Mi fidavo di te e sei sparita[."] Mi hai lasciato davanti a cose orribili, da solo."
        "Avevamo progetti e idee e tu sei scappata senza fidarti di me."
        <b><color=\#6d282a>Cristina</color></b>: "S., io... Hai ragione, scusa. Ma non conoscevo niente del mondo se non Iddio, e avevo paura."
        * * "Paura de che?"
            <b><color=\#6d282a>Cristina</color></b>: "Di passare dalle prigioni del convento a quelle di un matrimonio."
            * * * "Se la metti così, non c'ho più niente da dirti, Cristina."
            -> Rifiuto
            * * * "Non ti ci volevo obbligare a fare nulla io."
                <b><color=\#6d282a>Cristina</color></b>: "L'ho capito, anni dopo. All'epoca ero solo spaventata. Ora sono una donna diversa."
                * * * * "Che donna sei?"
            * * * "Uh."
                "Non l'avevo mai vista in questo modo."
                <b><color=\#6d282a>Cristina</color></b>: "Ero giovane, piena di voglia di vita. Tu eri così innamorata, ma io..."
                * * * * "Volevi solo vederti libera."
                <b><color=\#6d282a>Cristina</color></b>: "Mi spiace, S. Ora te l'avrei detto in faccia. Ma all'epoca ero un altro tipo di persona."
                * * * * * "E ora, che tipo di persona sei?"
        
    * {disprezzo} ["Il tempo lenisce le ferite."] "Sono passati anni. Sono accadute un sacco di cose. Forse posso anche perdonarti."
        <b><color=\#6d282a>Cristina</color></b>: "Ne sarei così felice, S., mi sei mancata."
        * * "Cosa ci fai qui?"
    -
   
    
    <b><color=\#6d282a>Cristina</color></b>: "Non è il posto migliore in cui parlare, ma. Ma mi sono messa nei pasticci, S."
        * {not disprezzo}"Che genere di pasticci?"
        * {disprezzo} "Quindi c'hai bisogno del mio aiuto."
            {CatenaWin:
            ~ PersonaggioDx = "Catena"
            }
            {CatenaWin:
            <b><color=\#3a6954>Catena</color></b>: "Che facciola!"
            }
            ~ PersonaggioDx = "Cristina"
            <b><color=\#6d282a>Cristina</color></b>: "Solo di un'amica con cui parlare."
        * "Come ai vecchi tempi?"    
        -
    <b><color=\#6d282a>Cristina</color></b>: "Il padrone di casa, l'uomo laggiù..."
        * "Il Thovez?"
        -
    <b><color=\#6d282a>Cristina</color></b>: "Sì. Sì, lui. Pensavo mi sarei trovata libera, con lui. Non sai quante cose sono successe dopo che sono scappata."
    <b><color=\#6d282a>Cristina</color></b>: "E lui mi ha promesso la libertà che cercavo. È stato così convincente. E..."
        * {not disprezzo}"Anche io te l'avevo promessa, ricordi?"
            <b><color=\#6d282a>Cristina</color></b>: "Non ora, S., ti prego, non ora."
            * * "E quando, allora?"
                <b><color=\#6d282a>Cristina</color></b>: "Sono stata una sciocca."
                -> Rifiuto
            * * (promessa) "Promettimi che ne parliamo."
                <b><color=\#6d282a>Cristina</color></b>: "Te lo prometto."
        * {disprezzo} "Ti ascolto."
        -
    <b><color=\#6d282a>Cristina</color></b>: "Ora di fatto sono la sua schiava. Sono la sua amante, che vuol dire devo stare ai suoi ordini."
    <b><color=\#6d282a>Cristina</color></b>: "Essere dove vuole che io sia quando vuole. Vestirmi come desidera. Odio questo vestito, questi capelli, questi gioielli!"
        * "Ma perché resti?"
        -
    <b><color=\#6d282a>Cristina</color></b>: "E dove andrei, S.? Alla mia età, non sposata, incapace di fare qualsiasi cosa. Che futuro posso avere?"
        * "Unisciti alla nostra nave[."] Scegli assieme alla ciurma come e perché. Anche di andartene quando vuoi. Magari salutandomi a questo giro."
                {CatenaWin: 
                ~ PersonaggioDx = "Catena"
                }
                {CatenaWin:
                <b><color=\#3a6954>Catena</color></b>: "Non impari mai, vero?"
                }
                ~ Dialog_CristinaCasaThovezBiblioteca_Step += 1
                ~ caricaPartita("Cristina")
                @
        * "Sai fare un sacco di cose, Cristina!["] Hai cambiato città, vita, tutto!"
            <b><color=\#6d282a>Cristina</color></b>: "E cosa posso fare di tutte queste cose, S.? Sinceramente?"
            * * "Puoi unirti alla ciurma.["] Viaggiare, vedere nuovi mondi. E mica con qualcuno che ti dice come vestirti."
                ~ Dialog_CristinaCasaThovezBiblioteca_Step += 1
                ~ caricaPartita("Cristina")
                @
            * * "Ti sei arresa.["] Ma se vuoi che nessuno decide di nuovo per te, è il caso che inizi ora a prendere le tue decisioni."
                <b><color=\#6d282a>Cristina</color></b>: "Ho paura, S."
                * * * "Non posso fare questo lavoro per te, Cristina."
                -> Rifiuto
                * * * "Pota, provaci. Cosa c'hai da perdere?"
                ~ Dialog_CristinaCasaThovezBiblioteca_Step += 1
                ~ caricaPartita("Cristina")
                @
        * "L'alternativa è restare?["] Stare qui, infelice, ad essere usata da quest'òm?"
            <b><color=\#6d282a>Cristina</color></b>: "Almeno è un male che conosco."
            * * "Allora non ci posso fare nulla per te."
            -> Rifiuto
        -
        
    -> DopoLaPartita
    
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
    
        {
        - CristinaWin: 
        ~ CristinaCasaIsaacInterno = false
        ~ CristinaCasaThovezAmministrazione = false
        ~ CristinaCasaThovezCameraDaLetto = false
        ~ CristinaCasaIsaacEsternoInFiamme = false
        
        - !CristinaWin: 
        ~ CristinaCasaIsaacInterno = true
        ~ CristinaCasaThovezAmministrazione = true
        ~ CristinaCasaThovezCameraDaLetto = true
        ~ CristinaCasaIsaacEsternoInFiamme = true
        }

        
        <b><color=\#6d282a>Cristina</color></b>: "Mi ero dimenticata cosa significasse discutere con te."
        {CristinaWin: 
        <b><color=\#6d282a>Cristina</color></b>: "Ma non verrò, S., mi spiace."
        }
        * {CristinaWin} "Mi arrendo."
            <b><color=\#6d282a>Cristina</color></b>: "Resto qui, ma grazie per averci provato, davvero."
             * * "Salpiamo tra tre giorni.["] Se cambi idea, siamo all'osteria."
             <b><color=\#6d282a>Cristina</color></b>: "Sei sempre nel mio cuore, S. Sempre."
             ~ CristinaCasaThovezBiblioteca = false
             ~ CristinaCasaIsaacEsternoInFiamme = false
             ~ ThovezCasaThovezBiblioteca = true
        * {not CristinaWin} ["Come ti senti?"]"La a bé, Cristina?"
            <b><color=\#6d282a>Cristina</color></b>: "Come se stessi facendo un errore, il migliore della mia vita."
            * * "O stai riparando a quando mi hai mollata."
            <b><color=\#6d282a>Cristina</color></b>: "Non lascerai andare quest'osso, vero?"
                * * * "Forse."
                    * * * * "Il Thovez si sta avvicinando.["] Separiamoci. Ci troviamo domattina a casa dall'Isaac. Sai dove si trova, vero?"
                        <b><color=\#6d282a>Cristina</color></b>: "Sì, abbiamo avuto qualche scambio in passato."
                            * * * * * "Ottimo. Vienici la mattina presto. E Cristina?"
                            <b><color=\#6d282a>Cristina</color></b>: "Sto attenda, lo so."
                                * * * * * * "Non mi sparire mica di nuovo, capito?"
                                    <b><color=\#6d282a>Cristina</color></b>: "Non lo farò, promesso. A domattina."
                                    ~ CristinaCasaThovezBiblioteca = false
                                    ~ ThovezCasaThovezBiblioteca = true
                                    {CatenaWin:
                                    ~ PersonaggioDx = "Catena"
                                    }
                                    {CatenaWin:
                                    <b><color=\#3a6954>Catena</color></b>: "Sei idiota cuoricì, lo sai vero?"
                                    }
        -
        
        
    -> DONE
    
    = Rifiuto
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
    <b><color=\#6d282a>Cristina</color></b>: "Io... Forse mi aspettavo qualcosa di diverso, non lo so."
        * "Cosa ti aspettavi?"
        * "Da me, intendi?"
        * "Su quali basi?"
        * {disprezzo} ["Mi hai preso per stupido?"]"Non c'ho mica un servel de poia!"
        -
    {disprezzo:
    <b><color=\#6d282a>Cristina</color></b>: "Sei crudele."
    } 
    <b><color=\#6d282a>Cristina</color></b>: "Pensavo che la nostra amicizia, che, che quello che c'è stato ti avrebbe spinto ad aiutarmi. Scusa, è che sono disperata e non so cosa fare."
        * ["Basta!"] "Non c'ho soluzioni facili. Mi spiace. Voglio dirtelo di venire con noi sulla nave. Ma la nave è un mondo a sé, che funziona se chi ci sta vuole esserci. Non è un luogo dove fuggire, ma da cui ricominciare. Tu vuoi ricominciare?"
            <b><color=\#6d282a>Cristina</color></b>: "Sì. Ma forse non so da dove iniziare. Scusa. Sono sicura che ci ritroveremo di nuovo."
            ~ CristinaWin = true
            ~ CristinaCasaIsaacInterno = false
            ~ CristinaCasaThovezAmministrazione = false
            ~ CristinaCasaThovezCameraDaLetto = false
            ~ CristinaCasaThovezBiblioteca = false
            ~ CristinaCasaIsaacEsternoInFiamme = false
            ~ ThovezCasaThovezBiblioteca = true
            ~ Dialog_CristinaCasaThovezBiblioteca_Step += 1
        {CatenaWin:
            ~ PersonaggioDx = "Catena"
        }
        {CatenaWin:
        <b><color=\#3a6954>Catena</color></b>: "Hai schivato una bomba, amore."
        }
        {CatenaWin:
        <b><color=\#3a6954>Catena</color></b>: "Ma sta arrivando Thovez, una bomba peggiore."
        }
        {not CatenaWin:
        ~ PersonaggioDx = "Cristina"
        }
        {not CatenaWin:
        <b><color=\#6d282a>Cristina</color></b>: "Ti lascio con Thovez. Immagino non siate così diversi, voi due."
        }
        * ["Vieni con noi!"] "Unisciti a noi, ascolta l'S.! Puoi scegliere finalmente per te. E riguardo a noi, ripartire da zero."
            "Non dare nulla per scontato. Non darmi per scontato. Vuoi provarci?"
            ~ ThovezCasaThovezBiblioteca = true
            ~ Dialog_CristinaCasaThovezBiblioteca_Step += 1
            ~ caricaPartita("Cristina")
            @
            -> DopoLaPartita
        -
    -> DONE
    
    

//PARTITA CON CRISTINA

=== Partita_Cristina_Chiacchiera ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
    <b><color=\#354174>S.</color></b>: "Nel mare saresti libera."
    <b><color=\#6d282a>Cristina</color></b>: "Ma cosa so fare, S.?"
    <b><color=\#354174>S.</color></b>: "Pochi di noi sapevano fare qualcosa, eppure ora siamo leggendari."
    <b><color=\#6d282a>Cristina</color></b>: "E temuti."
    <b><color=\#354174>S.</color></b>: "C'hai paura di noi?"
    <b><color=\#6d282a>Cristina</color></b>: "No, S., ho paura di fidarmi di qualcuno. Di farmi ancora del male."
    <b><color=\#354174>S.</color></b>: "Possono farti del male solo se lo vuoi."
    <b><color=\#6d282a>Cristina</color></b>: "Non lo voglio più, S. Più."
    
    -> DONE

=== Partita_Cristina_Seduzione ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
    <b><color=\#354174>S.</color></b>: "Pensa alla bellezza di ciò che ti aspetta."
    <b><color=\#6d282a>Cristina</color></b>: "Alla bellezza di stare con te?"
    <b><color=\#354174>S.</color></b>: "No, questo no. Possiamo ricominciare, ma se vieni vieni per te, punto."
    <b><color=\#6d282a>Cristina</color></b>: "Ho pensato spesso al tuo corpo, S. Alle cose che mi hai insegnato."
    <b><color=\#354174>S.</color></b>: "Sono passate tante vite, Cristina."
    <b><color=\#6d282a>Cristina</color></b>: "Ma alcune cose son sicura che non siano cambiate."
    <b><color=\#354174>S.</color></b>: "Ti sto offrendo una marea di possibilità, non ti ci fissare su una, Cristo!"
    <b><color=\#6d282a>Cristina</color></b>: "La ami tanto, vero?"
    <b><color=\#354174>S.</color></b>: "Catena e l'Isaac sono quanto ho di più caro."
    <b><color=\#6d282a>Cristina</color></b>: "Forse un giorno mi meriterò anche io il tuo amore, di nuovo."
    
    
    -> DONE

=== Partita_Cristina_Zuffa ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
    <b><color=\#354174>S.</color></b>: "Il mondo non ce l'ha con te, Cristina!"
    <b><color=\#6d282a>Cristina</color></b>: "Thovez..."
    <b><color=\#354174>S.</color></b>: "Thovez è un essere umano, e quindi battibile."
    <b><color=\#6d282a>Cristina</color></b>: "Anche tu, S."
    <b><color=\#354174>S.</color></b>: "Non negli ultimi cinquant'anni. Abbassa gli scudi, Cristina."
    <b><color=\#6d282a>Cristina</color></b>: "E se ti stanchi di me?"
    <b><color=\#354174>S.</color></b>: "Non ti sto invitando a sposarmi. Ho già chi mi ama sinceramente."
    <b><color=\#6d282a>Cristina</color></b>: "Pensi che non sia sincera?"
    <b><color=\#354174>S.</color></b>: "Penso che tu debba ripartire da capo, ma davvero questa volta."
    <b><color=\#6d282a>Cristina</color></b>: "È una bella frase, S., una bella immagine."
    <b><color=\#354174>S.</color></b>: "Lascia che divenga realtà."
    <b><color=\#6d282a>Cristina</color></b>: "Ho lasciato Dio, ora lascio la società."
    <b><color=\#354174>S.</color></b>: "E trovi te stessa."
    <b><color=\#6d282a>Cristina</color></b>: "Me stessa..."
    -> DONE

/* ---------------------------------

                CATENA

 ----------------------------------*/


=== Dialog_CatenaCasaThovezBiblioteca
{
- Dialog_CristinaCasaThovezBiblioteca_Step == 0 && not Dialog_ThovezCasaThovezBiblioteca_Step: -> PrimaDellaPartitaCristina

- Dialog_CristinaCasaThovezBiblioteca_Step == 1 && not Dialog_ThovezCasaThovezBiblioteca_Step && not DopoLaPartitaCristina: -> DopoLaPartitaCristina

- Dialog_CristinaCasaThovezBiblioteca_Step == 1 && not Dialog_ThovezCasaThovezBiblioteca_Step && DopoLaPartitaCristina: -> PrimaDellaPartitaThovez

- Dialog_ThovezCasaThovezBiblioteca_Step == 0: -> PrimaDellaPartitaThovez

- Dialog_ThovezCasaThovezBiblioteca_Step == 1: -> DopoLaPartitaThovez
}

= PrimaDellaPartitaCristina
~ PersonaggioSx = "Catena"
~ PersonaggioDx = ""
    <b><color=\#3a6954>Catena</color></b>: {"Ci sono più libri che alla comunale di Palermo!"| "Secondo te Thovez li lesse davvero tutti questi libri?" | "Mi sa che mi intasco qualcosa per il prossimo viaggio."| "C'è il libro del Beccaria! Questo me lo prendo."}

-> DONE

    = DopoLaPartitaCristina
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
            <b><color=\#3a6954>Catena</color></b>: "Quindi?"
            * {not CristinaWin} "Spero che ci fai amicizia con la Cristina."
                <b><color=\#3a6954>Catena</color></b>: "Continua a sperare."
                * * "Signùr! Perché tutto questo astio?"
                <b><color=\#3a6954>Catena</color></b>: "Perché almeno io ho buonsenso! T'ha trattato di merda, e tu la perdoni pure."
                * * * "Vita mia, non si può vivere di sola rabbia."
                <b><color=\#3a6954>Catena</color></b>: "Ma si campa di più che con la stupidità."
                <b><color=\#3a6954>Catena</color></b>: "Comunque sta arrivando il tuo migliore amico."
            * {CristinaWin} "Forse ci dovevo insistere di più."
                <b><color=\#3a6954>Catena</color></b>: "Non puoi salvare un ramo dal fuoco."
                * * "Che vuol dire, vita mia?"
                <b><color=\#3a6954>Catena</color></b>: "Che ha già deciso il suo destino, tutto qui. Non puoi fare il lavoro per tutte."
                * * * "Credo tu c'abbia ragione, ma la cosa non consola."
                <b><color=\#3a6954>Catena</color></b>: "Allora ti consolo poi in osteria."
                <b><color=\#3a6954>Catena</color></b>: "Ma dopo, che ora sta arrivando sua maestà della puzzolenza Thovez."
            * "Quindi che cosa?"
                <b><color=\#3a6954>Catena</color></b>: "Che ne pensi di tutta 'sta faccenda di Cristina?"
                * * {not CristinaWin} "Mi chiedo come ci sarebbero andate le cose, se fosse rimasta con me."
                    <b><color=\#3a6954>Catena</color></b>: "Magari non mi avresti conosciuta."
                    * * * "Allora sono felice di come mi sono andate le cose con lei."
                        <b><color=\#3a6954>Catena</color></b>: "Certo, certo."
                    * * * "Sono sicuro che ci saremmo ritrovate."
                        <b><color=\#3a6954>Catena</color></b>: "Un po' come due brutte malattie in un giorno di novembre."
                    * * * "Allora mi c'è andata davvero male!"
                        <b><color=\#3a6954>Catena</color></b>: "Io ti annego, sappilo."
                        <b><color=\#3a6954>Catena</color></b>: "Anzi: sta arrivando Thovez, ci penserà lui."
                * * {CristinaWin} "Alla fine ha scelto quello che riteneva giusto."
                    <b><color=\#3a6954>Catena</color></b>: "Ma a te non va giù."
                    * * * "No eh."
                        <b><color=\#3a6954>Catena</color></b>: "Non puoi salvare tutte, S.! Soprattutto quando non vogliono."
                        * * * * "C'hai ragione."
                    * * * "E' grande abbastanza."
                        <b><color=\#3a6954>Catena</color></b>: "Ma questo non ti solleva."
                        * * * * "Non mi piace il Thovez, non mi piace la situazione a Bronte, c'ho paura per lei."
                        <b><color=\#3a6954>Catena</color></b>: "Se l'è cavata per dieci anni senza di te, può farlo per il resto della sua vita."
                    * * * "Spero solo non se ne pente."
                        <b><color=\#3a6954>Catena</color></b>: "Naa, ha la faccia di una che cade sempre in piedi."
                        * * * * "Non ti ci piace la Cristina, vero?"
                        <b><color=\#3a6954>Catena</color></b>: "No, ma poco cambia ormai."
                        <b><color=\#3a6954>Catena</color></b>: "E a proposito di gente che non mi piace: sta arrivando Thovez."
            -
    
    -> DONE
    
    = PrimaDellaPartitaThovez
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
        <b><color=\#3a6954>Catena</color></b>: {"Eccolo di nuovo."|"Ma sono i suoi capelli veri, secondo te?"|"Quando entra nella stanza toglie l'aria."|"Spero finiremo alla svelta."}
    
    -> DONE
    
    =  DopoLaPartitaThovez
    {ThovezWin:
    - true: -> ThovezVince
    - false: -> ThovezPerde
    }
    
    = ThovezVince
    //aka, non si fida//
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Quella specie di scarafaggio umano! Domani dobbiamo assolutamente mettere del sale in zucca ad Isaac."
            * "Come se fosse facile."
            -
        <b><color=\#3a6954>Catena</color></b>: "Mi sembri preoccupato."
            * "Non mi fido di quell'uomo, per nulla."
            * "Ci ha minacciate e poi cacciate.["] Si vendicherà in qualche modo."
            * "Serve un piano per mettere l'Isaac al sicuro."
            -
        <b><color=\#3a6954>Catena</color></b>: "Hai ragione, amore. Birra e abbracci e cerchiamo delle soluzioni?"
            * "Mi ci sembra un buon piano."
            -
        <b><color=\#3a6954>Catena</color></b>: "Però, amore, una cosa prima."
        <b><color=\#3a6954>Catena</color></b>: {CristinaWin: "Mi spiace per Cristina. Non mi piace molto, ma rimanere con quest'uomo..."| "Cristina non mi piace, ma sono contenta che la portiamo via da questo animale!"}
            * "Sei una brontolona, ma c'hai un cuore enorme."
            <b><color=\#3a6954>Catena</color></b>:{not CristinaWin: "Ma se ti mette nei guai, la uccido!"|"Naa, così mi fai diventare rossa, e rossa sono brutta.}
            -
            * [<b>Passa alla mattina seguente</b>]"Andiamo, e iniziamo a ragionare."
                ~ caricaScena("CasaIsaacInterno")
    	            ~ caricaAtto("GiornoDueMattino")
    	                -> DONE
    
    
    
    = ThovezPerde
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "L'hai intortato per bene!"
        <b><color=\#3a6954>Catena</color></b>: "Perché non hai intenzione di mantenere la parola, vero?"
            * "Non tradisco mai la parola data, vita mia!"
                <b><color=\#3a6954>Catena</color></b>: "Allora è il caso di cominciare. Ora."
            * "Non ce lo so ancora cosa fare, amore."
            * "Di certo non farò del male a quei poveretti."
            -
        <b><color=\#3a6954>Catena</color></b>: "Andiamo in osteria a sbronzarci? Lì ti vengono le idee migliori!"
            * "Dio sì, l'idea mi piace. Questo posto è pieno di scarafaggi."
            -
        <b><color=\#3a6954>Catena</color></b>: "Però, amore, una domanda prima."
        <b><color=\#3a6954>Catena</color></b>: {CristinaWin: "Non mi piace Cristina, ma pensi di farle cambiare idea? Questo tizio è un mostro."|"Se Cristina tradisce di nuovo la sua parola, non sei obbligato a proteggerla ancora."}
            * {CristinaWin} "Potrebbe anche aiutarci. In fondo conosce il Thovez."
            * {not CristinaWin} "Se me lo dimentico, me lo ricordi tu?"
                <b><color=\#3a6954>Catena</color></b>: "Ci puoi giurare, amore."
            -
            * [<b>Passa alla mattina seguente</b>]"Ma ora, andiamo ad ubriacarci."
                    ~ caricaScena("CasaIsaacInterno")
    	            ~ caricaAtto("GiornoDueMattino")
    	                -> DONE



/* ---------------------------------

                THOVEZ

 ----------------------------------*/

=== Dialog_ThovezCasaThovezBiblioteca
{Dialog_ThovezCasaThovezBiblioteca_Step:
- 0: -> PrimaDellaPartita
- else: -> DopoLaPartita
}

    = PrimaDellaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
    
        <b><color=\#81482e>Thovez</color></b>: "Eccomi, scusatemi per l'attesa ma il capo delle guardie era un po' teso stasera. Dice che ci sono più delinquenti del solito in giro per Bronte."
        * "È un bene allora che siano tutti in questa casa stasera[."], il suo lavoro sicuramente sarà più facile."
        * "Coi prezzi raggiunti al mercato ci ruberei anche io."
            {CatenaWin:
            ~ PersonaggioDx = "Catena"
            }
            {CatenaWin: 
            <b><color=\#3a6954>Catena</color></b>: "Non che di solito..."
            }
        * "Immagino il dolore per il povero Torrisi[!"], obbligato addirittura ad uscire dall'osteria e riunciare alle sue amate carte."
        -
        ~ PersonaggioDx = "Thovez"
        <b><color=\#81482e>Thovez</color></b>: "Mi era mancato il vostro umore, milady. Così sincero e popolare! Ma prego, sedetevi pure!"
        <b><color=\#81482e>Thovez</color></b>: "Gradite da bere? Questo è il vino che produciamo qui nella ducea, almeno una spanna sopra a quella porcheria del Bronte Madeira che i Woodhouse producono a Marsala."
        * "Niente birra?"
            <b><color=\#81482e>Thovez</color></b>: "Per chi mi avete preso?
            * * "Vada per il bujoso" //bujoso = vino.
            {CatenaWin:
            ~ PersonaggioDx = "Catena"
            }
            {CatenaWin:
            <b><color=\#3a6954>Catena</color></b>: "E a me nulla?"
            }
            ~ PersonaggioDx = "Thovez"
                <b><color=\#81482e>Thovez</color></b>: "Che ne pensate?"
                    * * * "C'ha lo stesso sapore dei fondini dell'osteria."
                        <b><color=\#81482e>Thovez</color></b>: "Questa annata non è stata delle migliori. E comunque immagino che non tutti abbiano i sensi tanto elevati da apprezzare certe squisitezze."
                        <b><color=\#81482e>Thovez</color></b>: "Ma parliamo di affari, adesso."
                        <b><color=\#81482e>Thovez</color></b>: "Dunque, il mio problema è questo. Non so se ne siete al corrente, ma alcuni brontesi, dei briganti di certo, stanno occupando i boschi della ducea perchè sono troppo ignoranti per comprendere il concetto di proprietà privata."
                        <b><color=\#81482e>Thovez</color></b>: "Ho bisogno di qualcuno che si occupi di loro, e dato che voi già vi occupate di pirati, i briganti del mare, la mia scelta ovviamente è ricaduta su di voi".
                        <b><color=\#81482e>Thovez</color></b>: "Ne ho parlato col reverendo Nelson ed è disposto a elargire una somma considerevole affinché il problema venga risolto."
                    * * * "Ricorda certe ragazze dei bordelli[."], mi piace."
                        <b><color=\#81482e>Thovez</color></b>: "Prendete pure una bottiglia, allora. Come simbolo della mia stima nei vostri confronti. E accogliete con amicizia le mie preoccupazioni."
                        <b><color=\#81482e>Thovez</color></b>: "Dunque, il mio problema è questo. Non so se ne siete al corrente, ma alcuni brontesi, dei briganti di certo, stanno occupando i boschi della ducea perchè sono troppo ignoranti per comprendere il concetto di proprietà privata."
                        <b><color=\#81482e>Thovez</color></b>: "Ho bisogno di qualcuno che si occupi di loro, e dato che voi già vi occupate di pirati, i briganti del mare, la mia scelta ovviamente è ricaduta su di voi".
                        <b><color=\#81482e>Thovez</color></b>: "Ne ho parlato col vescovo ed è disposto a elargire una somma considerevole affinché il problema venga risolto."
                    * * * [Versi il vino sul tappeto.] "Ops. Che sbadato."
                        {CatenaWin:
                        ~ PersonaggioDx = "Catena"
                        }
                        {CatenaWin:
                        <b><color=\#3a6954>Catena</color></b>: "Dieci minuti fa: "Mi raccomando Catena, non fare casini." E ora, eccolo!"
                        }
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Bene, allora. Mi abbasserò al tuo livello. Mi servono dei brutti ceffi per allontanare quei pezzenti dei brontesi dai miei boschi."
                        <b><color=\#81482e>Thovez</color></b>: "Facce brutte come la tua e quelle dei tuoi compagni."
                        {CatenaWin:
                        ~ PersonaggioDx = "Catena"
                        }
                        {CatenaWin:
                        <b><color=\#3a6954>Catena</color></b>: "Ehi, io sono una dea!"
                        }
                        ~ PersonaggioDx = "Thovez"
                        <b><color=\#81482e>Thovez</color></b>: "Pago bene, e se l'affare va in porto sono certo che potremo continuare a coltivare altri lucrosi rapporti in futuro."
                        <b><color=\#81482e>Thovez</color></b>: "Il vino dei Woodhouse viaggia per mare, e gli incidenti possono sempre capitare, non trovi?"
                        <b><color=\#81482e>Thovez</color></b>: "Ovviamente, il tappeto sarà messo sul tuo conto."
                        
        
        * "No eh."
            ~ PersonaggioDx = "Thovez"
            <b><color=\#81482e>Thovez</color></b>: "Ma vi perdete qualcosa di sopraffino! Una cassa è stata data in dono persino a Rossini, sa?"
            {CatenaWin:
            ~ PersonaggioDx = "Catena"
            }
            {CatenaWin:
            <b><color=\#3a6954>Catena</color></b>: "Se non lo vuoi, S., me lo bevo volentieri!"
            }
            ~ PersonaggioDx = "Thovez"
            * * "Si beve quando c'è la fiducia[."], e ora non mi ci fido di te, Philip."
                <b><color=\#81482e>Thovez</color></b>: "Bene. Andrò dritto al punto allora, come piace a te. Alcuni brontesi occupano abusivamente i miei boschi."
                <b><color=\#81482e>Thovez</color></b>: "Li voglio lontani e resi inoffensivi, non mi interessa con che metodo. Ti ricompenserò lautamente."
                <b><color=\#81482e>Thovez</color></b>: "E chissà che in futuro non si aprano altre cooperazioni."
    
        -
        
        * "Preferisco l'idea di pulire culi di balena per i prossimi vent'anni."
        * "Tendete a trasformare tutti in vostri burattini, Philip. ["] Col cavolo che accetto questa proposta."
        * "Sono a Bronte per aiutare gli abitanti, non dei ricchi barbagianni."
        * {CatenaWin} "Col..."
            ~ PersonaggioDx = "Catena"
            <b><color=\#3a6954>Catena</color></b>: "S., quella boccaccia!"
        -    
        ~ PersonaggioDx = "Thovez"
        <b><color=\#81482e>Thovez</color></b>: "Mi dispiace molto sentirlo. Speravo non dovessimo giungere a questo, ma a questo punto ho le mani legate."
        <b><color=\#81482e>Thovez</color></b>: "Conosco da tempo le disgustose abitudini di lord Isaac, un vero disonore per tutta la sua famiglia."
        * "Cosa intendi?"
            <b><color=\#81482e>Thovez</color></b>: "Intendo le nottate con l'Alfonso, le uscite disgustose tra soli uomini coi riccastri del paese. Le azioni immorali compiute con il suo servo."
        -
        {CatenaWin:
        ~ PersonaggioDx = "Catena"
        }
        {CatenaWin:
        <b><color=\#3a6954>Catena</color></b>: "E quelle con tuo fratello Henry?"
        }
        ~ PersonaggioDx = "Thovez"
        {CatenaWin:
        <b><color=\#81482e>Thovez</color></b>: "Zitta, garza!"
        } //garza = prostituta coniugata.
        
            <b><color=\#81482e>Thovez</color></b>: "Come fedele servitore del reverendo Nelson, è mio dovere informarlo dello scandalo, e soprattutto del crimine contro la natura e Dio stesso che vostro marito commette da tempo."
            <b><color=\#81482e>Thovez</color></b>: "Sono certo che il reverendo vorrà assicurarsi con ogni mezzo il suo ritorno in madrepatria e la cura della sua anima, con ogni mezzo necessario."
            <b><color=\#81482e>Thovez</color></b>: "Qualora cambiaste idea sulla mia proposta d'affari, potrei però decidere di tenere il reverendo all'oscuro di questa ignominiosa notizia, per il suo stesso bene ovviamente."
            <b><color=\#81482e>Thovez</color></b>: "E se mi chiedete scusa per le vostre parole."
            <b><color=\#81482e>Thovez</color></b>: "Quindi, S., cosa ne pensate?"
        
        ~ Dialog_ThovezCasaThovezBiblioteca_Step += 1
        ~ caricaPartita("Thovez")
        @
        -
    
    -> DopoLaPartita
    
    = DopoLaPartita
    {ThovezWin:
    - true: -> ThovezVince
    - false: -> ThovezPerde
    }
    
    
    = ThovezVince
    //aka, non si fida//
    ~ ThovezCasaThovezCameraDaLetto = true
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
        
            <b><color=\#81482e>Thovez</color></b>: "Ripensandoci, i vostri repentini cambi di idea non mi ispirano particolare fiducia. Troverò qualcun altro che si occupi dei boschi."
            <b><color=\#81482e>Thovez</color></b>: "Andateve. Oh, e salutatemi molto lady Isabel. Spero si riesca a godere i pochi giorni che gli restano come uomo libero."
            
                * [<b>Passi alla mattina seguente</b>]"Fanculo, Thovez!"
                    ~ caricaScena("CasaIsaacInterno")
    	            ~ caricaAtto("GiornoDueMattino")
    	            ~ ThovezCasaThovezBiblioteca = false
    	            -> DONE
                + {CatenaWin} Parli con Catena.
                ~ ThovezCasaThovezBiblioteca = false
                    -> DONE
      
    
        
    
    = ThovezPerde
    //si fida//
    ~ ThovezCasaThovezCameraDaLetto = false
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Thovez"
    
            <b><color=\#81482e>Thovez</color></b>: "Bene, direi che abbiamo stretto il nostro accordo, Lady S.!"
            <b><color=\#81482e>Thovez</color></b>: "Manca solo una cosa: le scuse che mi deve."
                    * ["Sei davvero divertente, Thovez!"]"A l’ ma grigna a’ ’l cül"
                        <b><color=\#81482e>Thovez</color></b>: "C'è ancora del lavoro da fare, ma sono sicuro che troverò un modo per addomesticarti."
                        {CatenaWin: 
                        ~ PersonaggioDx = "Catena"
                        }
                        {CatenaWin:
                        <b><color=\#3a6954>Catena</color></b>: "O per trovarti senza una mano."
                        }
                    * "Direi che hai ottenuto abbastanza."
                        <b><color=\#81482e>Thovez</color></b>: "Per ora. Va bene, milady, stasera sono magnanimo. Sentiti libera di andare a riposare alla tua bettola."
                        {CatenaWin: 
                        ~ PersonaggioDx = "Catena"
                        }
                        {CatenaWin:
                        <b><color=\#3a6954>Catena</color></b>: "Sempre meno scarafaggi in osteria che qui."
                        }
                    * "Presterò più attenzione alle mie parole in futuro."
                        <b><color=\#81482e>Thovez</color></b>: "Non abbastanza, ma è un inizio. In fondo ogni cane impara a non mordere la mano del proprio padrone."
                        {CatenaWin: 
                        ~ PersonaggioDx = "Catena"
                        }
                        {CatenaWin:
                        <b><color=\#3a6954>Catena</color></b>: "Non l'ha ancora capito, come parli, vero?"
                        }
                    -
            ~ PersonaggioDx = "Thovez"
            <b><color=\#81482e>Thovez</color></b>: "E ora: è tempo di occuparmi dei miei ospiti più illustri, milady. Andatevene, e portatemi buone notizie entro due giorni!"
                    * [<b>Passa alla mattina seguente</b>]"A presto, Thovez."
                    ~ caricaScena("CasaIsaacInterno")
    	            ~ caricaAtto("GiornoDueMattino")
    	            ~ ThovezCasaThovezBiblioteca = false
    	                -> DONE
                    + {CatenaWin} Parli con Catena.
                    ~ ThovezCasaThovezBiblioteca = false
                    -> DONE
    




//PARTITA CON THOVEZ

=== Partita_Thovez_Chiacchiera ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Thovez"

    <b><color=\#354174>S.</color></b>: "Che non c'ho motivo per chiedere scusa."
    <b><color=\#81482e>Thovez</color></b>: "Oh, S., ma a volte un piccolo sacrificio è tutto ciò che serve per far andare le cose nel verso giusto."
    <b><color=\#354174>S.</color></b>: "Per te qualunque mezzo è buono, basta che raggiunga lo scopo."
    <b><color=\#81482e>Thovez</color></b>: "Sapevo che avreste capito."
    <b><color=\#354174>S.</color></b>: "Ne ho visti tanti come te."
    <b><color=\#81482e>Thovez</color></b>: "Non mi stupisce affatto. Sono molti gli uomini che si sono fatti da soli."
    <b><color=\#354174>S.</color></b>: "Certo: magnaccia, capibastone, proprietari terrieri e altra gentaglia che se la campa sul lavoro di poveri cristià."
    <b><color=\#81482e>Thovez</color></b>: "Non ti consiglio di fare questo paragone."
    <b><color=\#354174>S.</color></b>: "Se vedo un cane lo chiamo cane."
    <b><color=\#81482e>Thovez</color></b>: "Milady, ricordatevi chi ha il potere qui. E chi ha potere può permettersi cose che i plebei non possono. Tutto qui."
    <b><color=\#354174>S.</color></b>: "Buffo che tra i due quello col titolo sia io."
    <b><color=\#81482e>Thovez</color></b>: "Come dimenticarlo, milady. Per il momento, almeno."

-> DONE

=== Partita_Thovez_Seduzione ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Thovez"

    <b><color=\#354174>S.</color></b>: "Non vedo cos'altro c'ho da dirti, Thovez."
    <b><color=\#81482e>Thovez</color></b>: "Accetta la mia proposta e diventiamo buoni soci d'affari."
    <b><color=\#354174>S.</color></b>: "Non toccherai mai l'Isaac né la mia ciurma. Né tu né i tuoi sgherri."
    <b><color=\#81482e>Thovez</color></b>: "Nessun capello verrà torto né a te, né a tuo marito né ai tuoi amici. Parola di gentiluomo."
    <b><color=\#354174>S.</color></b>: "E cosa facciamo a chi troviamo nel bosco?"
    <b><color=\#81482e>Thovez</color></b>: "Qualcosa di esemplare. Voglio che abbiano abbastanza paura da non osare riprovarci."
    <b><color=\#354174>S.</color></b>: "Ci lasciamo in giro qualche tuo quadro? Ci fingiamo fantasmi? Ci tiriamo due pugni? "
    <b><color=\#81482e>Thovez</color></b>: "Diciamo che se dovesse accadere qualche disgrazia non verserò una lacrima."
    <b><color=\#354174>S.</color></b>: "Non ucciderò nessuno Thovez, non per te."
    <b><color=\#81482e>Thovez</color></b>: "Prendi, sono venti ducati d'oro. Ne avrai altri per ognuno di quei pezzenti punito."

-> DONE

=== Partita_Thovez_Zuffa ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Thovez"

    <b><color=\#354174>S.</color></b>: "Mi hai preso davvero per un mulo?"
    <b><color=\#81482e>Thovez</color></b>: "Speravo in maggiore razionalità, ma siete una donna in fondo."
    <b><color=\#354174>S.</color></b>: "Molto in fondo."
    <b><color=\#81482e>Thovez</color></b>: "Mi hai rotto con la tua ironia. Ricorda chi tiene la vita del tuo Isaac in pugno."
    <b><color=\#354174>S.</color></b>: "Non hai idea di chi ti stai mettendo contro, Philip."
    <b><color=\#81482e>Thovez</color></b>: "Ho un'idea abbastanza chiara, invece. Sono stato informato di Firenze, Bologna, Napoli..."
    <b><color=\#354174>S.</color></b>: "Allora sai di che cosa sono capace."
    <b><color=\#81482e>Thovez</color></b>: "Oh sì. Ma hai il madornale difetto di aiutare chi ami. Aiutami, e proteggerò i tuoi amici fino alla fine dei miei giorni."
    <b><color=\#354174>S.</color></b>: "Non mi fido della tua parola."
    <b><color=\#81482e>Thovez</color></b>: "Ma è l'unica cosa che ho sempre rispettato, S., puoi chiederlo a chiunque. Mantengo le promesse e le minacce."
    <b><color=\#354174>S.</color></b>: "Potrei sempre liberarmi di te."
    <b><color=\#81482e>Thovez</color></b>: "Non sottovalutarmi. Ho combattuto a Trafalgar. In una vera guerra, non in qualche rissa da osteria."

-> DONE