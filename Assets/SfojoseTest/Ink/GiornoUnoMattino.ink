/* ---------------------------------

                CATENA

 ----------------------------------*/

=== Dialog_CatenaCameraInOsteria
{Dialog_CatenaCameraInOsteria_Step:
- 0: -> aLetto
- 1 && (Dialog_GoranChiesa || Dialog_FatimaMercato || Dialog_VituzzoOsteria): -> diRitorno
- 1: -> nienteDaDire
- 2: -> DopoLaPartita
}

    =aLetto
    ~ PersonaggioSx = "SNarrante"
    
    
    <b><color=\#354174>S. Narrante</color></b>: "A volte tu ti ci fissi sullo strappo di una vela, e non ti accorgi mica della falla sulla chiglia."
    ~ PersonaggioDx = "Catena"
    ~ PersonaggioSx = "S"
    <b><color=\#3a6954>Catena</color></b>: "Giuro che se ci vai, io..."
        * "...fai mica pace con Fatima?"
            <b><color=\#3a6954>Catena</color></b>: "Quando mi ridà il mio khanjar!"
        * "...assalti la ducea?"
            <b><color=\#3a6954>Catena</color></b>: "Fanculo, S."
        * "Vita mia, respira."
            <b><color=\#3a6954>Catena</color></b>: "Abbracciami, per favore."
        -
    <b><color=\#3a6954>Catena</color></b>: "Stammi vicino un poco."
        * "Va meglio ora?"
            <b><color=\#3a6954>Catena</color></b>: "Questo letto è fitùsu, puzza più dei piedi di Vituzzo."
            * * "Almeno la camera ha una porta.["] Il resto della ciurma dorme nella cucina dell'oste."
        -
    <b><color=\#3a6954>Catena</color></b>: "Non andare stasera. È una trappola."
        * ["Sì"]"Lo so, ma non c'ho alternative."
            <b><color=\#3a6954>Catena</color></b>: "Per quella frase nella lettera? Per <i>Porti i miei saluti a lady Isabel</i>?"
            * * "Il Thovez sa qualcosa su Isaac[."], Isabel è il suo nomignolo quando lui ci va alle feste. E vi ho promesso che vi proteggo sempre."
            
        -
    <b><color=\#3a6954>Catena</color></b>: "Ma non dalle..."
        *"Da cosa?"
        -
    <b><color=\#3a6954>Catena</color></b>: "Dai casini in cui ci cacciammo di nostro. Che se Isaac se ne restò buono in casa, insomma!"
        * "Se se ne sta buono non è mica Isaac."
            <b><color=\#3a6954>Catena</color></b>: "Piensu ca ti sbagghi. Perché lo difendi sempre?"
        -
        * (giustizia) "Non è giusto[."] e lo sai. Noi c'abbiamo il mare, i porti e una faccia come il culo."
            <b><color=\#354174>S.</color></b>: "Lui ha solo noi e i suoi riccastri con gli sghei. Cos'altro deve fare?"
            <b><color=\#3a6954>Catena</color></b>: "Accontentarsi del nostro amore."
                * * "Vita, stiamo sempre parlando di Isaac?"
                <b><color=\#3a6954>Catena</color></b>: "Io... ne parliamo quando tutto è risolto."
        * (festa) "Non fa nulla di male[."]. Le sue feste sono come quelle del Thovez o dell'Arcivescovo di 'sta ceppa."
            S. : "Tu te la ricordi quella nottata a Siviglia?"
            <b><color=\#3a6954>Catena</color></b>: "Dio, mi facesti sentire una ragazzina in quel momento. Quanto ti ho amato!"
                * * "Lì mi hanno preso per un òm[."], abbiamo ballato libere solo per quello."
                    <b><color=\#354174>S.</color></b>: "Altrimenti ci portavano di nuovo in un manicomio o peggio, vita mia."
        * (arresto) ["Mica te lo ricordi l'arresto a Cotrone, vita mia?"] "Dici tu che ti sei fatta arrestare per una rissa in un bordello."
            <b><color=\#354174>S.</color></b>: Ti ci abbiamo tirata fuori a cannonate dallo studio, vita mia!" //* "Cotrone" non è un typo, ma il nome della città fino al 1928*//
            //* studio = galera *//
            <b><color=\#3a6954>Catena</color></b>: "Vabbè ma la storia del <i>casinu</i> fu una questione di libertà, quella, una cosa importante!" //casinu = bordello
            * * "Lo è anche per l'Isaac[."], la libertà di scoparsi chi vuole senza rottura di minchia, come lo dici tu. Cosa c'è di male?"
                <b><color=\#3a6954>Catena</color></b>: "Hai ragione, ma non cambia che andare da Thovez è una cazzata."
        -
        <b><color=\#3a6954>Catena</color></b>: "È inaffidabile. Da quando comanda chìddu la gente è sul piede di guerra. Non mi stupisco se scoppia una sommossa come a Napoli."
            * "Così c'abbiamo un problema in meno[."] E magari poi ti ci diverti a fare andare le mani e lo spadino."
                <b><color=\#3a6954>Catena</color></b>: "Bel pensiero, ma non voglio che la rivolta parte stasera con te lì dentro."
            * "Prometto che ci sto attento.["] Ma non posso mica lasciare l'Isaac nei casini."
                <b><color=\#3a6954>Catena</color></b>: "Portiamo via il garruso da qua allora!"
                    * * ["Isaac? In nave?"] "Madóna mé l'ultima volta che c'è salito su una nave c'aveva lo stesso colore e puzzo di un'alga ad agosto."
            * "La tensione è palpabile[."] e questo potrebbe farci bene se il Thovez non c'ha ol servel de 'na poia. Non vuole come nemico qualcuno che piace al paese."
                <b><color=\#3a6954>Catena</color></b>: "O forse chìddu vuole proprio liberarsi di chi ha più rispetto di lui. Magari pensa che sei tu ad alimentare la ribellione."
                    * * "Allora l'è più idiota di quanto già non sembra[."] Vero che da un uomo arriva sempre il peggio, ma cosa si aspetta?"
                    "Quando l'insurrezione scoppia, si crede che Nelson in persona arriva qui ad aiutarlo?"
                        <b><color=\#3a6954>Catena</color></b>: "A ogni porcu veni lu sò san Martinu. Quel giorno faccio festa."
            -   
        {arresto:
        <b><color=\#3a6954>Catena</color></b>: "Magari pulisco i cannoni."
        }
        {festa:
        <b><color=\#3a6954>Catena</color></b>: "Perché non ce ne torniamo a ballare a Siviglia?"
        }
        {giustizia:
        <b><color=\#3a6954>Catena</color></b>: "Per me con una nave di bei garrusi a Isaac il mal di mare passa tutto."
        }
        
            * "Quindi siamo d'accordo, vita mia?"
            -
            
        <b><color=\#3a6954>Catena</color></b>: "Che testone che sei, cuoricì. Facciamo così: fai due passi, parli con qualcuno della ciurma, con la gente del paese."
        <b><color=\#3a6954>Catena</color></b>: "Cerchi di capire la situazione, chiedi consiglio. Ma non a Vituzzo, che la Madonna ce ne scampi! Poi torni e se ne ragiona assieme."
        
            * "È una buona idea. Ma prima ci dai un bacio al tuo S.!"
            -
        <b><color=\#3a6954>Catena</color></b>: "Non te ne meriti mezzo. Ma forse due. O tre. Oh, oh, quattro."
    
    
    ~ Dialog_CatenaCameraInOsteria_Step += 1
    -> DONE
    
    =nienteDaDire
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
        <b><color=\#3a6954>Catena</color></b>: {"Cuoricì, prendi una boccata d'aria che poi ne ragioniamo"|"Ancora qui stai?"|"S., fatti questi due passi!"|"Vabbene sono un po' incazzata, fammi dormire un attimo"|"Pazienza zero, tu, vero?"!"Senti, va almeno a vedere che Vituzzo non sta a fare cagate!"} 
    -> DONE
    
    =diRitorno
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
       
        <b><color=\#3a6954>Catena</color></b>: "Eccolo, il testone supremo. Quindi, che t'hanno detto?"
            * {Dialog_GoranChiesa} "Il Goran stava a litigare con un prete."
                    "Però ho scoperto che il Thovez sta facendo un casino col bosco."
                    "Vuole distruggerlo per coltivare della roba, ma farà morire la gente di freddo."
                    <b><color=\#3a6954>Catena</color></b>: "E questo sicuro non ti ha fatto cambiare idea su stasera."
                    * * "No eh."
            * {Dialog_FatimaMercato} "La Fatima coi coltelli mi preoccupa, l'è fò de cò quella."
                "Sembra che ci siano delle tensioni coi <i>rivoltosi</i>."
                    "Ovvero col Giuseppe e le altre stanche del Thovez. Un mercante dice addirittura che c'è l'esercito."
                    <b><color=\#3a6954>Catena</color></b>: "E tu continui a pensare che andare da solo stasera sia una buona idea."
            * {Dialog_VituzzoOsteria} "Vituzzo è un servel de poia."
             "{Dialog_VituzzoOsteria.discussioneAvventore.solo: "Ma sembra che il Thovez abbia addirittura assunto dei soldati per tenere sotto controllo la popolazione.|Ed è bravissimo a circondarsi di gente più stupida di lui.}"
                <b><color=\#3a6954>Catena</color></b>: "Lui è un idiota, ma tu sei peggio di un mulo."
            -
        <b><color=\#3a6954>Catena</color></b>: "Stasera vengo con te."
            * "Non esiste!["] La lettera dice "Vieni da sola!"
                <b><color=\#3a6954>Catena</color></b>: "Non ti ho fatto una richiesta, cuoricì."
            -
            //Inizio partita/
            ~ Dialog_CatenaCameraInOsteria_Step += 1
            ~ caricaPartita("Catena")
            @
            
        
        {
        - !CatenaWin: 
        ~ CatenaCasaThovezStanzaFeste = false
        ~ CatenaCasaThovezBiblioteca = false
        
        - CatenaWin: 
        ~ CatenaCasaThovezStanzaFeste = true
        ~ CatenaCasaThovezBiblioteca = true
        }
    
    -> DopoLaPartita
    
    =DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
    <b><color=\#3a6954>Catena</color></b>: "Quindi?"
    
            * {not CatenaWin && Partita_Catena_Seduzione} "Mi dispiace vita mia.["] Ci resto volentieri a letto con te, ma non ci vieni dal Thovez."
                    <b><color=\#3a6954>Catena</color></b>: "Se ti uccide ti ammazzo."
            * {not CatenaWin && Partita_Catena_Zuffa} "Tieniti la tua rabbia vita mia.["] Mi dispiace, ma ci vado da solo dal Thovez. Ti prometto che torno."
                    <b><color=\#3a6954>Catena</color></b>: "Se ti uccide ti ammazzo."        
            * {CatenaWin && Partita_Catena_Seduzione} "Va bene va bene c'hai ragione te!["] Stammi vicina, stasera."
                    <b><color=\#3a6954>Catena</color></b>: "Potevi darmi ragione un'ora fa, e avremmo fatto di meglio."
            * {CatenaWin && Partita_Catena_Zuffa} "Madóna mé, ci sono momenti in cui ti odio.["] Stammi vicina stasera e niente spadini o sassi o finestre."
                    <b><color=\#3a6954>Catena</color></b>: "Sarò la tua ombra."        
           -
        <b><color=\#3a6954>Catena</color></b>: "È ora di andare."   
            * {CatenaWin} "Che il tuo Dio ce la mandi buona!"
            * {not CatenaWin} "Ci becchiamo domattina da Isaac. Ti amo."
            -
            * [<b>Prepara il deck prima di andare da Thovez</b>]"È il caso che mi prepari in vista della serata."
            ~ caricaAtto("DeckBuilding")
            ~ caricaDeckBuilding()
            @
            ~ caricaAtto("GiornoUnoSera") 
        	~ caricaScena("CasaThovezStanzaFeste")
    -> DONE

