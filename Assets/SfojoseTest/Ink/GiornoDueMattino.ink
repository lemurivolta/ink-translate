//CASA ISAAC

=== Dialog_CatenaCasaIsaacInterno
{
- Dialog_IsaacCasaIsaacInterno_Step == 0:-> IlPiano
- Dialog_IsaacCasaIsaacInterno_Step == 1 && not Intimita: -> Intimita
- Dialog_IsaacCasaIsaacInterno_Step == 1 && Intimita: -> fallbackCatena
- else: -> DopoLaPartita
}
    
    = IlPiano
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
    
    <b><color=\#3a6954>Catena</color></b>: {~ {CristinaWin: "Perché poi il tetto di paglia?"|"La tengo sott'occhio la suora, sappilo. Se ti fa qualcosa, è morta!"}|"Parla col pupo che ho un sonno bestia!"|"Certo che Isaac si mantiene bene!"|"Ecco dove era finito il mio khanjar!"|{CristinaWin: "Forse dovevamo salvare Cristina, insistere."|"Dio che civetta che è quella Cristina!"}|"Se vado a rubare qualcosa in cucina si offende?"}
    -> DONE
    
    
    = Intimita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
        <b><color=\#3a6954>Catena</color></b>: "Sai che voglio bene a quel garruso, vero?"
            * "Sì eh!"
            * "Anche quando lo insulti?"
            <b><color=\#3a6954>Catena</color></b>: "Soprattutto quando lo insulto!"
            * "E lui ce ne vuole a te."
            -
        <b><color=\#3a6954>Catena</color></b>: "Questo suo modo di fare però è una stronzata, questa roba del "sono inglese ed elegante e non ho paura di nulla". Ha fifa, cuoricì, fifa nera."
            * "Cosa mi suggerisci di fare?"
            -
        <b><color=\#3a6954>Catena</color></b>: "Fallo parlare. Cerca di capire che gli gira nella capoccia, perché sennò questo fa una stronzata di sicuro, quanto è vero Iddio."
            * "Spero davvero si fida di me."
            -> DONE
    
    = fallbackCatena
    ~ PersonaggioSx = "Catena"
    ~ PersonaggioDx = ""
        <b><color=\#3a6954>Catena</color></b>: "{~ {CristinaWin: Ti ho già detto che ho fame?|Guarda come si atteggia, quella. Una suora, certo. E io sono un prete. No, un vescovo!}|Ma te la ricordi la festa di Natale qui, coi tre alani e Giappone?|Un giorno o l'altro ci devo portare Amine.|Ma a una certa dobbiamo farci anche noi una casa? Allargare questa?|Non sono una da pupi, però un paio di puledri li terrei volentieri.|Ho deciso, appena riesco affronto la cucina.}"
    
    -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Catena"
    
      <b><color=\#3a6954>Catena</color></b>: "{Ci avviamo?|Sei pronto?|Ci togliamo questo dente?|Leghiamo Isaac in casa e poi partiamo?}"
        + "{CristinaWin:Fammi parlare con Isaac.|Fammi parlare con le altre due.}"
            <b><color=\#3a6954>Catena</color></b>: "{CristinaWin: Su, che voglio scaldarmi le mani.|Quella Cristina c'ha la faccia di una che ti rincoglionisce a dovere.}"
            -> DONE
        * [<b>Prepara il deck prima di andare da Thovez</b>]
        "Sistemo due cose e ci sono."
        -
        ~ caricaAtto("DeckBuilding")
        ~ caricaDeckBuilding()
        @
        ~ caricaAtto("GiornoDueSera")
        ~ caricaScena("CasaThovezAmministrazione")
        -> DONE
    

