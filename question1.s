			AREA question1, CODE, READONLY
			ENTRY
			
			ADR r1, STRING1							;Getting the starting address of the original text
			ADR r2, STRING2							;Getting the starting address of were to write the edited text
			LDRB r3, EoS							;Reading the end of string character so we know when the end of string is
t			EQU 116									;Assigning the ASCII value of letter t to the name t readability
h			EQU 104									;Assigning the ASCII value of letter h to the name h to improve readability
e			EQU 101									;Assigning the ASCII value of letter e to the name h to improve readability
spaceChar	EQU 32									;Assigning the ASCII value of letter a space character to the name spaceChar to improve readability

Loop		MOV r10, #1								;Inizalize our counter to 1 to make up for adjust location by at least one later
			LDRB r4, [r1],#1 						;Read in next character in the string 
			
			CMP r4, r3								;If the character is the end of line, then we are done
			BEQ Done								;So if it is equal skip to last line of program
			
			CMP r4, #t								;Else check to see if the letter is a t
			LDRBEQ r4, [r1], #1						;If it is equal to t, read in the next character
			ADDEQ r10, r10, #1						;And advance the counter keep tracking of lenght of word
			CMPEQ r4, #h							;Now compare the 2nd letter in the word with the letter h
			LDRBEQ r4, [r1], #1						;if the the letter is indeed h. Then read in the next character in the word
			ADDEQ r10, r10, #1						;And advance the counter keeping track of the length of the word by one
			CMPEQ r4, #e							;Now compare the 3rd letter in the word with the letter e
			LDRBEQ r4, [r1]							;If the letter is indeed e then read in the next character of the word
			CMPEQ r4, #spaceChar					;Now check if this is the end of the word i.e. a space after the letter e
			BEQ Loop								;If it is that means the word must be "the" so we wont write it to the new string. So go back to top of loop
			
			CMPNE r10, #3							;Now check if we are running this command because the last the first 3 character are the but the 4th wasnt a space
			CMPEQ r4, r3							;If it is it can still be the end of the word if the character is end of line. 
			SUBNE r1, r1, r10						;Else we get here and its not "the" so bring pointer back to the orginal spot
			LDRBNE r4, [r1], #1						;Read in this character in that spot
			STRBNE r4, [r2], #1						;And then write it to the new string
			B Loop									;Go back to the top and find the next word

Done		STRB r3, [r2]							;Writing the null character after the last character to indicate end of string
Terminate 	B Terminate 							;Marking end of the program
			
			AREA question1, DATA, READWRITE
STRING1 	DCB "breathe"		;String1
EoS			DCB 0x00								;end of string1	
STRING2		space 0xFF								;just allocating 255 bytes
			END 									;By: Jakob Wanger, Student Number: 250950022