//PARTITA CON CATENA

=== Partita_Catena_Chiacchiera ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Catena"

    <b><color=\#354174>S.</color></b>: "Non l'è un posto sicuro."
    <b><color=\#3a6954>Catena</color></b>: "Per questo in due è più semplice."
    <b><color=\#354174>S.</color></b>: "E poi chi ci sta dietro alla ciurma?"
    <b><color=\#3a6954>Catena</color></b>: "Cuoricì, sono grandi abbastanza."
    <b><color=\#354174>S.</color></b>: "E..."
    <b><color=\#3a6954>Catena</color></b>: "E cosa, S.? Non mi vuoi lì?"
    <b><color=\#354174>S.</color></b>: "Oh merda, è che non voglio che ti accade mica qualcosa."
    <b><color=\#3a6954>Catena</color></b>: "Nemmeno io. In due siamo forti, e lo sai."

-> DONE

=== Partita_Catena_Seduzione ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Catena"

    <b><color=\#354174>S.</color></b>: "Perché devi sempre far così?"
    <b><color=\#3a6954>Catena</color></b>: "Cosa c'è di difficile da capire? Ti amo idiota. E proteggo chi amo."
    <b><color=\#354174>S.</color></b>: "Se sei lì con me, c'ho il doppio della preoccupazione."
    <b><color=\#3a6954>Catena</color></b>: "Ma anche il doppio del piacere."
    <b><color=\#354174>S.</color></b>: "Catè!"
    <b><color=\#3a6954>Catena</color></b>: "Immagina quella grande casa piena di pretini e ricchi del cavolo. E noi due che..."
    <b><color=\#354174>S.</color></b>: "..."
    <b><color=\#3a6954>Catena</color></b>: "Sembra a me, o stai arrapato?"
    <b><color=\#354174>S.</color></b>: "Che ne dici di un assaggio ora, qui?"
    <b><color=\#3a6954>Catena</color></b>: "Mi porti stasera e ti do tutto il pranzo subito."

