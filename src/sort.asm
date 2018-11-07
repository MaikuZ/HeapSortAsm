; Implemented by MaikuZ
; Licensed under: CC-BY-4.0
; HeapSort in assembly
; entry point is void sort(long * data, unsigned long size);
BITS        64
SECTION     .text
GLOBAL      sort

shift_down:; rdi -> data, rsi -> arg_2
	mov rdx,rsi;  k := arg_2
	while_shift_down:
		mov rcx,rdx; j := k
			;if(2*j <= n) and T[2*j] > T[k]
			lea r8, [rcx + rcx*1]; r8 := 2j
			cmp r8, r11; 2j,n
			ja first_not; 2j > n; break
				mov r9, [rdi + rdx * 8]; r9 := T[k]
				
				cmp r9, [rdi + r8*8]; cmp T[k],T[2j]
				jge first_not;T[k] >= T[2j]; break
					lea rdx,[rcx + rcx*1 + 0]; k:=j*2
			first_not:
			;if(2*j + 1<= n) and T[2*j+1] > T[k]
			lea r8, [rcx + rcx*1 + 1]; r8 := 2j + 1
			cmp r8, r11; 2j  < n <-> 2j + 1<= n
			ja second_not;
				mov r9, [rdi + rdx * 8]; r9 := T[k]
				
				cmp r9, [rdi + r8*8]; cmp T[k],T[2j+1]
				jge second_not;
					lea rdx,[rcx + rcx*1 + 1]; k: = j*2 + 1
			second_not:
			
			mov r9, [rdi + rdx * 8];r9 := data[k]
			mov r10, [rdi + rcx * 8]; r10 := data[j]
		
			mov [rdi + rdx * 8], r10; 
			mov [rdi + rcx * 8], r9; 
			
			cmp rcx,rdx;//cmp(k,j)
			jne while_shift_down;//rcx != rdx
			
		pop rdx; rdx get from stack
		cmp rdx,1; rdx!=0
		jne after_shift_down_2; rdx != 1 jump to 2
		jmp after_shift_down_1; rdx == 1 jump to 1
		; end shift_down
		
build_heap:
	mov rdx,r11;rdx := size, i := size
	shr rdx,1; rdx /= 2;
	
	begin_build_heap:
		cmp rdx,0;
			jne continue_build_heap; rdx != 0 continue loop
			jmp after_build_heap;
		continue_build_heap:
		
		push rdx;
		push 2;
		mov rsi,rdx;
		jmp shift_down;
		after_shift_down_2:
		pop rdx;
		sub rdx,1;
		
		jmp begin_build_heap;

sort:
	mov r11, rsi;
	sub rdi,8;
	jmp build_heap;
	after_build_heap:
	
	mov rdx, r11;
	begin_sort:
		cmp rdx,1; 
		je end_sort;
		
		mov r9, [rdi + 1*8];r9 := data[1]
		mov r10, [rdi + rdx * 8]; r10 := data[i]
		
		mov [rdi + 1*8], r10; 
		mov [rdi + rdx * 8], r9; 
		
		sub rdx,1;
		push rdx;
		push 1;
		mov r11,rdx;
		jmp shift_down;
		after_shift_down_1:
		pop rdx;
		jmp begin_sort;
		
	end_sort:
	ret;
