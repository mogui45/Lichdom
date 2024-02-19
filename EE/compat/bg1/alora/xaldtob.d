EXTEND_BOTTOM XALDGD2 15
	//{ Alora
	IF ~
		IsValidForPartyDialogue("7XALORA")
		!General("7XALORA", UNDEAD)
		LevelGT("7XALORA", 11)
	~
	THEN REPLY @6 /*~(Choose Alora.)~*/
	EXTERN 7XAlo25J XA_LD_ChooseAlora
	//}
	
END

EXTEND_BOTTOM XALDGD2 18
	//{ Alora
	IF ~
		IsValidForPartyDialogue("7XALORA")
		!General("7XALORA", UNDEAD)
		LevelGT("7XALORA", 11)
	~
	THEN REPLY @6 /*~(Choose Alora.)~*/
	EXTERN 7XAlo25J XA_LD_ChooseAlora
	//}
	
END

//{ Alora
APPEND 7XAlo25J
	IF ~~ THEN BEGIN XA_LD_ChooseAlora
		SAY @2 /*~~Me?  A lich?  I dunno.  It doesn’t seem very cute!~~*/
		
		IF ~~ THEN REPLY @3  /*~You’re right.  Nevermind.~ */
		EXTERN XALDGD2 18
		
		IF ~~ THEN REPLY @4  /*~Think of all the treasures you could amass if you never needed to eat or breathe again!~ */
		GOTO XA_LD_ChooseAloraOK
	END
	
	IF ~~ THEN BEGIN XA_LD_ChooseAloraOK
		SAY @5 /* ~That -does- sound good!  I’ll do it!~*/
		
		IF ~~ THEN 
		DO ~
			SetGlobal("XA_LD_TransformLich", "LOCALS", 1)
		~
		EXTERN XALDGD2 74
	END
END
//}