-> DONE


=== Partita_Catena_Zuffa ===
~ PersonaggioSx = "S"
~ PersonaggioDx = "Catena"

    <b><color=\#354174>S.</color></b>: "Perché c'è sempre tutta questa fatica con te?"
    <b><color=\#3a6954>Catena</color></b>: "Perché sei un testone del cavolo, ecco perché."
    <b><color=\#354174>S.</color></b>: "Se sei lì con me, c'avrò il doppio della preoccupazione."
    <b><color=\#3a6954>Catena</color></b>: "So difendermi, e difenderti."
    <b><color=\#354174>S.</color></b>: "Sarà pieno di sgherri del Thovez."
    <b><color=\#3a6954>Catena</color></b>: "Niente che non abbiamo già affrontato. Te lo devo dimostrare?"
    <b><color=\#354174>S.</color></b>: "Non ti fidi di me, Cristo?"
    <b><color=\#3a6954>Catena</color></b>: "Non mi fido di loro. Sono delle merde, S."
    <b><color=\#354174>S.</color></b>: "E cosa c'intendi fare nel caso?"
    <b><color=\#3a6954>Catena</color></b>: "C'è lo spadino, ci sono i pugni, ci saranno molti bicchieri, finestre..."
    <b><color=\#354174>S.</color></b>: "Bracchi."
    <b><color=\#3a6954>Catena</color></b>: "Acciarini, bastoni, <i>sbigni</i>..." //* sbigni = sassi
    <b><color=\#354174>S.</color></b>: "Cosa devo fare con te, vita mia?"
    <b><color=\#3a6954>Catena</color></b>: "Farmi venire."


-> DONE


/* ---------------------------------

        VITUZZO, FATIMA E GORAN

 ----------------------------------*/