=== Dialog_CristinaCasaIsaacInterno
{
- Dialog_IsaacCasaIsaacInterno_Step == 0:-> IlPiano
- Dialog_IsaacCasaIsaacInterno_Step == 1: -> Intimita
- else: -> DopoLaPartita
}
    
    = IlPiano
    ~ PersonaggioSx = "Cristina"
    ~ PersonaggioDx = ""
    
    <b><color=\#6d282a>Cristina</color></b>: {"Come si mangiò bene qui, alla festa di novembre!"|"La cultura di Isaac è sterminata. Chissà cosa ne pensa delle idee del Foscolo."|"Questo vestito mi soffoca."| "Ti ricordi di quando facesti quella rapina per me, su a Bologna?"| {CatenaWin: "La tua amica è molto diretta, vero?"|"Poi mi presenti per bene la tua amica?"}| "Chissà cosa farà Philip quando si accorgerà che sono scomparsa."}
    
    -> DONE
    
    
    = Intimita
    ~ PersonaggioSx = "Cristina"
    ~ PersonaggioDx = ""
        <b><color=\#6d282a>Cristina</color></b>: "{Portami con te. So che può sembrarti assurda come idea, ma conosco bene quella casa.|Una volta lì dentro, posso chetare cuoca e sgherri.|E se c'è in giro il Torrisi, quel maiale ha un debole per me.|Se mia madre mi vedesse ora, le verrebbe un infarto.|O forse no, penserebbe solo alle cose che non ha fatto lei.|A quello che non hanno vissuto le mie sorelle.|La vita è così strana, S.}"
        -> DONE
        
  
    -> DONE
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Cristina"
    
        <b><color=\#6d282a>Cristina</color></b>: "{Quindi? Assaltiamo casa Thovez?|Non vedo l'ora di tirargli due pugni.|Ma come vogliamo spaventarlo? Posso fare la voce di Dio che lo giudica?!?|Che ne dici, partiamo?}"
        + "Parlo un attimo con le altre e andiamo." -> DONE
        * [<b>Prepara il deck prima di andare da Thovez</b>]
        "Mi preparo e ci sono."
        -
        ~ caricaAtto("DeckBuilding")
        ~ caricaDeckBuilding()
        @
        ~ caricaAtto("GiornoDueSera")
        ~ caricaScena("CasaThovezAmministrazione")
    -> DONE


/* ---------------------------------

                ISAAC

 ----------------------------------*/

