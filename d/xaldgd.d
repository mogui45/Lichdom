BEGIN ~XALDGD~

//{ Introductions

	IF ~
		NumTimesTalkedTo(0)
		AreaCheck("AR0800")
	~ THEN BEGIN XA_LD_IntroAthkatla_0
		SAY @0 /*~<You see a man in ornate robes whose every motion seems intentional, calm, and slow.  His voice seems wise with a tone that reminds you of Gorion’s voice, but with more crackle and spoken more slowly.  He smells clean despite his nearness to the dead  His demeanor is of one of great importance who seems to be in absolutely no hurry.>~ [xald0000]*/
		
		IF ~~ THEN
		DO ~
			SetGlobal("XA_LD_MetMorrisInAthkatla", "GLOBAL", 1)
		~
		GOTO XA_LD_IntroAthkatla
	END

	IF ~
		NumTimesTalkedTo(0)
		AreaCheck("AR5000")
		Global("XA_LD_MetMorrisInAthkatla", "GLOBAL", 1)
	~ THEN BEGIN XA_LD_IntroSaradush_0
		SAY @39  /* ~(You see a man who looks familiar to you.  His name soon comes to mind - Morris the Gravetender - and you last met him in Athkatla.  He again seems to be in absolutely no hurry.)~  [xald1059]*/
		
		= @40  /* ~"Ah, there you are.  I remember you, CHARNAME."~ [xald1060]*/
		
		COPY_TRANS XALDGD XA_LD_IntroAthkatla
	END

	IF ~
		NumTimesTalkedTo(0)
		AreaCheck("AR5000")
		Global("XA_LD_MetMorrisInAthkatla", "GLOBAL", 0)
	~ THEN BEGIN XA_LD_IntroSaradush_1
		SAY @41  /* ~(You see a man in ornate robes whose every motion seems intentional, calm, and slow.  His voice seems wise with a tone that reminds you of Gorion’s voice, but with more cracks and spoken more slowly.  He smells clean despite his nearness to the dead  His demeanor is of one of great importance who seems to be in absolutely no hurry.)~ [eemor100] */
		
		= @42  /* ~~"Ah, there you are.  You are one of the many people to have been curious about me.  I am Morris, a gravetender in Athkatla and now here in Saradush."~ [xald1076]*/
		
		IF ~~ THEN REPLY @43  /* ~What made you come here?~*/
		GOTO XA_LD_WhyComeToSaradush
		
		COPY_TRANS XALDGD XA_LD_IntroAthkatla
	END

//}

IF ~
	True()