//VITUZZO OSTERIA//
=== Dialog_VituzzoOsteria
{Dialog_VituzzoInOsteria_Step:
- 0: -> discussioneAvventore
- else: -> fallbackVituzzo
}

    = discussioneAvventore
    ~ PersonaggioSx = "SNarrante"
    
    <b><color=\#354174>S. Narrante</color></b>: "Entro in osteria, e tutta l'attenzione è attorno al Vituzzo."
    ~ PersonaggioSx = "Avventore"
    ~ PersonaggioDx = "Vituzzo"
    <b><color=\#F3705B>Avventore</color></b>: "Spedalieri è un cornuto. Un giorno se la fa con Catania e un altro con Palermo. Di 'sto passo qua non cambia niente."
    <b><color=\#8193FF>Vituzzo</color></b>: "Cu zappa vivi acqua e cu futti vivi vinu. Perciò fottiamocene e beviamo, 'mbare!"
    <b><color=\#F3705B>Avventore</color></b>: "E certo, tu mica sei di Bronte. Qua ci vieni solo a bere e a scopare. Prova a camparci, a pagare tutte le tasse di quell'inglese di merda!"
    <b><color=\#8193FF>Vituzzo</color></b>: "'Mbare, ma io ti capisco. Ma 'ste cose è difficile farle da solo. Te l'ho mai raccontata di quella volta che m'ero imbarcato su una nave inglese e ci siamo ammutinati e quasi naufragavo in America?
        ~ PersonaggioSx = "S"
        * "Vituzzo, mica sei dietro ancora con quella storia inventata?"
        * "Vituzzo, tu manco sai legare una cima!"
        * "Vituzzo, ma almeno hai dormito?"
        -
        <b><color=\#8193FF>Vituzzo</color></b>: "S.! Ti posso offrire un boccale?"
        ~ PersonaggioSx = "S"
            * (solo) ["Vai col vino!"] "Sa che 'n po' de i. Di che parlavate?"
                <b><color=\#8193FF>Vituzzo</color></b>: "La mia nuova amica qui vuole fare la rivoluzione."
                ~ PersonaggioSx = "Avventore"
                <b><color=\#F3705B>Avventore</color></b>: "Vitu', muto!"
                <b><color=\#F3705B>Avventore</color></b>: "Se ti sente la persona sbagliata mi fai finire nei guai. Dico solo che qua non ce la facciamo più. Adesso pure con i soldati ci troviamo!"
                ~ PersonaggioSx = "S"
                    * * "Soldati?"
                    <b><color=\#8193FF>Vituzzo</color></b>: "Sì, sono arrivati da Catania e da Adernò e si sono accampati sulla Colla. Hanno già iniziato a saccheggiare fattorie e a scummattere femmine, i vastasi."
                        * * * "E nessuno fa niente?"
                        ~ PersonaggioSx = "Avventore"
                        <b><color=\#F3705B>Avventore</color></b>: "Per me li ha chiamati Thovez."
                        <b><color=\#F3705B>Avventore</color></b>: "Vuole spagnare chi ce l'ha con lui e con i suoi baronelli."
                        ~ PersonaggioSx = "S"
                        * * * * "Quell'uomo è peggio della sifilide."
                            <b><color=\#8193FF>Vituzzo</color></b>: "E senza il piacere, S.!"
            ~ PersonaggioSx = "S"                
            * "Un'altra volta, c'ho un po' di cose per la testa."
                <b><color=\#8193FF>Vituzzo</color></b>: "Tutto a posto?"
                * * "Io mi preoccupo per il bajo["] e la baja si preoccupa per me."
                    ~ PersonaggioSx = "Avventore"
                    <b><color=\#F3705B>Avventore</color></b>: "Cosa?"
                    <b><color=\#F3705B>Avventore</color></b>: "Che lingua parlate?"
                    ~ PersonaggioSx = "S"
                    * * * "Mi ci prendo cura di chi amo, e la cosa è reciproca."
                    <b><color=\#8193FF>Vituzzo</color></b>: "Non so come minchia fai, sei peggio di un giocoliere. A proposito, te l'ho mai raccontata di quella volta che facevo il domatore di cavalli per un circo?"
                        * * * * "Madóna mé, solo seicento volte, Vitu'!"
            -
            ~ PersonaggioSx = "S"
            * Comunque vedi di non tirare troppo l'alzana questa bernarda."
            ~ PersonaggioSx = "Avventore"
            <b><color=\#F3705B>Avventore</color></b>: "Voi due!"
            <b><color=\#F3705B>Avventore</color></b>: "Fate apposta?"
            ~ PersonaggioSx = "S"
            -
            * ["Vai a farti benedire!"]"A' söl'ostia!"
            <b><color=\#8193FF>Vituzzo</color></b>: "Dobbiamo tornare alla nave?"
            ~ Dialog_VituzzoInOsteria_Step += 1
            -
            + [Continui ad esplorare Bronte]"Non ancora, ma stai all'erta." -> DONE
            + [<b>Torni da Catena </b>]"Torno dalla vita mia, va!"
            ~ caricaScena("CameraInOsteria")
            -
            -> DONE
    
           


        = fallbackVituzzo
        ~ PersonaggioSx = "Vituzzo"
        ~ PersonaggioDx = ""
        <b><color=\#8193FF>Vituzzo</color></b>: {~"Non dico balle, io!"|"Ti ho raccontato di quella volta a Porto con due soldati e un leone?"|"Dai oste, offri da bere!"}
        + [Continui ad esplorare Bronte]"Stammi bene, Vitù!" -> DONE
        + [<b>Torni da Catena </b>]"Torno dalla vita mia, va!"
        ~ caricaScena("CameraInOsteria")
        -> DONE
            

=== Dialog_AvventoreOsteria
        ~ PersonaggioSx = "Avventore"
        ~ PersonaggioDx = ""
        <b><color=\#F3705B>Avventore</color></b>: {"Questa potrebbe essere la volta buona di farla pagare ai signori."|"Ma come fa Vituzzo ad avere sempre una storia per tutto?"|"Nella nuova Costituzione di sicuro daranno l'indipendenza anche a Bronte, no?" |"Di Martino dice di aspettare, ma aspettare quanto?"|"Se mio marito scopre che faccio invece di andare al mercato, m'uccide!"}
            -> DONE


//FATIMA MERCATO//
=== Dialog_FatimaMercato
{Dialog_FatimaMercato_Step:
- 0: -> discussioneArrotino
- else: -> fallbackFatima
}