=== Dialog_IsaacCasaIsaacInterno
{
- Dialog_IsaacCasaIsaacInterno_Step == 0: -> IlPiano
- Dialog_IsaacCasaIsaacInterno_Step == 1: -> Intimita
- Dialog_IsaacCasaIsaacInterno_Step == 2 && not DopoLaPartita: -> DopoLaPartita
- Dialog_IsaacCasaIsaacInterno_Step == 2 && DopoLaPartita: -> fallbackIsaac
}
    
    = IlPiano
   
        ~ PersonaggioSx = "SNarrante"
        <b><color=\#354174>S. Narrante</color></b>: "A distanza di tutti questi anni, continuo a chiedermi se avrei potuto gestire quella mattina in modo diverso. In qualsiasi altro modo."
        ~ PersonaggioSx = "S"
        ~ PersonaggioDx = "Isaac"
        <b><color=\#3a6954>Catena</color></b>: "Isaac, calmati!"
        <b><color=\#354174>Isaac</color></b>: {ThovezWin: "Come hai potuto provare a stringere un accordo con lui?!?"|"Come hai potuto stringere un accordo con lui?!?"}
            * "Dovevo proteggerti, Isaac!"
            * "Mi serviva tempo."
            * "Cos'altro avrei dovuto fare, pota?"
            -
        <b><color=\#354174>Isaac</color></b>: "Tu lo vedi che è tuto esagerato? Thovez non ha niente di concreto. Il suo è solo uno bluff."
        {not CristinaWin:
        ~ PersonaggioDx = "Cristina"
        }
        {not CristinaWin:
        <b><color=\#6d282a>Cristina</color></b>: "Philip è troppo ignorante per saper bluffare."
        }
        ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Aranci aranci cu l'avi si li chianci..." //se ho inteso bene, si traduce come "hai voluto la bicicletta, pedala"
        ~ PersonaggioDx = "Isaac"
        <b><color=\#354174>Isaac</color></b>: "Tu ce l'hai con me, Catena?"
        
            * "Vita mia ne abbiamo già parlato."
                <b><color=\#354174>Isaac</color></b>: "Parlato di cosa?"
                * * "Lo sa lei."
                - -
            * "Sa qualcosa, fidati."
            - 
            <b><color=\#354174>Isaac</color></b>: "Sempre ad esagerare."
            * "Dice che smaneggi col tuo muto[."], e che mezzo paese conosce il tuo culo." //smaneggiare = scopare //muto = servitore.
                <b><color=\#354174>Isaac</color></b>: "In Inghilterra non uno prenderebe su serio quelo che ha da dire un plebeo. Visto che vuole alla nobiltà, Thovez dovrebe saperlo."
                * * "Ti ricordo che stai parlando con un pezzente[."], sua egregia reverenzosa maestà milord."
                    <b><color=\#354174>Isaac</color></b>: "Io sto solo dicendo che è così che funzionano la cose. Io ho le mie idee e tu le tue, lo sapiamo."
            * "Sa che vai a cavazzonar coi tuoi amici ricchi[."], belli e non sposati." //cavazzonar = farsi bello
                <b><color=\#354174>Isaac</color></b>: "I miei amici sono anche suoi feudatari. Sono i soli con abastanza soldi da afitare le sue terre. Non avrebe senso per Thovez condannare loro. Deve esserci altro. Shit!"
            * "A un certo punto l'ha citato l'Alfonso." 
                 ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Ti avevo detto di non fidarti di quel mmirdiscu!" //mmirdiscu: frocia attiva
                 ~ PersonaggioDx = "Isaac"
                <b><color=\#354174>Isaac</color></b>: "Un marinaio! Nelle molly houses della  Londra ci sono più marinai di intera Marina Britannica. Io me stesso ne avrò abordato uno o due velieri! 
                    * * "Questo è pronto a fotterti, Isaac[."] Prendi le cose seriamente una volta tanto!"
                    ~ PersonaggioDx = "Isaac"
                    <b><color=\#354174>Isaac</color></b>: "La serietà è l'unico crimine che non sarò disposto nel commettere, my love. E comunque se Thovez si è mantenuto vago, alora non ha niente sul di mio."
            -
         ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Comunque vada, dobbiamo far qualcosa."
         ~ PersonaggioDx = "Isaac"
        <b><color=\#354174>Isaac</color></b>: "E cosa?"
         ~ PersonaggioDx = "Catena"
        <b><color=\#3a6954>Catena</color></b>: "Andiamo a casa sua. Stanotte. Gli facciamo prendere uno spavento di quelli potenti, così capisce che non deve pigliare per il culo."
        ~ PersonaggioDx = "Isaac"
        <b><color=\#354174>Isaac</color></b>: "È una follia!"
        {not CristinaWin:
        ~ PersonaggioDx = "Cristina"
        }
        {not CristinaWin:
        <b><color=\#6d282a>Cristina</color></b>: "È un'ottima idea. È così orgoglioso che non se l'aspetterà."
        }
            * "Ci serve un modo per entrare."
                {not CristinaWin:
                ~ PersonaggioDx = "Cristina"
                }
                {not CristinaWin:
                <b><color=\#6d282a>Cristina</color></b>: "Posso aiutarvi, conosco strada e accessi!"
                }
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Abbiamo fatto incursioni peggiori, cuoricì!"
            * "Solo quando l'Isaac è al sicuro."
                {not CristinaWin:
                ~ PersonaggioDx = "Cristina"
                }
                {not CristinaWin:
                <b><color=\#6d282a>Cristina</color></b>: "No, serve agire subito o ci fregherà!"
                }
                ~ PersonaggioDx = "Catena"
                {not CristinaWin:
                <b><color=\#3a6954>Catena</color></b>: "Parli così perché c'hai la fregola di partire!"
                }
                {not CristinaWin:
                ~ PersonaggioDx = "Cristina"
                }
                {not CristinaWin:
                <b><color=\#6d282a>Cristina</color></b>: "Ti fiderai mai di me?"
                }
                ~ PersonaggioDx = "Catena"
                {not CristinaWin:
                <b><color=\#3a6954>Catena</color></b>: "Manco morta."
                }
                ~ PersonaggioDx = "Isaac"
                <b><color=\#354174>Isaac</color></b>: "Io non sono un bambino."
                * * "Non ne son sempre sicuro."
                * * "Ma il rischio rimane."
            * "Non mi ci sembra una gran mossa."
                {not CristinaWin:
                ~ PersonaggioDx = "Cristina"
                }
                {not CristinaWin:
                <b><color=\#6d282a>Cristina</color></b>: "Ma è l'unica sensata. Va fregato sul tempo."
                }
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Cuoricì, da quand'è che ragioni prima di fare le cose?"
                * * "Da quando c'è in rischio la vita di qualcuno a cui tengo."
                ~ PersonaggioDx = "Isaac"
                <b><color=\#354174>Isaac</color></b>: "Non essere dramatico, S. Io non morirò, non oggi."
                ~ PersonaggioDx = "Catena"
                <b><color=\#3a6954>Catena</color></b>: "Se continui con questo atteggiamento da picciriddu, ti uccido io."
            -
        * "E quale l'è il piano?"
            ~ PersonaggioDx = "Catena"
            <b><color=\#3a6954>Catena</color></b>: "Recuperiamo due persone sveglie del gruppo tipo Goran e Fatima, e passiamo dal retro. C'è sempre un retro."
            {not CristinaWin:
            ~ PersonaggioDx = "Cristina"
            }
            {not CristinaWin:
            <b><color=\#6d282a>Cristina</color></b>: "Vengo con voi. So come farvi entrare senza fatica."
            }
            ~ PersonaggioDx = "Isaac"
            <b><color=\#354174>Isaac</color></b>: "E io intanto me ne sto nello posto sicuro."
        -
        * "Voglio rifletterci un poco.["] Parlo con uno alla volta di voi ora, che mi avete fatto venire il mal di testa."

         ~ Dialog_IsaacCasaIsaacInterno_Step += 1
        -> DONE
    
    
    = Intimita
        ~ PersonaggioSx = "S"
        ~ PersonaggioDx = "Isaac"
        
            <b><color=\#354174>Isaac</color></b>: "S..."
        * ["Come stai?"]"La a bé, Isaac?"
            <b><color=\#354174>Isaac</color></b>: "Come uno con la zanzara dentro l'orecchio. Maledeto Thovez!"
        -
        * "Non ti ho detto una cosa, prima[."]: nella lettera ti ha chiamato lady Isabel."
            <b><color=\#354174>Isaac</color></b>: "My god, non quelo! Se sa di quela facenda io sono finito. Pensavo che andarmene da Londra sarebe bastato. Mi sento svenire."
        -
        * "Lo vuoi un abbraccio, tesoro?"
            <b><color=\#354174>Isaac</color></b>: "Yes, please!"
            <b><color=\#354174>Isaac</color></b>: "Che abiamo fatto di male, S.? Perchè la vita è così dificile con noi?"
            * * "Perché non ci piacciono mica i loro compromessi[."], che è anche la cosa che ci rende interessanti, non trovi?"
            <b><color=\#354174>Isaac</color></b>: "Grazie, S. Sei la mia roccia."
            * * "Perché vogliamo vivercela 'sta vita[."], invece a questi la loro ci fa schifo, e vogliono viversi la nostra."
                <b><color=\#354174>Isaac</color></b>: "Ed è nostro sacro dovere sbatergli in facia il piaccere. Ti ricordi ancora come si fa?"
                    * * * "Me lo ha insegnato un certo inglese tenero e ubriacone[."], che alla fine me lo sono pure sposato."
                        <b><color=\#354174>Isaac</color></b>: "Tu hai sempre avuto buon gusto, S."
            * * "Un po' ci cacciamo in 'sti casini, però.["] Sembra che la tranquillità ci venga a noia.
                <b><color=\#354174>Isaac</color></b>: "Poi altrimenti in cosa spetegoliamo?"
        -
        
        * "Isaac, mi ci serve sapere cosa sta succedendo."
        -
        <b><color=\#354174>Isaac</color></b>: "Devi accettare la sua oferta di Thovez, S. Falo per me."
            * "Mettendo nei guai gli abitanti di Bronte?"
            <b><color=\#354174>Isaac</color></b>: "To hell with Bronte! Io sono tuo marito. Io non conto forse più di quegli quatro pastori?"
            * "No, non mi farò fregare dal Thovez.["] Troveremo un'altra soluzione, ma non questa."
            <b><color=\#354174>Isaac</color></b>: "Non sai cosa mi aspeta se mi riportano a casa, S. Se ho fortuna mi decapiterano invece di impicarmi, dato il mio status."
            <b><color=\#354174>Isaac</color></b>: "Se invece decidono di fare di me uno esempio mi incatenerano nella piazza. Non hai idea di quanto piacia agli popolan mettere le mani su uno lord in piena impunità."
            * "Dimmi con cosa ti sta ricattando[."], e poi deciderò che fare."
            -
            ~ Dialog_IsaacCasaIsaacInterno_Step += 1
            ~ caricaPartita("Isaac")
            @
        
            -> DopoLaPartita
    
    
    = DopoLaPartita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
    {
    - IsaacWin:
    -> Distacco
    - not IsaacWin:
    -> Sincerita
    }
    
    
    
    = Distacco
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
    
        <b><color=\#354174>Isaac</color></b>: "Io vado a prepararmi."    
        * "Non andarai mica dai Mancuso!"
            {Partita_Isaac_Seduzione: 
            <b><color=\#354174>Isaac</color></b>: "Se non lo facesi farei vincere il Thovez, farei vincere quella marinaia!"
            }
            {Partita_Isaac_Zuffa: 
            <b><color=\#354174>Isaac</color></b>: "Yes. Così tu non devi pensare a protegermi!"
            }
            * * "Ma ta se' fò de cò? È questo il posto sicuro di cui parlavi?!?!"
            <b><color=\#354174>Isaac</color></b>: "Sempre meglio che restare qui ad aspetare Philip Thovez e gli suoi sgherri!"
            * * "Isaac, non abbiamo ancora finito di parlare!"
            <b><color=\#354174>Isaac</color></b>: "Finiremo quando io sarò tornato."
            * * "Sai che ti fermerò[."], ma questa è una enorme cazzata, Isaac."
            <b><color=\#354174>Isaac</color></b>: "Almeno io morirò facendo qualcosa che amo."
        -
       <b><color=\#354174>Isaac</color></b>: "Non devi forse andare a fare la tua incursione?"
            + "{CristinaWin:Fammi parlare con Catena un attimo.|Fammi parlare con le altre due.}" -> DONE
            * [<b>Prepara il deck prima di andare da Thovez</b>]
                "Ce ne andiamo. Ci vediamo domattina?"
                <b><color=\#354174>Isaac</color></b>: "Per domattina spero di essere nudo e ubriaco marcio nelle braccia di un stupido boscaiolo."
            ~ caricaAtto("DeckBuilding")
            ~ caricaDeckBuilding()
            @    
            ~ caricaAtto("GiornoDueSera")
            ~ caricaScena("CasaThovezAmministrazione")
    -> DONE
    
    = Sincerita
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
        <b><color=\#354174>Isaac</color></b>: "..."    
        {Partita_Isaac_Seduzione:
        <b><color=\#354174>Isaac</color></b>: "Avevi ragione, io dovevo parlarne."
        }
        {Partita_Isaac_Zuffa:
        <b><color=\#354174>Isaac</color></b>: "Scusa. Mi spiace stare sempre in difensiva, mi spiace farlo con te."
        }   
        <b><color=\#354174>Isaac</color></b>: "Non l'ho mai detto. I miei pensano che sia venuto in Italia per ragioni frivoli, e come biasimarli. Volevo solo andare il più lontano posibile"
            * "Posso fare qualcosa?"
            <b><color=\#354174>Isaac</color></b>: "Non lo so. Grazie per avermi ascoltato, ma vorei stare un po' da solo adesso. Parliamo dopo?"
                * * "E la festa dai Mancuso? Ne parli da settimane, non era stasera?"
                <b><color=\#354174>Isaac</color></b>: "Credo che per una prima volta in vita mia declinerò l'invito di uno amico e resterò nella casa. Speriamo che non diventi una abitudine."
            -
    <b><color=\#354174>Isaac</color></b>: "Devi avviarti, se non vuoi fare tardi al tuo private party."
            + "{CristinaWin:Fammi parlare con Catena un attimo.|Fammi parlare con le altre due.}" -> DONE
            * [<b>Prepara il deck prima di andare da Thovez</b>]
            "Sistemo due cose e parto. Ci vediamo domattina!"
                <b><color=\#354174>Isaac</color></b>: "Domatina sarò probabilmente morto di noia. Ricordati di donare degli fiori al mio spirito infelice."
            
            ~ caricaAtto("DeckBuilding")
            ~ caricaDeckBuilding()
            @    
            ~ caricaAtto("GiornoDueSera")
            ~ caricaScena("CasaThovezAmministrazione")
        -> DONE
    
    
    = fallbackIsaac
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    <b><color=\#354174>Isaac</color></b>: "{~ Devi avviarti, se non vuoi fare tardi al tuo heist.|Ancora qui, pirata?|Catena scalpita, lei vuole andare a menare qualcuno.|Vai S., e non fare sciocheze ti prego.}"
             + "{CristinaWin:Scambio due parole con Catena.|Mi consulto con le altre un attimo.}" -> DONE
            * [<b>Prepara il deck prima di andare da Thovez</b>]
            "Sistemo due cose e partiamo. A domani amore!"
            ~ caricaAtto("DeckBuilding")
            ~ caricaDeckBuilding()
            @
            ~ caricaAtto("GiornoDueSera")
            ~ caricaScena("CasaThovezAmministrazione")
    -> DONE



