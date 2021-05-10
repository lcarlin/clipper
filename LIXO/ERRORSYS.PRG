/***
*
*       Errorsys.prg
*
*  Standard Clipper error handler
*
*  Copyright (c) 1990-1993, Computer Associates International, Inc.
*  All rights reserved.
*
*  Compile:  /m /n /w
*
*/

#include "error.ch"
#include "fileio.ch"

// put messages to STDERR
#command ? <list,...>   =>  ?? Chr(13) + Chr(10) ; ?? <list>
#command ?? <list,...>  =>  OutErr(<list>)
#define SIM   "Sim"
#define NAO   "N„o"



// used below
//#define NTRIM(n)              ( LTrim(Str(n)) )
static function ntrim(n)
return ( LTrim(Str(n)) )


/***
*       ErrorSys()
*
*       Note:  automatically executes at startup
*/

proc ErrorSys()
	ErrorBlock( {|e| DefError(e)} )
return




/***
*       DefError()
*/
static func DefError(e)
local i, cMessage, aOptions, nChoice, MyMess



	// by default, division by zero yields zero
	if ( e:genCode == EG_ZERODIV )
		return (0)
	end


	// for network open error, set NETERR() and subsystem default
	if ( e:genCode == EG_OPEN .and. e:osCode == 32 .and. e:canDefault )

		NetErr(.t.)
		return (.f.)                                                                    // NOTE

	end


	// for lock error during APPEND BLANK, set NETERR() and subsystem default
	if ( e:genCode == EG_APPENDLOCK .and. e:canDefault )

		NetErr(.t.)
		return (.f.)                                                                    // NOTE

	end



	// build error message
	cMessage := ErrorMessage(e)


	// build options array
	// aOptions := {"Break", "Quit"}
//      aOptions := {"Quit"}
	aOptions := {"Abortar"}


	if (e:canRetry)
		AAdd(aOptions, "Repetir")
	end

	if (e:canDefault)
		AAdd(aOptions, "Ignorar")
	end

	M->MySugest := MyMess := ""

	// put up alert box
	nChoice := 0


	DO CASE
	   CASE e:Severity ==ES_WHOCARES
		MyMess := "ATEN€O:"
		M->MySugest := "IGNORAR ou REPITIR"
	   CASE e:Severity ==ES_WARNING
		MyMess := "CUIDADO:"
		M->MySugest := "REPITIR ou IGNORAR"
	   CASE e:Severity ==ES_ERROR
		MyMess := "ERRO:"
		M->MySugest := "ABORTAR ou REPITIR"
	   CASE e:Severity ==ES_CATASTROPHIC
		MyMess := "ERRO FATAL:"
		M->MySugest := "ABORTAR"
	ENDCASE

	MyMess += "Anormalidade na execu‡„o do sistema; "+cMessage+" ;A Op‡„o sugerida e "+M->MySugest

	while ( nChoice == 0 )


	      warnTone()


		if ( Empty(e:osCode) )
			nChoice := Alert( MyMess, aOptions )

		else
			nChoice := Alert( MyMess + ;
							";(DOS Error " + NTRIM(e:osCode) + ")", ;
							aOptions )
		end


		if ( nChoice == NIL )
			exit
		end

	end


	if ( !Empty(nChoice) )

		// do as instructed
		if ( aOptions[nChoice] = "Cancelar" )
			Break(e)

		elseif ( aOptions[nChoice] = "Repetir" )
			return (.t.)

		elseif ( aOptions[nChoice] = "Ignorar" )
			return (.f.)

		end

	end


	// display message and traceback
	if ( !Empty(e:osCode) )
		cMessage += " (DOS Error " + NTRIM(e:osCode) + ") "
	end

	SET COLOR TO
	CLS
	WARNTONE()
	?"Data: "+dtoc(date())+" / Hora: "+time()
	?replicate("Ä",maxcol())
	?"Aten‡„o : Ocorreu um erro fatal durante a execu‡„o do sistema !!"
	?"    1 - Entre em contato com a assistˆncia t‚cnica "
	?"    2 - NO utilize mais a op‡„o do sistema que originou o erro"
	?replicate("Ä",maxcol())
	?"Mensagem : "
	?cMessage
	?" "
	i := 2
	?"Procedimentos: "
	WHILE (!empty(Procname(i)))
	   IF I = 2
	      ?"Procedimento - ",trim(procName(i))+"("+nTrim(procline(i))+")"
	   ELSE
	      ??" -- ", TRIM(PROCNAME(I)) + "("+NtRIM(PROCLINE(I))+")"
	   ENDIF
	   I++
	END
	?REPLICATE(CHR(196),MAXCOL())
	IF ! ERRORFILE( E , cMessage )
	   ?"****************************************************************"
	   ?"* Aten‡„o: N„o foi possivel gravar o Log de error (ERROR.LOG)! *"
	   ?"*   ANOTE OS DADOS ACIMA !!!                                   *"
	   ?"****************************************************************"
	ELSE
	   ?"As informa‡”es acima foram gravadas no arquivo ERROR.LOG"
	ENDIF

	// give up
	ERRORLEVEL(1)
	QUIT