= discussioneArrotino
~ PersonaggioSx = "SNarrante"

    <b><color=\#354174>S. Narrante</color></b>: "Se c'è qualcuna che non ha mai smesso di stupirmi, questa è quella fò de cò della Fatima."
    ~ PersonaggioSx = "Arrotino"
    ~ PersonaggioDx = "Fatima"
    <b><color=\#5da926>Arrotino</color></b>: "Ho detto che non voglio averci a che fare."
    <b><color=\#EF8F06>Fatima</color></b>: "Non capisco. Un mese fa non c'era nessun problema!"
    <b><color=\#5da926>Arrotino</color></b>: "Un mese fa non c'era in giro questa pazzia dell'indipendenza!"
    <b><color=\#EF8F06>Fatima</color></b>: "E che c'entro?"
    ~ PersonaggioSx = "S"
        * "Fatima, ti sei fatta un nuovo amico vedo!"
            <b><color=\#EF8F06>Fatima</color></b>: "Questo qua non vuole fare un lavoro."
            ~ PersonaggioSx = "Arrotino"
            <b><color=\#5da926>Arrotino</color></b>: "Non voglio farmi fucilare per aver aiutato rivoltosi."
            <b><color=\#5da926>Arrotino</color></b>:Sono un'uomo onesto io, fedele al Re!"
            ~ PersonaggioSx = "S"
            * * "Che c'entriamo noi con l'indipendenza?"
            ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Non lo so. Siete forestieri. Girano voci che non siete tanto raccomandabili."
                <b><color=\#5da926>Arrotino</color></b>: "E poi quelli non sono certo coltelli da tavola!"
                <b><color=\#EF8F06>Fatima</color></b>: "Perché lavoriamo in mare. Per questo non vedete tanto in paese, e coltelli servono per pesce."
            ~ PersonaggioSx = "S"
            * * "Il Thovez si fa chiamare <i>re</i>, ora?"
                ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Ma no, idiota. Ferdinando primo!"
                <b><color=\#5da926>Arrotino</color></b>: "Palermo vuole staccarsi da Napoli e fare da sé. Con una costituzione e tutto, dicono. Ma secondo me sono i palermitani che vogliono fare i nuovi padroni."
                <b><color=\#5da926>Arrotino</color></b>: "Speriamo che l'esercito dei Borbone arrivi presto a sistemare tutto!"
                ~ PersonaggioSx = "S"
                * * * "Tu sì che sei un òm coraggioso."
                <b><color=\#EF8F06>Fatima</color></b>: "Ho visto acciughe più tenaci."
            ~ PersonaggioSx = "S"    
            * * "Ho visto più persone oneste in un bordello che in un mercato!"
                ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Fuori di qui, via, o urlo aiuto.!"
                <b><color=\#5da926>Arrotino</color></b>: "Siete dei pezzenti!"
                <b><color=\#EF8F06>Fatima</color></b>: "Provaci solo e trasformo tua gola in una fontana, kafir!" //Kafit = miscredente, pagano.
                ~ PersonaggioSx = "S"
                * * * "Facciamoci due passi, Fatima."
        
        ~ PersonaggioSx = "S"
        * "Dimmi che non finisce mica come a Smirne."
            <b><color=\#EF8F06>Fatima</color></b>: "Selam S. e no, voglio solo comprare un nuovo coltelli, ma questo uomo non vuole tarì."
            ~ PersonaggioSx = "Arrotino"
            <b><color=\#5da926>Arrotino</color></b>: "Signore, la prego, non voglio casini!"
            <b><color=\#5da926>Arrotino</color></b>: "Voglio solo che gli sgherri di mr Thovez non se la prendano con me, sono solo un onesto commerciante fedele al Re!"
            <b><color=\#EF8F06>Fatima</color></b>: "Ti ho già detto che non rivoltosi!"
            ~ PersonaggioSx = "S"
            * * "In che senso, gli sgherri del Thovez?"
                ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Forestieri poco raccomandabili, dalle parti dei boschi."
                <b><color=\#5da926>Arrotino</color></b>: "Come voi, insomma, con quei coltellacci."
                <b><color=\#EF8F06>Fatima</color></b>: "Vuoi capire o no che stiamo nel mare? Con cosa spino un puzzoso pesce? Con una matita?"
            ~ PersonaggioSx = "S"
            * * "Il Thovez si fa chiamare "re" ora?"
                ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Ma no, idiota. Ferdinando primo!"
                <b><color=\#5da926>Arrotino</color></b>: "Palermo vuole staccarsi da Napoli e fare da sé. Con una costituzione e tutto, dicono. Ma secondo me sono i palermitani che vogliono fare i nuovi padroni."
                <b><color=\#5da926>Arrotino</color></b>: "Speriamo che l'esercito dei Borbone arrivi presto a sistemare tutto!"
                ~ PersonaggioSx = "S"
                * * * "Tu sì che sei un òm coraggioso."
                <b><color=\#EF8F06>Fatima</color></b>: "Ho visto più tenaci acciughe."
            ~ PersonaggioSx = "S"    
            * * "Ho visto più persone oneste in un bordello che in un mercato!"
                ~ PersonaggioSx = "Arrotino"
                <b><color=\#5da926>Arrotino</color></b>: "Fuori di qui, via, o urlo aiuto.!"
                <b><color=\#5da926>Arrotino</color></b>: "E accorreranno tutti!"
                <b><color=\#EF8F06>Fatima</color></b>: "Provaci solo e trasformo tua gola in una fontana, <i>kafir</i>!" //Kafit = miscredente, pagano.
                ~ PersonaggioSx = "S"
                * * * "Facciamoci due passi, Fatima."
                ~ ArrotinoMercato = false
        
        ~ PersonaggioSx = "S"    
        * [Resti a guardare.] "Questa l'è divertente."
        ~ PersonaggioSx = "Arrotino"
            <b><color=\#5da926>Arrotino</color></b>: "Tutti i forestieri sono pericolosi, di questi tempi. Troppe idee strane, troppo trambusto!"
            <b><color=\#EF8F06>Fatima</color></b>: "Uomo, voglio solo coltelli per spinare tonni e grosso pesci. Hai paura che ti tagli orecchi?"
            <b><color=\#5da926>Arrotino</color></b>: "Miscredenti, tutti uguali siete. Voi e il vostro Dio sbagliato. C'è un solo Re, un solo Dio."
            <b><color=\#EF8F06>Fatima</color></b>: "E un solo arrotino. È una questione di soldi?"
            <b><color=\#5da926>Arrotino</color></b>: "No! Voglio solo evitare problemi coi soldati di Thovez, col Re. Non devo immischiarmi in casini con rivoltosi che vogliono una repubblica o robe così. L'abbiamo già visto anni fa, com'è andata."
            <b><color=\#EF8F06>Fatima</color></b>: "Certo, come se al Re interessasse questo buco di culi che è Bronte. Strozzatici, con la codardia!"
            <b><color=\#EF8F06>Fatima</color></b>: "S., da quanto ascoltavi?"
                ~ PersonaggioSx = "S"
                * * "L'hai massacrato quell'òm!"
                <b><color=\#EF8F06>Fatima</color></b>: "Naa, più tardi tornerò e ruberò quella jambiyya."
                * * * "Facciamo due passi per il mercato?"
                ~ ArrotinoMercato = false
    -
   
        <b><color=\#EF8F06>Fatima</color></b>: "Maledetto, è unico kiosque di bene affilato coltelli in tutta Bronte!"
        * "È strano vederti in giro senza l'Amine."
            <b><color=\#EF8F06>Fatima</color></b>: "È ancora in Taormina. Trovare un bravo maestro d'asce è più difficile del previsto, soprattutto appena si dice che facciamo le corsari."
            <b><color=\#EF8F06>Fatima</color></b>: "Volevo rimanere anch'io, ma ha insistito che venissi qui. A rilassarmi, ha detto."
            * * "Smollare un po' a volte aiuta."
                <b><color=\#EF8F06>Fatima</color></b>: "Momento in cui smetti di prepararti è quello in cui ti colgono di sorpresa, S. E poi prepararmi, sapere di avere più possibile cose sotto il mio controllo, è mio modo di rilassarmi."
                <b><color=\#EF8F06>Fatima</color></b>: "Tu piuttosto, hai una faccia di uno che deve riposare!"
                 * * * "L'Isaac è nei casini[."], nei casini col Thovez."
                 * * * "Ho discusso con vita mia.["] So che mi ama, ma che testarda che è!"
                 * * * "Sì eh. Va tutto bene, sento solo la tensione della città, credo."
        -
    <b><color=\#EF8F06>Fatima</color></b>: "S., sai che faccio schifo a parlare. Ma se c'è da stagliuzzare qualcuna, conta su di me."
        * "Grazie Fatima, davvero."
        -
        * "Ma quel coltello, era davvero per il pesce?"
        <b><color=\#EF8F06>Fatima</color></b>: "No, per la prossima volta che metto mie mani tizio di Smirne. Detto che l'avrei ucciso."
        ~ Dialog_FatimaMercato_Step += 1
        -
        + [Continui ad esplorare Bronte]"Sono felice che mi hai perdonata o a quest'ora sarei morta. A dopo Fatima."-> DONE
        + [<b>Torni da Catena </b>]"Torno dalla vita mia, va!"
        ~ caricaScena("CameraInOsteria")
        - 
        -> DONE

    = fallbackFatima
    ~ PersonaggioSx = "Fatima"
    ~ PersonaggioDx = ""
        <b><color=\#EF8F06>Fatima</color></b>: "{~ Non mi aspettavo di trovare succosi dattero, qui.|Questo mercato davvero carino.|Ma qualcuno ha insegnato a questi bambini a difendersi?}"
        + [Continui ad esplorare Bronte]"A dopo amica mia."-> DONE
        + [<b>Torni da Catena </b>]"Torno dalla vita mia, va!"
        ~ caricaScena("CameraInOsteria")
        - 
        -> DONE