//PARTITA CON ISAAC

=== Partita_Isaac_Chiacchiera ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
    <b><color=\#354174>S.</color></b>: "Ti sembro uno che può giudicarti?"
    <b><color=\#354174>Isaac</color></b>: "Lo so, ma è dificile parlare per me."
    <b><color=\#354174>S.</color></b>: "Sei il più grande chiacchierone che conosca. Dopo Catena."
    <b><color=\#354174>Isaac</color></b>: "Sono bravo con le parole quando servono a sviare l'atenzione. non tanto quando devo essere sincero."
    <b><color=\#354174>S.</color></b>: "Amore, condividiamo questo peso."
    <b><color=\#354174>Isaac</color></b>: "Potrebe volerci uno po'."
    <b><color=\#354174>S.</color></b>: "A cinquant'anni non la conosco mica fretta, Isaac."
    <b><color=\#354174>Isaac</color></b>: " Io potrei blocarmi, o non riuscire a ricordare tuto."
    <b><color=\#354174>S.</color></b>: "Allora ti liberi di quello che sai e puoi."

-> DONE

=== Partita_Isaac_Seduzione ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
    <b><color=\#354174>S.</color></b>: "Ricordo che a Londra avevi dei fidanzati."
    <b><color=\#354174>Isaac</color></b>: "Frequentavo uno locanda, lo Sweet Swan Inn. Ero una degli molly abituali lì. Mi chiamavano Lady Isabel."
    <b><color=\#354174>S.</color></b>: "Sì eh, ti ci vedo benissimo."
    <b><color=\#354174>Isaac</color></b>: "Già. Una sera ariva un marinaio. Tarchiato, braccia muscolose, volto indurito da mare. Non ho saputo resistere."
    <b><color=\#354174>S.</color></b>: "Uuh, mi somiglia quindi!"
    <b><color=\#354174>Isaac</color></b>: "All'inizio acetava tuti i boccali che gli offrivo. Poi va a orinare. Andamo nel vicolo sul retro. Provai a baciarlo ma..."
    <b><color=\#354174>S.</color></b>: "C'è sempre un ma."
    <b><color=\#354174>Isaac</color></b>: "Ricordo calci alle costole e minacce di morte. Mi prese l'orologio di mia madre. L'ultima cosa che ricordo è la puzza e lo calore della sua urina che mi arivava fino alle ossa."
    <b><color=\#354174>S.</color></b>: "Fatti abbracciare."