~ THEN BEGIN XA_LD_IntroAthkatla
	SAY @1 /*~Ah, there you are.  I am Morris, and you are one of many people to have been curious about me.~ [xald0001]*/
	
	IF ~~ THEN REPLY @2 /*~I am curious.  Who are you?~*/
	GOTO XA_LD_WhoAreYou
	
	IF ~~ THEN REPLY @4 /*~Why are you here among the dead?~ [xald0002]*/
	GOTO XA_LD_WhyAreYouHere
	
	IF ~~ THEN REPLY @6 /*~What do you think about death?~*/
	GOTO XA_LD_ThoughtsOnDeath
	
	IF ~
		Global("XA_LD_RitualsPerformed", "GLOBAL", 0)
	~ THEN REPLY @38 /*~You seem like a necromancer -and- Undead!  Are you?~*/
	GOTO XA_LD_AreYouUndead1
	
	IF ~
		GlobalGT("XA_LD_RitualsPerformed", "GLOBAL", 0)
	~ THEN REPLY @38 /*~You seem like a necromancer -and- Undead!  Are you?~*/
	GOTO XA_LD_AreYouUndead2
	
	IF ~
		AreaCheck("AR0800")
	~ THEN REPLY @27 /* ~What do you think about killing the Undead here and looting these tombs?~ */
	GOTO XA_LD_Looting
	
	IF ~
		AreaCheck("AR5000")
	~ THEN REPLY @31 /* ~What do you think about this city being under siege?~*/
	GOTO XA_LD_Siege
	
	IF ~
		NumItemsPartyGT("xalddust", 2)
		Global("XA_LD_GaveDust", "GLOBAL", 0)
	~ THEN REPLY @80  /* ~Your deed is done and these liches are slain.  Here’s your lich dust.  Now what?~ */
	DO ~
		SetGlobal("XA_LD_GaveDust", "GLOBAL", 1)
		TakePartyItemNum("xalddust", 3)
	~
	GOTO XA_LD_GaveDust
	
	IF ~
		AreaCheck("AR0800")
		GlobalGT("BodhiAppear","GLOBAL",0)
		!Dead("C6BODHI")
	~ THEN REPLY @98  /* ~What do you think of the Undead creatures roaming the streets of Athkatla at night?~ */
	GOTO XA_LD_MetBodhi
	
	IF ~
		AreaCheck("AR0800")
		!Dead("C6BODHI")
		Global("ElhanFinishedSpeaking","GLOBAL",1)
	~ THEN REPLY @100 /* ~I am about to slay this vampiric Bodhi.  What do you say to this?~*/
	GOTO XA_LD_WhoCares
	
	
	IF ~
		Global("XA_LD_MorrisKilledInAthkatla", "GLOBAL", 1)
	~ THEN REPLY @53 /*~You’re here!  And alive!  I thought you died!~*/
	GOTO XA_LD_Alive
	
	IF ~
		AreaCheck("AR5000")
		GlobalGT("XA_LD_RitualsPerformed", "GLOBAL", 0)
		GlobalLT("XA_LD_ThoughtsOnRitual", "LOCALS", 1)
		OR(6)
			Race(Player1, LICH)
			Race(Player2, LICH)
			Race(Player3, LICH)
			Race(Player4, LICH)
			Race(Player5, LICH)
			Race(Player6, LICH)
	~ THEN REPLY @67 /*~I have some things to say about that lichdom ritual you performed.~*/
	DO ~
		SetGlobal("XA_LD_ThoughtsOnRitual", "LOCALS", 1)
	~
	GOTO XA_LD_ThoughtsOnRitual
	
	IF ~
		OR(6)
			TriggerOverride(Player1, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
			TriggerOverride(Player2, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
			TriggerOverride(Player3, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
			TriggerOverride(Player4, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
			TriggerOverride(Player5, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
			TriggerOverride(Player6, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @130 /* ~Can you fix a damaged or broken phylactery?~*/
	GOTO XA_LD_CanYouFix
	
	IF ~
		Global("XA_LD_GaveDust", "GLOBAL", 1)
	~ THEN REPLY @103  /* ~Lichdom still interests me despite the monetary cost.  Let’s deal, my friend!~*/
	GOTO XA_LD_StartRitual
	
END

IF ~~ THEN BEGIN XA_LD_CanYouFix
	SAY @131 /*~Gravetender Morris frowns as he quietly and slowly sighs.  "I cannot.  I apologize for this.  However, I can craft another one for you for the same price as the original."~ [xald1049]*/
	
	//{ Have Enough Money
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 0)
		PartyGoldGT(119999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_HasMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 1)
		PartyGoldGT(99999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_HasMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 2)
		PartyGoldGT(74999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_HasMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 3)
		PartyGoldGT(49999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_HasMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 4)
		PartyGoldGT(39999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_HasMoneyToFix
	//}
	
	//{ Not Enough Money
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 0)
		!PartyGoldGT(119999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_NoMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 1)
		!PartyGoldGT(99999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_NoMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 2)
		!PartyGoldGT(74999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_NoMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 3)
		!PartyGoldGT(49999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_NoMoneyToFix
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 4)
		!PartyGoldGT(39999)
	~ THEN REPLY @132  /* ~Please do~ */
	GOTO XA_LD_NoMoneyToFix
	//}
	
	IF ~~ THEN REPLY @133 /*~Let us discuss something else.~*/
	GOTO XA_LD_DiscussSomethingElse
END

IF ~~ THEN BEGIN XA_LD_HasMoneyToFix
	SAY @135 /*~Morris looks at you intently.  "Whose phylactery should I replace?"~ [xald1050]*/
	
	IF ~~ THEN REPLY @145 /* Nevermind */
	GOTO XA_LD_Nevermind 
	
	IF ~
		TriggerOverride(Player1, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @137 /*~(Repair Player 1's phylactery.)~*/
	DO ~
		ActionOverride(Player1, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~
		TriggerOverride(Player2, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @138 /*~(Repair Player 2's phylactery.)~*/
	DO ~
		ActionOverride(Player2, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~
		TriggerOverride(Player3, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @139 /*~(Repair Player 3's phylactery.)~*/
	DO ~
		ActionOverride(Player3, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~
		TriggerOverride(Player4, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @140 /*~(Repair Player 4's phylactery.)~*/
	DO ~
		ActionOverride(Player4, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~
		TriggerOverride(Player5, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @141 /*~(Repair Player 5's phylactery.)~*/
	DO ~
		ActionOverride(Player5, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~
		TriggerOverride(Player6, Global("XA_LD_PhylacteryBroken", "LOCALS", 1))
	~ THEN REPLY @142 /*~(Repair Player 6's phylactery.)~*/
	DO ~
		ActionOverride(Player6, SetGlobal("XA_LD_PhylacteryBroken", "LOCALS", 0))
	~
	GOTO XA_LD_RepairedPhylactery
	
	IF ~~ THEN REPLY @133 /*~Let us discuss something else.~*/
	GOTO XA_LD_DiscussSomethingElse
END

IF ~~ THEN BEGIN XA_LD_Nevermind
	SAY @147 /*~Acknowledged.~ [xald1051]*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_RepairedPhylactery
	SAY @143 /* ~It is done. Treat it with care.~ */
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 0)
		PartyGoldGT(119999)
	~ THEN REPLY @144 /* ~Thank you!~ */
	DO ~
		TakePartyGold(120000)
	~
	GOTO XA_LD_AnythingElse
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 1)
		PartyGoldGT(99999)
	~ THEN REPLY @144 /* ~Thank you!~ */
	DO ~
		TakePartyGold(100000)
	~
	GOTO XA_LD_AnythingElse
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 2)
		PartyGoldGT(74999)
	~ THEN REPLY @144 /* ~Thank you!~ */
	DO ~
		TakePartyGold(75000)
	~
	GOTO XA_LD_AnythingElse
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 3)
		PartyGoldGT(49999)
	~ THEN REPLY @144 /* ~Thank you!~ */
	DO ~
		TakePartyGold(50000)
	~
	GOTO XA_LD_AnythingElse
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 4)
		PartyGoldGT(39999)
	~ THEN REPLY @144 /* ~Thank you!~ */
	DO ~
		TakePartyGold(40000)
	~
	GOTO XA_LD_AnythingElse
END

IF ~~ THEN BEGIN XA_LD_AnythingElse
	SAY @146 /*~Was there something else?~*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_NoMoneyToFix
	SAY @136 /*~Morris slowly shakes his head.  “My apologies, but I require more coins to craft a new phylactery.”~ [xald1052]*/
	
	IF ~~ THEN REPLY @133 /*~Let us discuss something else.~*/
	GOTO XA_LD_DiscussSomethingElse
END

IF ~~ THEN BEGIN XA_LD_DiscussSomethingElse
	SAY @148 /*~He nods.~ [xald1059]*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_StartRitual
	SAY @102  /* ~“Ah…” he says with a long, quiet exhale.  “Lichdom has -quite- the monetary price, but the allure of immortality is worth it.  Do you have the -entire- amount of gold on you now?  If so, we can proceed.” [xald1031]*/
	
	IF ~~ THEN REPLY @104  /* ~I have reconsidered.  Perhaps we shall handle this later.~*/
	GOTO XA_LD_Reconsider
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 0)
		PartyGoldGT(119999)
	~ THEN REPLY @105  /* ~Here is your money.  Let’s do this!~ */
	GOTO XA_LD_PayMoney
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 1)
		PartyGoldGT(99999)
	~ THEN REPLY @105  /* ~Here is your money.  Let’s do this!~ */
	GOTO XA_LD_PayMoney
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 2)
		PartyGoldGT(74999)
	~ THEN REPLY @105  /* ~Here is your money.  Let’s do this!~ */
	GOTO XA_LD_PayMoney
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 3)
		PartyGoldGT(49999)
	~ THEN REPLY @105  /* ~Here is your money.  Let’s do this!~ */
	GOTO XA_LD_PayMoney
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 4)
		PartyGoldGT(39999)
	~ THEN REPLY @105  /* ~Here is your money.  Let’s do this!~ */
	GOTO XA_LD_PayMoney
END

IF ~~ THEN BEGIN XA_LD_PayMoney
	SAY @107  /* ~Morris looks at you eagerly.  “The fourth price is decision.  Who among you shall undergo this ritual?  You must be a sufficiently powerful spellcaster to benefit, or else your time is wasted.  Are you ready to begin?”~ [xald1033] */
	
	IF ~
		!Class(Player1, FIGHTER)
		!Class(Player1, THIEF)
		!Class(Player1, FIGHTER_THIEF)
		!Kit(Player1, WIZARDSLAYER)
		!General(Player1, UNDEAD)
		LevelGT(Player1, 9)
	~ THEN REPLY @108  /* ~(Choose <CHARNAME>.)~ */
	GOTO XA_LD_Chain_ChooseCharname
	
	IF ~
		InParty("Cernd")
		!General("Cernd", UNDEAD)
		LevelGT("Cernd", 9)
	~ THEN REPLY @186 /* ~(Choose Cernd.)~ */
	EXTERN CERNDJ XA_LD_Chain_ChooseCernd
	
	IF ~
		InParty("Dorn")
		!General("Dorn", UNDEAD)
		LevelGT("Dorn", 9)
	~ THEN REPLY @187 /* ~(Choose Dorn.)~*/
	EXTERN DORNJ XA_LD_ChooseDorn
	
	IF ~
		InParty("Edwin")
		!General("Edwin", UNDEAD)
		LevelGT("Edwin", 9)
	~ THEN REPLY @188 /* ~(Choose Edwin.)~*/
	EXTERN EDWINJ XA_LD_Chain_ChooseEdwin
	
	IF ~
		InParty("HaerDalis")
		!General("HaerDalis", UNDEAD)
		LevelGT("HaerDalis", 9)
	~ THEN REPLY @189 /* ~(Choose HaerDalis.)~*/
	EXTERN HAERDAJ XA_LD_Chain_ChooseHaerDalis
	
	IF ~
		InParty("Imoen2")
		!General("Imoen2", UNDEAD)
		LevelGT("Imoen2", 9)
		Dead("c6bodhi")
	~ THEN REPLY @190 /*  ~(Choose Imoen.)~*/
	EXTERN IMOEN2J XA_LD_ChooseImoen
	
	IF ~
		InParty("Imoen2")
		!General("Imoen2", UNDEAD)
		LevelGT("Imoen2", 9)
		!Dead("c6bodhi")
	~ THEN REPLY @190 /*  ~(Choose Imoen.)~*/
	GOTO XA_LD_ChooseImoen_NoSoul
	
	IF ~
		InParty("Jaheira")
		!General("Jaheira", UNDEAD)
		LevelGT("Jaheira", 9)
	~ THEN REPLY @191 /* ~(Choose Jaheira.)~*/
	EXTERN JAHEIRAJ XA_LD_Chain_ChooseJaheira
	
	IF ~
		InParty("Keldorn")
		!General("Keldorn", UNDEAD)
		LevelGT("Keldorn", 9)
	~ THEN REPLY @192 /*~(Choose Keldorn.)~ */
	EXTERN KELDORJ XA_LD_Chain_ChooseKeldorn
	
	IF ~
		InParty("Mazzy")
		!General("Mazzy", UNDEAD)
		LevelGT("Mazzy", 9)
	~ THEN REPLY @214 /* ~(Choose Mazzy.)~*/
	EXTERN MAZZYJ XA_LD_Chain_ChooseMazzy
	
	IF ~
		InParty("Minsc")
		!General("Minsc", UNDEAD)
		LevelGT("Minsc", 9)
	~ THEN REPLY @216 /* ~(Choose Minsc.)~*/
	EXTERN MINSCJ XA_LD_Chain_ChooseMinsc
	
	IF ~
		InParty("Neera")
		!General("Neera", UNDEAD)
		LevelGT("Neera", 9)
	~ THEN REPLY @193 /* ~(Choose Neera.)~*/
	EXTERN NEERAJ XA_LD_Chain_ChooseNeera
	
	IF ~
		InParty("Nalia")
		!General("Nalia", UNDEAD)
		LevelGT("Nalia", 9)
	~ THEN REPLY @194 /* ~(Choose Nalia.)~*/
	EXTERN NALIAJ XA_LD_ChooseNalia
	
	IF ~
		!Class("Sarevok", FIGHTER)
		!Class("Sarevok", THIEF)
		!Class("Sarevok", FIGHTER_THIEF)
		!Kit("Sarevok", WIZARDSLAYER)
		!General("Sarevok", UNDEAD)
		LevelGT("Sarevok", 9)
	~ THEN REPLY @195 /*~(Choose Sarevok.)~*/ 
	EXTERN SAREV25J XA_LD_Chain_ChooseSarevok
	
	IF ~
		InParty("Valygar")
		!General("Valygar", UNDEAD)
		LevelGT("Valygar", 9)
	~ THEN REPLY @196 /*~(Choose Valygar.)~*/
	EXTERN VALYGARJ XA_LD_Chain_ChooseValygar
	
	IF ~
		InParty("Viconia")
		!General("Viconia", UNDEAD)
		LevelGT("Viconia", 9)
	~ THEN REPLY @197 /*~(Choose Viconia.)~*/
	EXTERN VICONIJ XA_LD_ChooseViconia
	
	IF ~
		InParty("Yoshimo")
		!General("Yoshimo", UNDEAD)
		LevelGT("Yoshimo", 9)
	~ THEN REPLY @198 /* (Choose Yosihmo.)*/
	GOTO XA_LD_NoYoshimo
	
END

IF ~~ THEN BEGIN XA_LD_ChooseImoen_NoSoul
	SAY @222 /*Gravetender Morris slowly and deliberately raises an eyebrow.  “Her soul is not entirely with her.  I require this for the lichdom ritual.” [eemor036]*/
	
	IF ~~ THEN
	GOTO XA_LD_ChooseAnother
END

IF ~~ THEN BEGIN XA_LD_NoYoshimo
	SAY @221 /*~Morris responds, “Yoshimo…  There is… something about you that may nullify my… understanding… with your patrons.  I shall not do it for that sake.”~*/
	
	IF ~~ THEN
	GOTO XA_LD_ChooseAnother
END

IF ~~ THEN BEGIN XA_LD_ChooseAnother
	SAY @206 /*~You must choose another.~*/

	COPY_TRANS XALDGD XA_LD_PayMoney
END

IF ~~ THEN BEGIN XA_LD_Reconsider
	SAY @105 /* ~"Later is no problem for me," he says with a coy smile.  "I am in no hurry." [xald1032]~*/
	 
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhoCares
	SAY @101  /*  ~Morris simply shrugs.~ [xald1030]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_MetBodhi
	SAY @99  /* ~"I am not with them," he says nonchalantly, "and I am not against them."  He looks you clearly in the eyes, "We have… an understanding."~ [xald1029]*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_GaveDust
	SAY @79  /*~"Good, good!" he says, with his eyes glowing and his face shining despite his slow movements.  He takes the lich dust from you slowly, almost dramatically slowly, as he inspects it.  "I knew each of them well.  Now, they can die the -true- death."~ [xald1019] */
	
	IF ~~ THEN REPLY @81  /*~Wait!  Did you -make- these liches?~ */
	GOTO XA_LD_MakeLiches
	
	IF ~~ THEN REPLY @90  /* ~-True death?-  Does that make you a… Dustman?~*/
	GOTO XA_LD_Dustman
	
	IF ~~ THEN REPLY @84  /* ~What did you mean when you said the second price was understanding?~*/
	GOTO XA_LD_SecondPrice
	
	IF ~~ THEN REPLY @88  /* ~Answer my previous question.  What happens next?~ */
	GOTO XA_LD_WhatHappensNext
END

IF ~~ THEN BEGIN XA_LD_WhatHappensNext
	SAY @89 /*  ~"The third price is money," he says, slowly holding out his hand.  "Lichdom is inherently expensive in costly ritual components.  That is why not every caster of weak or great power becomes one."  He raises his eyebrows at you.  "Each recipient of this ritual will require a substantial amount of gold."~ [xald1024]*/
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 0)
	~ THEN
	DO ~
		GiveItemCreate("xaldlc00", LastTalkedToBy, 0,0,0)
	~
	GOTO XA_LD_GavePrice
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 1)
	~ THEN
	DO ~
		GiveItemCreate("xaldlc01", LastTalkedToBy, 0,0,0)
	~
	GOTO XA_LD_GavePrice
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 2)
	~ THEN
	DO ~
		GiveItemCreate("xaldlc02", LastTalkedToBy, 0,0,0)
	~
	GOTO XA_LD_GavePrice
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 3)
	~ THEN
	DO ~
		GiveItemCreate("xaldlc03", LastTalkedToBy, 0,0,0)
	~
	GOTO XA_LD_GavePrice
	
	IF ~
		Global("XA_LD_TransformationCost", "GLOBAL", 4)
	~ THEN
	DO ~
		GiveItemCreate("xaldlc04", LastTalkedToBy, 0,0,0)
	~
	GOTO XA_LD_GavePrice
END

IF ~~ THEN BEGIN XA_LD_GavePrice
	SAY @91  /* ~He hands you a paper, saying, "This is my price.  There can be no discounts for any reason due to the nature of the ritual components."~ [eemor025] */
	
	IF ~~ THEN REPLY @92  /* ~That’s your price for EACH!?  That’s ridiculously high!~*/
	GOTO XA_LD_PriceIsHigh
	
	IF ~~ THEN REPLY @93  /* ~I can buy immortality with money?  What a bargain!~*/
	GOTO XA_LD_Bargain
	
	IF ~~ THEN REPLY @94  /* ~When should I pay you?~*/
	GOTO XA_LD_WhenToPay
END

IF ~~ THEN BEGIN XA_LD_PriceIsHigh
	SAY @95  /*~"-That- is the third price.  Pay it… or do not."  Morris looks at you smiling, almost grinning.~  [xald1026] */
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_Bargain
	SAY @96  /*~Morris winks.  "Some would agree."~ [xald1027]*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhenToPay
	SAY @97  /*~He leans in with his head slightly toward you.  "When you are ready, talk to me."~ [eemor028] */
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_SecondPrice
	SAY @85  /* ~Morris smiles and nods at you, slowly.  “You will be like them - potent, Undead, alive - but -you-,” he says, staring at you as if staring directly into your soul, “will be -unlike- them:  -You- will -live!-”  He reaches his hand toward your shoulder.  “You -know- what these liches can do.  -You- will be better!”~ [xald1022] */
	
	IF ~~ THEN REPLY @86  /* ~How will I be better?~*/
	GOTO XA_LD_Better
END

IF ~~ THEN BEGIN XA_LD_Better
	SAY @87  /*~Morris looks at you blankly, and blinks.  "They are destroyed.  You are not.  You won."~ [xald1023] */
	
	COPY_TRANS XALDGD XA_LD_GaveDust
END

IF ~~ THEN BEGIN XA_LD_Dustman
	SAY @83  /* ~Morris smirks at you - slowly.  "I pledged my allegiance to them… once.  I handled enough of their dead and beings that -should- have been dead to… question… their understanding of death.  They were -obsessed- with death, but afraid to pursue undeath to stop death for themselves.  I… quietly left in disagreement to focus on my own… pursuits."~ [xald1021]*/ 
	
	COPY_TRANS XALDGD XA_LD_GaveDust
END

IF ~~ THEN BEGIN XA_LD_MakeLiches
	SAY @82 /*~Morris looks at you with a face that bespeaks only hints of indifference with strong, confident beratement.  "I will not say.  Those that I knew, I knew.  Those I knew not, I never knew.  You completed this task for an -unrelated- reason."~ [xald1020] */
	
	COPY_TRANS XALDGD XA_LD_GaveDust
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual
	SAY @68 /*~Morris raises his eyebrow at you in curiosity.~ [xald1066]*/
	
	IF ~~ THEN REPLY @69 /*~It was absolutely worth it!  Thank you!~*/
	GOTO XA_LD_ThoughtsOnRitual_1
	
	IF ~~ THEN REPLY @70 /*~I liked being a lich, but can I return to normal now?~*/
	GOTO XA_LD_ThoughtsOnRitual_2
	
	IF ~~ THEN REPLY @71 /*~I already felt regret over becoming a lich.~*/
	GOTO XA_LD_ThoughtsOnRitual_3
	
	IF ~~ THEN REPLY @72 /*~I just wanted to remind you that you did this.  That’s all.~*/
	GOTO XA_LD_ThoughtsOnRitual_4
	
	IF ~~ THEN REPLY @73 /*~Did you find anyone else to lichify after you left Athkatla?~*/
	GOTO XA_LD_ThoughtsOnRitual_5
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual_1
	SAY @74 /*~Morris slowly and proudly smiles at you.~ [xald1067]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual_2
	SAY @75 /*~Morris frowns.  "This is a path you have willingly chosen.  You have paid the fourth price of a decision and the fifth price of trusting me to properly perform this ritual.  I will not aid you in this, nor will I stop you from obtaining this if it is what you truly want."~ [xald1068]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual_3
	SAY @76 /*~Morris sighs and looks at you, his eyes sad.  "I am sorry you feel that way.  Regret is a common emotion among the Undead.  I recommend you counteract that for the sake of your long-term sanity, lest your mind shatter and your emotions drown you in negativity."~ [xald1069]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual_4
	SAY @77 /*~Morris sluggishly shrugs and nods.~ [xald1070]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnRitual_5
	SAY @78 /*~"No," Morris says indifferently.  "No one asked like you did."~ [xald1071]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_Alive
	SAY @54 /*~Morris merely slowly sighs.  "I -did- die and it was by -your- influence.  I offer you forgiveness for your foolishness.  I have already forgiven myself for my foolishness."~*/
	
	IF ~~ THEN REPLY @55 /*~Wait!  You aren’t mad about this?~*/
	GOTO XA_LD_MadAboutBeingKilled
	
	IF ~~ THEN REPLY @57 /*~How did you survive?~*/
	GOTO XA_LD_HowSurvive
	
	IF ~~ THEN REPLY @60 /*~I killed you once and I’ll do it again!~*/
	GOTO XA_LD_KillAgain
END

IF ~~ THEN BEGIN XA_LD_MadAboutBeingKilled
	SAY @56 /* ~Morris sighs and slowly chuckles.  "No, no, and no.  Undeath has given me a new perspective:  I would rather not hold onto regret the rest of eternity.  I advise you do the same."~  [xald1073] */
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_HowSurvive
	SAY @58 /*~Morris slowly snickers.  "My phylactery is positioned -far- from here, and I regenerated and restocked in my safe, -private- place."~ [xald1074]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_KillAgain
	SAY @59 /*~Morris shrugs and sighs.  "If I live, I win.  If I die, I win.  I have planned for these possibilities.  You… seemingly have not.  Will you still test my immortal patience?"~ [xald1075]*/
	
	IF ~~ THEN REPLY @61 /* ~Since you don’t seem threatened at all by this, then we won’t fight.~*/
	GOTO XA_LD_WontFight
	
	IF ~~ THEN REPLY @63 /*~Die!  Again!~*/
	GOTO XA_LD_FightAgain
	
	IF ~~ THEN REPLY @65 /*~I accept your forgiveness.  Thanks.~*/
	GOTO XA_LD_Forgive
END

IF ~~ THEN BEGIN XA_LD_WontFight
	SAY @62 /*~Morris nods and slowly says, "That was a -wise- decision."~ [xald1076]*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_FightAgain
	SAY @64 /* ~Morris sighs as the air around him fills quickly and heavily with magical energy!~ [xald1077] */
	
	IF ~~ THEN
	DO ~
		Enemy()
	~
	EXIT
END

IF ~~ THEN BEGIN XA_LD_Forgive
	SAY @65 /*~I accept your forgiveness.  Thanks.~*/
	
	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhyComeToSaradush
	SAY @44  /* ~"Wars and rumors of wars," Morris says with a sly smile.  "Death and destruction are at our heels, and the chance to witness death on a massive scale seemed like too rare of an opportunity nowadays."~ [xald1061]*/
	
	IF ~~ THEN REPLY @45 /* ~Where do you plan to go next?~*/
	GOTO XA_LD_WhereToNext
	
END

IF ~~ THEN BEGIN XA_LD_WhereToNext
	SAY @46  /* ~"Wherever my whims carry me - most likely to another warzone, for war never changes."  Morris slyly smiles at you.  "But you, CHARNAME, are going to the Throne of Bhaal.  I -sense- it.  There, you will pay the fourth price - a decision - but one -far- greater than becoming a lich.  I cannot say more."~ [xald1062]*/
	
	IF ~~ THEN REPLY @47  /* ~Wait! What?~*/
	GOTO XA_LD_WhereToNext_End1
	
	IF ~~ THEN REPLY @48 /* ~How do you know this?~*/
	GOTO XA_LD_WhereToNext_End2
	
	IF ~~ THEN REPLY @49 /* ~Thanks, I think.~*/
	GOTO XA_LD_WhereToNext_End3
END


IF ~~ THEN BEGIN XA_LD_WhereToNext_End1
	SAY @50 /*~Morris smugly smiles at you.  "Reflect on what I have said, CHARNAME."~ [xald1063] */

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhereToNext_End2
	SAY @51 /* ~Morris smiles at you as he says, "-I- am a -Wizard.-  Knowledge is my duty."~ [xald1064]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhereToNext_End3
	SAY @52 /* ~Morris kindly nods.~ [xald1065]*/

	COPY_TRANS XALDGD XA_LD_IntroAthkatla
END

IF ~~ THEN BEGIN XA_LD_WhoAreYou
	SAY @3 /*~"Morris, a gravetender," he says, grateful that you asked.~ [xald0002]*/
	
	IF ~~ THEN REPLY @4 /*~Why are you here among the dead?~ [xald0002]*/
	GOTO XA_LD_WhyAreYouHere
	
	IF ~~ THEN REPLY @6 /*~What do you think about death?~*/
	GOTO XA_LD_ThoughtsOnDeath
END

IF ~~ THEN BEGIN XA_LD_WhyAreYouHere
	SAY @5 /*~He says with a plain smile, "I have chosen to keep the dead - and the Undead - that should not be in the city out of it.  I ensure those who bring their dead here or who mourn for their dead here head in the right direction."~ [xald0003]*/
	
	IF ~~ THEN REPLY @2 /*~I am curious.  Who are you?~*/
	GOTO XA_LD_WhoAreYou
	
	IF ~~ THEN REPLY @6 /*~What do you think about death?~*/
	GOTO XA_LD_ThoughtsOnDeath
	
	
	
	
END

IF ~~ THEN BEGIN XA_LD_Siege
	SAY @32 /*~Morris shrugs.  “I will leave it by some means when the time is right.”~ [xald0017]*/
	
	IF ~~ THEN REPLY @33 /*~Leave how?  When?  To where?~*/
	GOTO XA_HowWillYouLeave

END

IF ~~ THEN BEGIN XA_HowWillYouLeave
	SAY @34 /*~Morris gives you an icy stare.  “I leave -that- to your imagination.”~ [xald0018]*/
	
	COPY_TRANS XALDGD XA_LD_WhyAreYouHere
END

IF ~~ THEN BEGIN XA_LD_Looting
	SAY @28 /*~Morris sighs and shrugs.  “Destroyed Undead do not enter the rest of the city.  You have helped me do my job.”~ [xald0015]*/
	
	IF ~~ THEN REPLY @29 /*~Why are you so concerned about Undead?~*/
	GOTO XA_LD_Concerned
END

IF ~~ THEN BEGIN XA_LD_Concerned
	SAY @30 /*~Morris gives you a blank stare.  “Undead are not inherently the problem.  Unwanted -destruction- is the problem which -certain- Undead cause.”~ [xald0016]*/
	
	COPY_TRANS XALDGD XA_LD_WhyAreYouHere
END

IF ~~ THEN BEGIN XA_LD_AreYouUndead1
	SAY @19 /* ~Morris raises his eyebrows at you.  “I leave -that-... to your imagination.”~ [xald0010]*/
	
	COPY_TRANS XALDGD XA_LD_WhyAreYouHere
END

IF ~~ THEN BEGIN XA_LD_AreYouUndead2
	SAY @20 /*~Morris slowly smirks, as if to avoid cracking his face.  “The lichdom ritual I performed for you was the same one I did on myself, many years ago.”~ [xald0011]*/
	
	IF ~~ THEN REPLY @21 /*Why did you become Undead?~*/
	GOTO XA_LD_WhyDidYouBecomeUndead
	
	IF ~~ THEN REPLY @23 /*~Any regrets about becoming Undead?~*/
	GOTO XA_LD_Regrets
END

IF ~~ THEN BEGIN XA_LD_Regrets
	SAY @24 /* ~The smirk on Morris’s face turns to a frown.  “I… have learned Undeath can be a curse that overwhelms one in regret.  There are too many things I wish I had not done in pursuit of lichdom.  I have since learned the necessity of forgiveness and its power to unburden me from guilt, regret, shame, and the like.”~ [xald0013] */
	
	IF ~~ THEN REPLY @25 /*~What sorts of things did you regret?~ */
	GOTO XA_LD_Regrets2
	
END

IF ~~ THEN BEGIN XA_LD_Regrets2
	SAY @26 /*~Morris sighs, trying not to frown.  “I leave -that- to your imagination, lest I remember them too well.”~ [xald0014]*/
	
	COPY_TRANS XALDGD XA_LD_WhyAreYouHere
END

IF ~~ THEN BEGIN XA_LD_WhyDidYouBecomeUndead
	SAY @22 /*~Morris smirks more widely.  “It was likely the same reason as you:  Death was an inconvenient -interruption- and lichdom provided -power- that I desired.  I paid the prices you paid.”~ [xald0012]*/
	
	COPY_TRANS XALDGD XA_LD_WhyAreYouHere
END

IF ~~ THEN BEGIN XA_LD_ThoughtsOnDeath
	SAY @7 /* ~“Death,” he says, seemingly with a quiet sigh, “is a transition from this state called ‘life’ to another called ‘death.’  Some are able to call things beyond death back to life, and all are able to put that which can die to death.”~ [xald0004]*/
	
	IF ~~ THEN REPLY @8 /*~Then are you fond of death?~*/
	GOTO XA_LD_FondOfDeath
	
END

IF ~~ THEN BEGIN XA_LD_FondOfDeath
	SAY @9 /*~He blinks and stares at you blankly.  “I have devoted my life to the understanding of death.  I believe all life wishes to live forever, to expand in this reality, to -dominate- this reality, but is cursed with this -interruption- called ‘death.’  And so I found a way to solve death.”~ [xald0005]*/
	
	IF ~~ THEN REPLY @10 /*~Do you mean -undeath?-~*/
	GOTO XA_LD_Undeath
END

IF ~~ THEN BEGIN XA_LD_Undeath
	SAY @11 /*~“Yes,” he says with a blank smile, “since you insisted.  It is a way to accomplish -more- in life with less chance of this irksome -interruption.-  I am willing to share it - for a price.”~ [xald0006]*/
	
	IF ~~ THEN REPLY @12 /*~What sort of price?~*/
	GOTO XA_LD_Price
END

IF ~~ THEN BEGIN XA_LD_Price
	SAY @13 /*~He clearly and eagerly smiles at a pace that is fast for him.  “The first price is your peace.  Are you at peace with your god?  Many would disdain such a transformation, and I shall not be held accountable should your ‘transgressions’ result in harm toward you.  Merely considering this option without pursuing it should not count as a stain upon your soul.”~ [xald0007]*/
	
	IF ~~ THEN REPLY @14 /* ~I am willing.  Proceed!~ */
	GOTO XA_LD_Chain_ChooseCharname
	
	IF ~~ THEN REPLY @16 /* ~Perhaps later.~*/
	GOTO XA_LD_Later
END

IF ~~ THEN BEGIN XA_LD_Proceed
	SAY @15 /*~He silently nods at you.  “The second price is understanding.  Go find 3 liches or demiliches in any combination, slay them, and bring their lich dust to me.  We shall talk further then.”  Morris promptly stands up straight and looks you very intently in the eyes.~ [xald0008]*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_Later
	SAY @17 /*~“Ah,” he says with a long sigh.  “So be it.  Talk with me should your decision change.  I have… long enough.”~ [xald0009] */
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_Chain_ChooseCharname_END
	SAY @127  /* ~Morris stares at you as he awaits your decision.~ */

	IF ~~ THEN REPLY @171 /*~I have reconsidered.  Perhaps we shall handle this later.~*/
	EXIT

	IF ~
		Global("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~ THEN REPLY @128 /*~I understand your objections and have reconsidered.  I’ll not undergo this lichdom ritual now.~ */
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 0)
	~
	GOTO XA_LD_MeetAgain
	
	IF ~~ THEN REPLY @149 /*~Becoming a Lich is an opportunity for me to take my life into my own hands for the benefit of others as well, even though someone else in my situation may have become a merchant or a priest instead  Before I left my home of Candlekeep, assassins were after me.  When I left Candlekeep with my foster father Gorion, I could do nothing to save him from a painful death by Sarevok and his minions.  While I was instrumental in defeating Sarevok and becoming the Hero of Baldur’s Gate, some of my friends and I were still captured, tortured, imprisoned, and killed and there was -nothing- I could do to stop it!  Elminster himself has taken an interest in my well-being, meaning my destiny -must- be important and I -must- be -alive- to fulfill it!  In short, I’m -tired- of people I care about being hurt because I was too weak to prevent these problems!~*/
	GOTO XA_LD_Chain_ConfirmCharname1
	
	IF ~~ THEN REPLY @170 /*~(Lie) My foster father Gorion told me that the essence of dead Bhaalspawn return to Bhaal, and if Bhaal regains all of his essence, the Lord of Murder WILL return!  As an unwitting Bhaalspawn, lichdom is a means to the greater good by -preventing- this evil deity from returning!~*/
	GOTO XA_LD_Chain_ConfirmCharname2
END



IF ~~ THEN BEGIN XA_LD_MeetAgain
	SAY @129 /*  ~“So be it, <CHARNAME>.  Perhaps we shall meet again.”~ [xald1035]*/
	
	IF ~~ THEN 
	EXIT
END

IF ~~ THEN BEGIN XA_LD_LastChance
	SAY @175 /*~“Then the -fifth- price is trust.”  He looks at you with his arms out and palms up as to signify friendship.  “Do you -trust- me now to properly perform this ritual?”~ [xald1043]*/
	
	IF ~~ THEN
	EXIT
END

//{ Transformation Initiations
IF ~~ THEN BEGIN XA_LD_DornLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_EdwinLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_HaerDalisLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_ImoenLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_NeeraLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_SarevokLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END

IF ~~ THEN BEGIN XA_LD_ViconiaLich
	SAY @210 /*~[PENDING IMPLEMENTATION].~*/
	
	IF ~~ THEN
	EXIT
END
//}
CHAIN XALDGD XA_LD_Chain_ConfirmCharname1
	@150 /*~Morris nods in understanding.~*/
	
	== AERIEJ
	IF ~
		IsValidForPartyDialogue("Aerie")
	~
	@151 /*~I... I understand.  I just... don’t like it.~*/
	
	== ANOMENJ
	IF ~
		IsValidForPartyDialogue("Anomen")
	~
	@151 /*~~It appears we are more kindred spirits than I first thought of you, <CHARNAME>.  I am still uncomfortable about this.~~*/
	
	== CERNDJ
	IF ~
		IsValidForPartyDialogue("Cernd")
	~
	@153 /*~<CHARNAME>, my stance is the same:  Be careful with this power, lest it overtake and taint you.~*/
	
	== EDWINJ
	IF ~
		IsValidForPartyDialogue("Edwin")
	~
	@154 /*~Yes, yes, <CHARNAME>.  All this talk about the ‘greater good’ is just nonsense to make the weak-willed feel better.~ [xald1084]*/
	
	== IMOEN2J
	IF ~
		IsValidForPartyDialogue("Imoen2")
	~
	@155 /*~<PRO_BROTHERSISTER>, your mind is made up.  If that’s what you’re gonna do...  I guess I’ll stay for now.  I still think this necromantic stuff is kinda creepy.~*/
	
	== JAHEIRAJ
	IF ~
		IsValidForPartyDialogue("Jaheira")
	~
	@156 /*~<CHARNAME>, I -hate- this.  I hate the pain I felt just thinking of my anger against our captor, how he tormented us and killed my beloved Khalid!  But, I’ve started to move on.~*/
	= @157 /*~You?  I hate to admit that you’re right that we were too weak to stop these atrocities, and that if we were stronger and fate were with us, we could have more of our will done in the world.~*/
	= @158 /*~Still, <CHARNAME>, you want to become an Undead <PRO_MANWOMAN> so much?  Fine.  You go crazy and I’ll -gladly- kill you and stomp your phylactery to dust!~*/
	
	== JANJ
	IF ~
		IsValidForPartyDialogue("Jan")
	~
	@159 /*~<CHARNAME>, I suppose this is a once-in-a-lifetime opportunity to definitely prove the effects of lichdom on Bhaalspawn!  I promise you I won’t profit off this without your consent!~*/
	
	== KELDORJ
	IF ~
		IsValidForPartyDialogue("Keldorn")
	~
	@160 /*~<CHARNAME>, I have generally trusted you since we met.  I would hate for this apparent sacrifice of yours to cause you to lose your mind or your desire to do what is right for the sake of the world.~*/
	= @161 /*~It is ultimately your choice, <CHARNAME>, but if you go through with this, I shall not stay.  For the sake of our friendship, I shall not slay you this day.  Do not provoke those of my order to wrath, for if you do, we WILL hunt you down and slay you, as painful to us as it may be!~*/
	DO ~
		SetGlobal("XA_LD_KeldornWillLeave", "GLOBAL", 1)
	~
	== MAZZYJ
	IF ~
		IsValidForPartyDialogue("Mazzy")
	~
	@162 /*~<CHARNAME>, my heart goes out to you for all the pain you’ve experienced, but you should know that Lichdom won’t fix your past and won’t avenge those that wronged those you love!~*/
	= @163 /*~I just gotta say that I can’t stay if you do that.  Sorry, <CHARNAME>.~*/
	DO ~
		SetGlobal("XA_LD_MazzyWillLeave", "GLOBAL", 1)
	~
	
	== MINSCJ
	IF ~
		IsValidForPartyDialogue("Minsc")
	~
	@164 /*~Boo knows the putrid stench of evil of our captor’s lair, and Boo knows you mean well in what you do!  I miss Dynaheir just as much as Boo, and we too wish we were stronger so Dynaheir was never killed!~ */
	= @165 /*~But to do this?  My hamster and I do not know if we can stand for this!  Our footprint might be all over your butt -and- your head!~*/
	
	== RASAADJ
	IF ~
		IsValidForPartyDialogue("Rasaad")
	~
	@166 /*~So, <CHARNAME>, it seems like you want me to keep you from the temptation of this new power for the good of us all.~*/
	
	== SAREV25J
	IF ~
		IsValidForPartyDialogue("Sarevok")
	~
	@167 /*~<PRO_BROTHERSISTER>, you are either naive or a schemer of my caliber!~*/
	
	== VALYGARJ
	IF ~
		IsValidForPartyDialogue("Valygar")
	~
	@168 /*~<CHARNAME>, whatever your reasoning, if you go through with this, I simply cannot stay:  The tainted magic is too great!~*/
	DO ~
		SetGlobal("XA_LD_ValygarWillLeave", "GLOBAL", 1)
	~
	
	== VICONIJ
	IF ~
		IsValidForPartyDialogue("Viconia")
	~
	@169 /*~<CHARNAME>, I want to believe you made the right decision.~*/
END XALDGD XA_LD_LastChance

CHAIN XALDGD XA_LD_Chain_ConfirmCharname2
	@150 /*~Morris nods in understanding.~*/
	
	== AERIEJ
	IF ~
		IsValidForPartyDialogue("Aerie")
	~
	@151 /*~I... I understand.  I just... don’t like it.~*/
	
	== ANOMENJ
	IF ~
		IsValidForPartyDialogue("Anomen")
	~
	@151 /*~~It appears we are more kindred spirits than I first thought of you, <CHARNAME>.  I am still uncomfortable about this.~~*/
	
	== CERNDJ
	IF ~
		IsValidForPartyDialogue("Cernd")
	~
	@153 /*~<CHARNAME>, my stance is the same:  Be careful with this power, lest it overtake and taint you.~*/
	
	== EDWINJ
	IF ~
		IsValidForPartyDialogue("Edwin")
	~
	@154 /*~Yes, yes, <CHARNAME>.  All this talk about the ‘greater good’ is just nonsense to make the weak-willed feel better.~ [xald1084]*/
	
	== IMOEN2J
	IF ~
		IsValidForPartyDialogue("Imoen2")
	~
	@155 /*~<PRO_BROTHERSISTER>, your mind is made up.  If that’s what you’re gonna do...  I guess I’ll stay for now.  I still think this necromantic stuff is kinda creepy.~*/
	
	== JAHEIRAJ
	IF ~
		IsValidForPartyDialogue("Jaheira")
	~
	@172 /*~<CHARNAME>, you want to become an undead <PRO_MANWOMAN> so much?  Fine.  You go crazy and I’ll -gladly- kill you and stomp your phylactery to dust!~ */
	
	== JANJ
	IF ~
		IsValidForPartyDialogue("Jan")
	~
	@159 /*~<CHARNAME>, I suppose this is a once-in-a-lifetime opportunity to definitely prove the effects of lichdom on Bhaalspawn!  I promise you I won’t profit off this without your consent!~*/
	
	== KELDORJ
	IF ~
		IsValidForPartyDialogue("Keldorn")
	~
	@160 /*~<CHARNAME>, I have generally trusted you since we met.  I would hate for this apparent sacrifice of yours to cause you to lose your mind or your desire to do what is right for the sake of the world.~*/
	
	== MAZZYJ
	IF ~
		IsValidForPartyDialogue("Mazzy")
	~
	@173 /*~<CHARNAME>, perhaps I was wrong about you.  Do expect me to keep a close guard on you should this power get to your overly bony head!~*/
	
	== MINSCJ
	IF ~
		IsValidForPartyDialogue("Minsc")
	~
	@174 /*~Boo says evil gods stink even more of putrid evil than an evil caster, like a diseased rat corpse that’s been in the sewer for days!  Minsc will stand by your side, for his foot is too small to kick a god’s butt to the ground!~ [xald1100] */
	
	== RASAADJ
	IF ~
		IsValidForPartyDialogue("Rasaad")
	~
	@166 /*~So, <CHARNAME>, it seems like you want me to keep you from the temptation of this new power for the good of us all.~*/
	
	== SAREV25J
	IF ~
		IsValidForPartyDialogue("Sarevok")
	~
	@167 /*~<PRO_BROTHERSISTER>, you are either naive or a schemer of my caliber!~*/
	
	== VALYGARJ
	IF ~
		IsValidForPartyDialogue("Valygar")
	~
	@168 /*~<CHARNAME>, whatever your reasoning, if you go through with this, I simply cannot stay:  The tainted magic is too great!~*/
	DO ~
		SetGlobal("XA_LD_ValygarWillLeave", "GLOBAL", 1)
	~
	
	== VICONIJ
	IF ~
		IsValidForPartyDialogue("Viconia")
	~
	@169 /*~<CHARNAME>, I want to believe you made the right decision.~*/
END XALDGD XA_LD_LastChance

CHAIN XALDGD XA_LD_Chain_ChooseCharname
	@126  /* ~Morris nods approvingly.~*/ 
	== ANOMENJ
	IF ~
		IsValidForPartyDialogue("Anomen")
	~
	@112  /* ~What fellowship can darkness have with the light?  One will overwhelm the other!~ */
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== CERNDJ
	IF ~
		IsValidForPartyDialogue("Cernd")
	~
	@114 /* ~<CHARNAME>, what you seek to become is... unnatural.  Tread lightly lest it overtake you.~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== EDWINJ
	IF ~
		IsValidForPartyDialogue("Edwin")
	~
	@115 /*  ~You seek the secrets to live forever in death like Szass Tam of Thay?  You are a -bold- one, <CHARNAME>.  Just remember how the great Edwin Odisseron helped you and reward your faithful advisor and companion with this same boon.  (This is gonna be worth a fortune!)~ [xald1083]*/
	
	== IMOEN2J
	IF ~
		IsValidForPartyDialogue("Imoen2")
	~
	@116 /*  ~<PRO_BROTHERSISTER>, you’re really gonna do it?  I was quietly hoping you wouldn’t!~ */
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== JAHEIRAJ
	IF ~
		IsValidForPartyDialogue("Jaheira")
	~
	@117  /* ~<CHARNAME>, of all the things you could do for power, you would choose -this- most... unnatural solution?~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== JANJ
	IF ~
		IsValidForPartyDialogue("Jan")
	~
	@118  /*  ~<CHARNAME>, this reminds me of the time my second cousin twice removed on my mother’s side turned into a lich.  The process rendered her permanently, supernaturally, irrevocably mute.  It was the happiest day of our lives!~*/
	
	== KELDORJ
	IF ~
		IsValidForPartyDialogue("Keldorn")
	~
	@119  /* ~Careful, <CHARNAME>.  Whatever power you seek to control -will- take its toll on your soul!~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== MAZZYJ
	IF ~
		IsValidForPartyDialogue("Mazzy")
	~
	@120  /* ~<CHARNAME>, I cannot in good conscience just let you hurl yourself into foolish danger like that!~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== MINSCJ
	IF ~
		IsValidForPartyDialogue("Minsc")
	~
	@121  /* ~Boo says Undead reek of stinking evil!  We would hate to have to kick your butt for goodness!~ [xald1099]*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== RASAADJ
	IF ~
		IsValidForPartyDialogue("Rasaad")
	~
	@122  /* ~I am deeply concerned for your well-being, <CHARNAME>.  You allow temptation to taint you to the very core!~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== SAREV25J
	IF ~
		IsValidForPartyDialogue("Sarevok")
	~
	@123  /* ~So, <PRO_BROTHERSISTER>, you really -are- like our father in loving death!~*/
	
	== VALYGARJ
	IF ~
		IsValidForPartyDialogue("Valygar")
	~
	@124  /* ~<CHARNAME>, what you propose for yourself is of the -most foul of magics!-~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
	== VICONIJ
	IF ~
		IsValidForPartyDialogue("Viconia")
	~
	@125  /* ~<CHARNAME>, be careful.  There is more to this immortal, undead life than you realize.  It makes you a pawn to a different set of actors.~*/
	DO ~
		SetGlobal("XA_LD_ObjectionRaised", "GLOBAL", 1)
	~
	
END XALDGD XA_LD_Chain_ChooseCharname_END

CHAIN CERNDJ XA_LD_Chain_ChooseCernd
	@199 /*~<CHARNAME>, what you propose is powerful, yes, but it does not sit right with my spirit.  I decline your offer.~*/
END XALDGD XA_LD_ChooseAnother

CHAIN EDWINJ XA_LD_Chain_ChooseEdwin
	@207 /*~<CHARNAME>, I am glad your superior intellect has so quickly led you to this decision.  I graciously and eagerly accept my new immortal life.~ [eemored3]*/
END XALDGD XA_LD_EdwinLich

CHAIN HAERDAJ XA_LD_Chain_ChooseHaerDalis
	@208 /*~<CHARNAME>, I have no need of undeath for immortality.  My tiefling heritage already grants me that.~*/
	= @209 /*~But my heart is eager with curiosity to be able to write about this experience and set it to the stage!  For this, I accept.~*/
END XALDGD XA_LD_HaerDalisLich

CHAIN JAHEIRAJ XA_LD_Chain_ChooseJaheira
	@211 /*~<CHARNAME>, I have no desire to become some undead abomination!  Stop asking!~*/
END XALDGD XA_LD_ChooseAnother

CHAIN KELDORJ XA_LD_Chain_ChooseKeldorn
	@212 /*~I must adamantly decline your offer, <CHARNAME>, for I know what my god Torm requires of me.~*/
END XALDGD XA_LD_ChooseAnother

CHAIN MAZZYJ XA_LD_Chain_ChooseMazzy
	@213 /*~No.  Those who wish to act like Paladins do -not- willingly become undead!~*/
END XALDGD XA_LD_ChooseAnother

CHAIN MINSCJ XA_LD_Chain_ChooseMinsc
	@215 /*~Boo is grateful that you were concerned for his safety, but Minsc has other, -secret- plans on how to live long and prosper!  No boniness for us!~*/
END XALDGD XA_LD_ChooseAnother

CHAIN NEERAJ XA_LD_Chain_ChooseNeera
	@217 /*~Now I wonder what’s better - wild magic or undeath.  I -suppose- that being undead would make me immune to a -lot- more oopsies!~*/
	
	= @218 /*~<CHARNAME>, I think what I’m trying to say is yes.  But if it hurts, expect me to scream and cry and maybe run away.~*/
END XALDGD XA_LD_NeeraLich

CHAIN SAREV25J XA_LD_Chain_ChooseSarevok
	@219 /*~<PRO_BROTHERSISTER>, you would help me regain power like the divine essence I lost?  What a wise and gracious <PRO_MANWOMAN> you are!~*/
END XALDGD XA_LD_SarevokLich

CHAIN VALYGARJ XA_LD_Chain_ChooseValygar
	@220 /*~<CHARNAME>, consider this your warning:  Had I not known and respected you as I have, your proposal would have driven me to violence against you.~*/
END XALDGD XA_LD_ChooseAnother

