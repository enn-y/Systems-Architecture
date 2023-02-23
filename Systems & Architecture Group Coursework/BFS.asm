1:  BFS


			
			AREA bfscmp, CODE, READONLY
			
			ADR r1, og		;r1 pointer to original array
			ADR r4, og		;r4 pointer to start of sorted array
			ADR r10, sorted	;r10 pointer to sorted array
			ADR r9, sorted		;r9 pointer to sorted array			
			MOV r0, #0		;set initial counter to 0
			MOV r5, #0		;stored value counter
			MOV r6, #0		;compared initialise
			LDRB r2,[r1],#1	;load value pointed by r1 into r2, then pointer increments and points to next value
			
comp
		CMP r0, #14
		BEQ storenum	;store final number in register(6) which will be compared to, and slot number into sorted array
		BL checksorted	;branch to check if number has appeared in sorted array, skips it if it is already inside
		ADR r4, og		;reset both pointers back to original poisition at the front of each list
		ADR r9, sorted
		LDRB r3,[r1],#1	;load value pointed by r1 into r3, then increments r1 pointer to point to next element
		CMP r3,r6
		BLE	skip		;skip means r1 has already been stored, because any value that is stored should be smaller or equal to the recent stored number, and inside skip, r2 should be loaded with new values
		CMPGT r2,r3		;if r3 is smaller than r2, then replace r2 with r3
		BLGE changemain
		ADD r0, r0,#1
		B comp
		
skip
		ADD r0, r0,#1
		B comp
		
changemain
		MOV r2,r3		;replaces r2 with r3
		BX lr			;branches back to link register
		
storenum
		MOV r0, #0		;reset counter
		MOV r6, r2		;compared (number must be greater than this to be stored)
		STRB r2, [r10], #1	;r10 points to the memory location of sorted array, stores final value there. increment pointer by one to point to next index of sorted array
		ADD r5, r5,#1	;r5++
		CMP r5, #15		;if numbers that have been stored = 15(size of array), then ends program
		BEQ endprog
		ADR r1, og		;r1 re-points to start of original array
		ADR r9, og		;r9 also re-points to start of orignal array
		LDRB r2,[r1],#1	;load value pointed by r1 into r2, then pointer increments and points to next value
		B comp			;go back to comp
		
checksorted
		LDRB r8,[R9],#1
		CMP r8,0x00
		BXEQ lr
		CMP r2,r8
		BEQ changeori
		B checksorted
		
changeori
		LDRB r2, [r4],#1
		ADR r9, sorted
		B checksorted
		
endprog B endprog
		
og		DCB		10, 5, 30, 78, 2, 19, 11, 23, 48, 79, 1, 14, 9, 41, 31
sorted	SPACE	15
			END