-> DONE

=== Partita_Isaac_Zuffa ===
    ~ PersonaggioSx = "S"
    ~ PersonaggioDx = "Isaac"
    
    <b><color=\#354174>S.</color></b>: "Sai tutto del mio passato, Cristo!"
    <b><color=\#354174>Isaac</color></b>: "È diverso. A te piace rivangare quelo che è stato, a me no."
    <b><color=\#354174>S.</color></b>: "Perché l'è più facile che scappare dai ricordi."
    <b><color=\#354174>Isaac</color></b>: "Facile per te. Tu sei orgoglioso delle tue scelte. Io dale mie cerco di scapare."
    <b><color=\#354174>S.</color></b>: "E ora son qui a pigliarti, Isaac."
    <b><color=\#354174>Isaac</color></b>: "Ma si può sapere perchè te lo interessa così tanto?"
    <b><color=\#354174>S.</color></b>: "Perchè ti amo e ti ho promesso di proteggerti."
    <b><color=\#354174>Isaac</color></b>: "Sbaglio o eravamo d'acordo di avere entrambi gli nostri segreti?"
    <b><color=\#354174>S.</color></b>: "Mettila così: stai mettendo in pericolo tutta la ciurma. Catena. Me."
    <b><color=\#354174>Isaac</color></b>: "Mi stai ricatando?"
    <b><color=\#354174>S.</color></b>: "Ti dico solo che se non sai pensare a te, puoi pensare a chi dici di amare!"
    <b><color=\#354174>Isaac</color></b>: "Sempre ale tue regole bisogna stare, sempre."
    -> DONE