RETURN (.F.)

/*
	? cMessage
	i := 2
	while ( !Empty(ProcName(i)) )
		? "Called from", Trim(ProcName(i)) + ;
			"(" + NTRIM(ProcLine(i)) + ")  "

		i++
	end


	// give up
	* ErrorLevel(1)
	QUIT

return (.f.)

*/


/***
*       ErrorMessage()
*/
static func ErrorMessage(e)
local cMessage


	// start error message
	cMessage := if( e:severity > ES_WARNING, "Erro ", "Aten‡„o! " )


	// add subsystem name if available
	if ( ValType(e:subsystem) == "C" )
		cMessage += e:subsystem()
	else
		cMessage += "???"
	end


	// add subsystem's error code if available
	if ( ValType(e:subCode) == "N" )
		cMessage += ("/" + NTRIM(e:subCode))
	else
		cMessage += "/???"
	end


	// add error description if available
	if ( ValType(e:description) == "C" )
		cMessage += ("  " + e:description)
	end


	// add either filename or operation
	if ( !Empty(e:filename) )
		cMessage += (": " + e:filename)

	elseif ( !Empty(e:operation) )
		cMessage += (": " + e:operation)

	end


return (cMessage)


/*  by "O Corsario (TM)" */

/*
* ErrorFile()
*/

Static Function Errorfile( er, Mens )
LOCAL conta, efh, valret, lf := chr(13)+chr(10)
LOCAL I, NomeFile := "ERROR.LOG"
IF ! FILE(NOMEFILE)
   EFH := FCREATE(NOMEFILE)
ELSE
   EFH := FOPEN(NOMEFILE,FO_READWRITE)
   IF FERROR() == 0
      fSeek(efh,-1,FS_END)
      FWRITE(EFH , LF+ LF)
   ENDIF
ENDIF

IF FERROR() <> 0
   aLERT("Problema com o arquivo de LOG de error !!")
   return (.F.)
ENDIF
FWRITE(EFH,REPLICATE("*",80)+LF)
FWRITE(EFH, "Data.........:" + dtoc(date())+ " / Hora:"+time()+LF)
FWRITE(EFH, "Mensagem.....:")
FWRITE(EFH, mens+LF+LF)
FWRITE(EFH, "can Default..:" + if(er:CanDefault,SIM,NAO)+LF)
FWRITE(EFH, "can Retry....:" + if(er:CanRetry,SIM,NAO)+LF)
FWRITE(EFH, "can Subst....:" + if(er:CanSubstitute,SIM,NAO)+LF)
FWRITE(EFH, "Descricao....:" + Er:Description+LF)
FWRITE(EFH, "Arquivo......:" + Er:FileName+LF)
FWRITE(EFH, "GenCode......:" + NTRIM(Er:GENCODE)+LF)
FWRITE(EFH, "Opera‡„o.....:" + Er:Operation+LF)
FWRITE(EFH, "DOS..........:" + NTRIM(Er:OSCODE)+LF)
FWRITE(EFH, "SubSistema...:" + Er:SubSystem+LF)
FWRITE(EFH, "Tentativas...:" + NTRIM(Er:tries)+LF)
i := 3
FWRITE(EFH, "Procedimentos:" + LF)

while ( ! empty (ProcName(i)))
   FWRITE(EFH, "->"+Trim(procname(i))+"("+NTRIM(PROCLINE(I))+")" )
   I++
END
NVALRET := IF(FCLOSE(EFH),.T.,.F.)
RETURN (NVALRET)

/*******************
* WARNTONE()
*/
STATIC FUNCTION WarnTone
TONE(294,2.5)
TONE(294,1.5)
TONE(247,2.5)
TONE(330,1.5)
TONE(294,2.5)
TONE(247,6)
RETURN (.t.)
