2: MERGE SORT

;NOTES BEFORE RUNNING CODE, WHEN MAPPING MEMORY, MUST MAP FROM THE START OF THE FIRST LIST - THE ADDRESS THAT APPEARS IN R1, AND GIVE PERMISSION/ACCESS FOR READ, WRITE AND ALSO EXECUTE
;THE FINAL SORTED ARRAY WILL APPEAR IN LIST ONE


			AREA mergethis, CODE, READONLY
			ENTRY
	
			ADR r1, listone	;final sorted array will appear in this array
			ADR r2, listtwo
			MOV r8, #0

layerone
		CMP r8, #10
		BEQ resettotwo
		LDRB r3,[r1],#1
		LDRB r4,[r1],#1
		CMP r3,r4
		STRBLT r3,[r2],#1
		STRBGT r4,[r2],#1
		STRBLT r4,[r2],#1
		STRBGT r3,[r2],#1
		ADD r8, r8, #2
		B layerone

listone	DCB		8,50,81,29,4,24,23,30,1,7
listtwo	SPACE	10
	
resettotwo
		MOV r8,#0
		ADR r1, listtwo
		ADR r2, listone
		MOV r5, r1
		ADD r5, #2			;r5 is second pointer
		MOV r11, r5				;r11 is anchor that signals end of rhs list
		MOV r7, r1				;r7 is anchor that signals end of lhs list, once r11/r7 equals to respective pointer, branches to copy the list
		ADD r7, #4
		LDRB r3,[r1],#1
		LDRB r4,[r5],#1
		B layertwo
		
resettothree
		MOV r8, #0
		ADR r1, listone
		ADR r2, listtwo
		MOV r5, r1
		ADD r5, #4				;r5 is second pointer
		MOV r11, r5				;r11 is anchor that signals end of rhs list
		MOV r7, r1				;r7 is anchor that signals end of lhs list, once r11/r7 equals to respective pointer, branches to copy the list
		ADD r7, #8
		LDRB r3,[r1],#1
		LDRB r4,[r5],#1
		B layerthree
		
resettofour
		MOV r8, #0
		ADR r1, listtwo
		ADR r2, listone
		MOV r5, r1
		ADD r5, #8			;r5 is second pointer
		MOV r11, r5				;r11 is anchor that signals end of rhs list
		MOV r7, r1				;r7 is anchor that signals end of lhs list, once r11/r7 equals to respective pointer, branches to copy the list
		ADD r7, #10
		LDRB r3,[r1],#1
		LDRB r4,[r5],#1
		B layerfour
		
layertwo
		CMP r8, #4
		BLEQ reindex2
		CMP r8, #8
		BEQ resettothree
		CMP r1, r11
		BGT endrhs2
		CMP r5, r7
		BGT endlhs2
		CMP r3,r4
		STRBLT r3,[r2],#1
		STRBGT r4,[r2],#1
		LDRBLT r3,[r1],#1
		LDRBGT r4,[r5],#1
		ADD r8, r8,#1
		B layertwo

reindex2 ;should point to second set of 2 element lists
		ADR r1, listtwo
		ADD r1, r1, #4
		MOV r5, r1
		ADD r5, #2			;r5 is second pointer
		MOV r11, r5				;r11 is anchor that signals end of rhs list
		MOV r7, r1				;r7 is anchor that signals end of lhs list, once r11/r7 equals to respective pointer, branches to copy the list
		ADD r7, #4
		LDRB r3,[r1],#1
		LDRB r4,[r5],#1
		BX lr


endrhs2		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r4, [r2],#1
		LDRB r4, [r5],#1
		ADD r8, r8,#1
		B layertwo

endlhs2		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r3, [r2],#1
		LDRB r3, [r1],#1
		ADD r8, r8,#1
		B layertwo
		
layerthree 
		CMP r8, #8
		BEQ resettofour
		CMP r1, r11
		BGT endrhs3
		CMP r5, r7
		BGT endlhs3
		CMP r3,r4
		STRBLT r3,[r2],#1
		STRBGT r4,[r2],#1
		LDRBLT r3,[r1],#1
		LDRBGT r4,[r5],#1
		ADD r8, r8,#1
		B layerthree
		

endrhs3		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r4, [r2],#1
		LDRB r4, [r5],#1
		ADD r8, r8,#1
		B layerthree

endlhs3		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r3, [r2],#1
		LDRB r3, [r1],#1
		ADD r8, r8,#1
		B layerthree

layerfour 
		CMP r8, #10
		BEQ done
		CMP r1, r11
		BGT endrhs4
		CMP r5, r7
		BGT endlhs4
		CMP r3,r4
		STRBLT r3,[r2],#1
		STRBGT r4,[r2],#1
		LDRBLT r3,[r1],#1
		LDRBGT r4,[r5],#1
		ADD r8, r8,#1
		B layerfour

endrhs4		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r4, [r2],#1
		LDRB r4, [r5],#1
		ADD r8, r8,#1
		B layerfour

endlhs4		;when right hand side list has all been merged, should copy all leftover left hand side array value into list
		STRB r3, [r2],#1
		LDRB r3, [r1],#1
		ADD r8, r8,#1
		B layerfour

done B done
	
			END