=== Dialog_ArrotinoMercato
~ PersonaggioSx = "Arrotino"
~ PersonaggioDx = ""

    <b><color=\#5da926>Arrotino</color></b>: {~ "Si stava meglio prima che i francesi inventassero la rivoluzione, dico." |"Cu si fa li fatti so’, campa cent’anni."|"Certo che quella berbera mi porta sempre dei bei coltelli da affilare. Acciaio damasco, il migliore!"}
        -> DONE

-> DONE

=== Dialog_IsaacMercato
{
- not inizioIsaac: -> inizioIsaac
- else: -> fallbackIsaac
}

= inizioIsaac
~ PersonaggioSx = "S"
~ PersonaggioDx = "Isaac"
    <color=\#354174>Isaac</color>: "S.! Che ci fai qui, amore?""
        * "Isaac! Ero venuto per la Fatima!"
            <color=\#354174>Isaac</color>: "Finalmente ha amazato qualcuno?"
        * "Amore, che bello! Volevo svagarmi un attimo."
            <color=\#354174>Isaac</color>: "Certo, tu che puoi a svagarti."
        * "Tu che ci fai qui, piuttosto?"
            <color=\#354174>Isaac</color>: "Ehi, non trattare a me come uno degli tuoi marinai!"
        -
    <color=\#354174>Isaac</color>: "Anyway yes, sto bene anche io, grazie per averlo chiesto a me!"
        * "Stavo per farlo!"
        * "Ma non mi hai mica chiesto tu come sto."
        * "Che ti hanno finalmente fatta regina?"
        -
    <color=\#354174>Isaac</color>: "Io sto benone davero, anche perché stasera andrò a una festa, uno VERA festa."
    <color=\#354174>Isaac</color>: "E vorei portare something shocking!"
    <color=\#354174>Isaac</color>: "Ma qui c'è solo roba di capra, frutta e pacotagli."
        * "Una festa?"
        -
    <color=\#354174>Isaac</color>: "<i>Quel</i> tipo di festa, amore. Comunque ora devo asolutamente trovare qualcosa!"
    <color=\#354174>Isaac</color>: "Passa a salutare a me prima di cena!"
    
        + "Mi fo due passi amore, a dopo!"
        - 
        -> DONE    
    
