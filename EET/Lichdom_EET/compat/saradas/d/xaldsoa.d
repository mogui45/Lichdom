EXTEND_BOTTOM XALDGD 15
	IF ~
		IsValidForPartyDialogue("!Sartob")
		!General("!Sartob", UNDEAD)
		LevelGT("!Sartob", 11)
	~
	THEN REPLY @3 /*~(Choose Saradas.)~*/
	EXTERN ~!SarJ~ XA_LD_ChooseSaradas
END

EXTEND_BOTTOM XALDGD 18
	IF ~
		IsValidForPartyDialogue("!Sartob")
		!General("!Sartob", UNDEAD)
		LevelGT("!Sartob", 11)
	~
	THEN REPLY @3 /*~(Choose Saradas.)~*/
	EXTERN ~!SarJ~ XA_LD_ChooseSaradas
END

/* Interjections won't compile, because Weidu is interpreting the "!" prefix as a control character. Future mod writers - please stick to an alphanumeric prefix. */

/*
INTERJECT_COPY_TRANS2 XALDGD 75 XA_LD_!SarJ_75
	== ~!SarJ~
	IF ~
		IsValidForPartyDialogue("!Sartob")
	~
	@2 
END

INTERJECT_COPY_TRANS2 XALDGD 76 XA_LD_!SarJ_76
	== ~!SarJ~
	IF ~
		IsValidForPartyDialogue("!Sartob")
	~
	@0 
END

INTERJECT_COPY_TRANS2 XALDGD 77 XA_LD_!SarJ_77
	== ~!SarJ~
	IF ~
		IsValidForPartyDialogue("!Sartob")
	~
	@0 
END
*/


APPEND ~!SarJ~
	IF ~~ THEN BEGIN XA_LD_ChooseSaradas
		SAY @1 /* ~While I have lived long and have some regrets, becoming a lich is a regret I’ll not choose.~*/
		
		IF ~~ THEN
		EXTERN XALDGD 18
	END
END