= fallbackIsaac    
~ PersonaggioSx = "Isaac"
~ PersonaggioDx = ""

    <color=\#354174>Isaac</color>: "{~ Altra roba di capra!|Forse Henry aprezerebe del pesce fresco?|Lady Caroline potrebe usare questo macinino per i momenti di solazzo.|Mi scusi, quanto viene questo...cosa è, <i>questo</i>?|Salve giovine, è la prima volta che la vedo in Bronte. Vuoi venire alla festa?|Signora, mi facia un sorriso! La vita non può essere così bruta!}
        + [Continui ad esplorare Bronte]"Mi fo due passi amore, a dopo!"-> DONE
        + [<b>Torni da Catena </b>]"Torno da Catena, ci vediamo domani!"
        ~ caricaScena("CameraInOsteria")
        - 

        -> DONE

//CHIESA GORAN//
=== Dialog_GoranChiesa
 
{Dialog_GoranChiesa_Step:
- 0: -> discussionePrete
- else: -> fallbackGoran
}

= discussionePrete
    
    ~ PersonaggioSx = "SNarrante"
    <b><color=\#354174>S.Narrante</color></b>: "Entro in Chiesa, e c'è il Goran che tira giù bestemmie al don Gianni."
    ~ PersonaggioSx = "Prete" 
    ~ PersonaggioDx = "Goran"
    <b><color=\#4B4747>Goran</color></b>: "Cristo era sempre schierato coi poveri."
    <b><color=\#979797>Prete</color></b>: "Ma non ha mai detto di prendere le armi e lottare! Ci sono modi migliori di risolvere la situazione."
    <b><color=\#4B4747>Goran</color></b>: "Io non dico spararsi prete ma agire, fare qualcosa invece che riempire stanza di incenso!"
        ~ PersonaggioSx = "S" 
        * ["Tutto bene Goran?"]"La a bé, Goran?"
            <b><color=\#4B4747>Goran</color></b>: "Nie! Questo pisto crede che se chiediamo gentilmente a Thovez lui smette di essere stronzo con persone del paese per questione del legno!"
            ~ PersonaggioDx = "Prete"
            <b><color=\#979797>Prete</color></b>: "Voi fate bestemmiare i santi!"
            <b><color=\#979797>Prete</color></b>: "Non c'è alcuna questione del legno!"
            ~ PersonaggioDx = "Goran" 
            <b><color=\#4B4747>Goran</color></b>: "E non ci sono nemmeno qualche persone così, nie nie. Vuoi tu qualcosa S.?"
        * ["Come sta, don Gianni?"]"La a bé, don Gianni?"
            ~ PersonaggioDx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "Con un grosso mal di testa in arrivo."
            ~ PersonaggioDx = "Goran" 
            <b><color=\#4B4747>Goran</color></b>: "Sai prete che ho ragione, tu dammi la ragione e vedi che niente mal di testa."
            ~ PersonaggioDx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "Ma tu vuoi metterti contro Philip Thovez!"
            ~ PersonaggioDx = "Goran"
            <b><color=\#4B4747>Goran</color></b>: "No, voglio solo risolvere questione del legno. Gente non deve morire di freddo per Thovez!"
            ~ PersonaggioDx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "Non c'è alcuna questione del legno!"
            ~ PersonaggioDx = "Goran" 
            <b><color=\#4B4747>Goran</color></b>: "E non ci sono nemmeno qualche persone così, nie nie. Serve qualcosa S.?"
        * [Resti in silenzio.]"Questo è uno spettacolo."
            ~ PersonaggioSx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "Se non fosse per la chiesa, un sacco di gente qui morirebbe di fame!"
            ~ PersonaggioDx = "Goran" 
            <b><color=\#4B4747>Goran</color></b>: "Ma loro moriranno di freddo se Thovez non smette di essere stronzo con persone del paese per questione del legno!"
            ~ PersonaggioSx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "Non c'è alcuna questione del legno!"
            ~ PersonaggioDx = "Goran" 
            <b><color=\#4B4747>Goran</color></b>: "E non ci sono nemmeno qualche persone , nie nie. Tu S. vuoi qualcosa?"
        -
    ~ PersonaggioSx = "S" 
        * "Solo di un po' di pace["]. Forse torno a fare due passi. L'aria l'è calda, tieniti le tue cose importanti vicine."
            <b><color=\#4B4747>Goran</color></b>: "Dio è sempre con me, a differenza di prete."
            ~ PersonaggioSx = "Prete" 
            <b><color=\#979797>Prete</color></b>: "La prego S., se lo porti via!"
            ~ PersonaggioSx = "S" 
            <b><color=\#354174>S.</color></b>: "Pota! E togliergli un po' di divertimento? Sarebbe poco cristiano, don Gianni!"
        * "Cosa l'è 'sta roba del legno?"
            <b><color=\#4B4747>Goran</color></b>: "Thovez vieta l'uso del bosco le persone, e niente legna uguale freddo e morte d'inverno. Ora lui vuole pure che tagliano il bosco per quello, per metterci delle piante per i soldi di lui!"
            * * "Che pezzo di!"
                <b><color=\#4B4747>Goran</color></b>: "Sì. E prete qui difende lui!"
                ~ PersonaggioSx = "Prete" 
                <b><color=\#979797>Prete</color></b>: "Non lo difendo, ma non si può parlare con te!"
                <b><color=\#4B4747>Goran</color></b>: "No se dici cazzate."
                ~ PersonaggioSx = "S" 
                * * * "Don Gianni, come se la passa la gente?"
                 ~ PersonaggioSx = "Prete" 
                <b><color=\#979797>Prete</color></b>: "Male. Ma non..."
                <b><color=\#4B4747>Goran</color></b>: "Allora tu fare qualcosa, noi. Assieme! Per Cristo!"
                * * * "Goran, c'abbi pazienza!"
                <b><color=\#4B4747>Goran</color></b>: "Nie, niente pazienza qui. Gente morirà di freddo, S.!"
                <b><color=\#979797>Prete</color></b>: "No, se cerchiamo una soluzione invece di urlare!"
                * * * * "Credo vi lascerò al vostro divertimento, s'cèti!"
        -
        ~ Dialog_GoranChiesa_Step += 1
        ~ PersonaggioSx = "S" 
        * ["Stai lontano dai casini, Goran!"] "Sta lontano da bracchi e casini, Goran."
                ~ PersonaggioDx = "Goran" 
                <b><color=\#4B4747>Goran</color></b>: "E dov'è il divertimento, poi, S.?"
        -
        
        + [Continui ad esplorare Bronte]"Goran, ci vediamo dopo la festa di stasera, non mi     fare casini."
                "Nie, io e prete amici alla fine, tu vedi. A stasera!" -> DONE
        + [<b>Torni da Catena </b>]"Torno da Catena, ci vediamo domani!"
        ~ caricaScena("CameraInOsteria")
        - 
        -> DONE
        
        
        = fallbackGoran
        ~ PersonaggioSx = "Goran"
        ~ PersonaggioDx = ""
        <b><color=\#4B4747>Goran</color></b>: "{~Testardo di un prete!|Tuo Dio più severo di diavolo.|No ora S., no ora.}"
        + [Continui ad esplorare Bronte]"Non strappazzare troppo il prete, Goran." -> DONE
        + [<b>Torni da Catena </b>]"Torno da Catena, ci vediamo domani!"
        ~ caricaScena("CameraInOsteria")
        - 
        -> DONE

=== Dialog_PreteChiesa
~ PersonaggioSx = "Prete"
~ PersonaggioDx = ""
    
    <b><color=\#979797>Prete</color></b>: {"Passano gli anni, ma Goran rimane un mezzo pagano."|"Gente come lui sarebbe in guerra contro tutti, sempre."|"Devo ricordarmi di chiedere alla perpetua di ripulire la canonica."|"Quest'anno siete mancato alla celebrazione di San Biagio, S."| "E non vi confessate da troppi mesi."| "Chissà cosa pensa Dio del vostro operato."| "Ma innegabilmente fate tanto per questo paese, davvero tanto."| "Certo, poi i vostri amici sono discutibili, a volte."| "Ma Goran è pure un bravo ragazzo, non fosse così testardo!"}
        -> DONE

=== Dialog_ThovezChiesa
{
- not inizioThovez: -> inizioThovez
- else: -> fallbackThovez
}

= inizioThovez
~ PersonaggioSx = "S"
~ PersonaggioDx = "Thovez"
    <b><color=\#81482e>Thovez</color></b>: "Lady S.! Non pensavo fosse religiosa!"
        * "Mai stato religioso."
        * "Mai stato una lady, Philip."
        * "Mai stato una donna, Thovez."
        -
    <b><color=\#81482e>Thovez</color></b>: "Ah, adoro il suo spirito così sottile e popolare assieme!"
    <b><color=\#81482e>Thovez</color></b>: "Dovrei parlare con don Carlo, ma è da ore con quel, con quel..."
        * "Pirata?"
        * "Gentiluomo?"
        * "Goran?"
        -
    <b><color=\#81482e>Thovez</color></b>: "Plebeo. E pure straniero. Insomma: c'è la nostra cena stasera e il prete non può mancare. E non mancherete, vero, milady?"
        * "La tua lettera non lo permetteva."
        * "Ho sempre amato l'idea di una sera tra mummie."
        * "Mi hanno invitato a un'autoflagellazione, e sembra più divertente."
        -
    <b><color=\#81482e>Thovez</color></b>: "Come siete spassosa, davvero. Dovreste venire più spesso, amica mia."
    <b><color=\#81482e>Thovez</color></b>: "E se stasera va come desidero, accadrà davvero."
    <b><color=\#81482e>Thovez</color></b>: "Ma ora lasciatemi guardare torvamente don Carlo, in modo che si sbrighi."
        * "C'hai uno strano modo di divertirti."
        * ["Ti prego Signore, portami via!"]"Signùr töim sö!"
        * "Ma che traumi c'hai avuto da piccolo, Philip?"
        -
    <b><color=\#81482e>Thovez</color></b>: "Sì sì sì a dopo milady!"    
    
-> DONE

= fallbackThovez
~ PersonaggioSx = "Thovez"
~ PersonaggioDx = ""
    <b><color=\#81482e>Thovez</color></b>: "{~Sono abbastanza sicuro di aver sentito il mio nome!|Ma com'è vestito poi quel brigante?|Certo che se il vescovo sapesse di don Carlo, delle sue amicizie...|Devo chiedergli di benedire Henry, forse così guarirà.|Certo che questo crocifisso è proprio tristo.|La perpetua mi guarda con astio, vero? Perché mi guarda con astio?|Dio, quanto puzza questo paese, che odio!}"
    
        + [Continui ad esplorare Bronte]"Ci si vede, Philip." -> DONE
        + [<b>Torni da Catena </b>]"Torno da Catena, a stasera, ahimè."
        ~ caricaScena("CameraInOsteria")
        - 
        -> DONE   