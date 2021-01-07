	.text
	.intel_syntax noprefix
	.globl	fix_jmp
	.type	fix_jmp, @function
	.globl	fix_jmpnz_ex
	.type	fix_jmpnz_ex, @function
        .globl  fix_jmpznz
        .type   fix_jmpznz, @function
	.global fix_new
	.type	fix_new, @function
	.global fix_catch
	.type	fix_catch, @function
fix_jmp:
	mov	   rdx, QWORD PTR [rsi]			# set rdx to point to some structure containing other pointers	
	push       rbp          
	movabs     rsi, 0xaaaaaaaaaaaaaaab
	push       rbx          
	sub        rsp, 0x8     
	mov        rbx, qword ptr [rdi] 		# rdi points to opline
	mov        rax, qword ptr [rdi+0x28] 
	movsxd     rdx, dword ptr [rdx] 
	mov        rbp, qword ptr [rbx+8] 
	mov        rcx, rbp     
	mov        rdx, qword ptr [rax+rdx*8+0xd0] 
	mov        rax, qword ptr [rax+0x40] 
	sub        rcx, rax     
	mov        rdx, qword ptr [rdx] 
	sar        rcx, 0x4     
	imul       rcx, rsi     
	shl        rcx, 0x4     
	mov        ecx, dword ptr [rcx+rdx] 
	lea        rcx, qword ptr [rcx+rcx*2] 
	shl        rcx, 0x4     
	lea        rcx, qword ptr [rax+rcx] 
	mov        qword ptr [rbx+8], rcx 
	mov        rcx, rbx     
	sub        rcx, rax     
	mov        rax, rcx     
	sar        rax, 0x4    
	imul       rax, rsi     
	shl        rax, 0x4
	# originally this would call ZEND_SPEC_JMP_HANDLER
	# but now, we'll just set the opline->handler to the real one
	mov rcx, qword PTR [rdx+rax+8]
	mov	   qword PTR [rbx], rcx
	# removed
	# this will reset op1 values to original "obfuscated" values
	# mov        qword [rbx+8], rbp      
	add        rsp, 0x8     
	pop        rbx          
	pop        rbp          
	ret


fix_jmpnz_ex:
        mov        rdx, QWORD PTR [rsi]                 # set rdx to point to some structure containing other pointers  
        push       rbp
        movabs     rsi, 0xaaaaaaaaaaaaaaab
        push       rbx
        sub        rsp, 0x8
        mov        rbx, qword ptr [rdi]                 # rdi points to opline
        mov        rax, qword ptr [rdi+0x28]
        movsxd     rdx, dword ptr [rdx]
        mov        rbp, qword ptr [rbx+0x10]
        mov        rcx, rbp
        mov        rdx, qword ptr [rax+rdx*8+0xd0]
        mov        rax, qword ptr [rax+0x40]
        sub        rcx, rax
        mov        rdx, qword ptr [rdx]
        sar        rcx, 0x4
        imul       rcx, rsi
        shl        rcx, 0x4
        mov        ecx, dword ptr [rcx+rdx]
        lea        rcx, qword ptr [rcx+rcx*2]
        shl        rcx, 0x4
        lea        rcx, qword ptr [rax+rcx]
        mov        qword ptr [rbx+0x10], rcx
        mov        rcx, rbx
        sub        rcx, rax
        mov        rax, rcx
        sar        rax, 0x4
        imul       rax, rsi
        shl        rax, 0x4
        # originally this would call ZEND_SPEC_JMP_HANDLER
        # but now, we'll just set the opline->handler to the real one
        mov rcx, qword PTR [rdx+rax+8]
        mov        qword PTR [rbx], rcx
        # removed
        # this will reset op1 values to original "obfuscated" values
        # mov        qword [rbx+0x10], rbp      
        add        rsp, 0x8
        pop        rbx
        pop        rbp
        ret

fix_jmpznz:
	mov        rdx, QWORD PTR [rsi]                 # set rdx to point to some structure containing other pointers
	mov    QWORD PTR [rsp-0x18],rbx
	mov    QWORD PTR [rsp-0x10],rbp
	mov    QWORD PTR [rsp-0x8],r12
	sub    rsp,0x18
	mov        rbx, qword ptr [rdi]                 # rdi points to opline
	mov    rax,QWORD PTR [rdi+0x28]
	mov    rbx,QWORD PTR [rdi]
	movsxd rdx,DWORD PTR [rdx]
	mov    r12d,DWORD PTR [rbx+0x10]
	mov    ebp,DWORD PTR [rbx+0x20]
	mov    rdx,QWORD PTR [rax+rdx*8+0xd0]
	mov    ecx,r12d
	mov    rax,QWORD PTR [rax+0x40]
	shl    rcx,0x4
	mov    rdx,QWORD PTR [rdx]
	mov    ecx,DWORD PTR [rcx+rdx*1]
	mov    DWORD PTR [rbx+0x10],ecx
	mov    rcx,rbp
	shl    rcx,0x4
	mov    ecx,DWORD PTR [rdx+rcx*1]
	mov    QWORD PTR [rbx+0x20],rcx
	mov    rcx,rbx
	sub    rcx,rax
	mov    rax,rcx
	movabs rcx,0xaaaaaaaaaaaaaaab
	sar    rax,0x4
	imul   rax,rcx
	shl    rax,0x4
	# set handler
	mov rcx, qword PTR [rdx+rax+8]
        mov        qword PTR [rbx], rcx
	#call   QWORD PTR [rdx+rax*1+0x8]
	#mov    DWORD PTR [rbx+0x10],r12d
	#mov    QWORD PTR [rbx+0x20],rbp
	mov    rbx,QWORD PTR [rsp]
	mov    rbp,QWORD PTR [rsp+0x8]
	mov    r12,QWORD PTR [rsp+0x10]
	add    rsp,0x18
	ret

fix_new:
	mov        rdx, QWORD PTR [rsi]                 # set rdx to point to some structure containing other pointers
	push   rbp
	push   rbx
	sub    rsp,0x8
	mov    rax,QWORD PTR [rdi+0x28]
	mov    rbx,QWORD PTR [rdi]
	movsxd rdx,DWORD PTR [rdx]
	mov    ebp,DWORD PTR [rbx+0x10]
	mov    rdx,QWORD PTR [rax+rdx*8+0xd0]
	mov    ecx,ebp
	mov    rax,QWORD PTR [rax+0x40]
	shl    rcx,0x4
	mov    rdx,QWORD PTR [rdx]
	mov    ecx,DWORD PTR [rcx+rdx*1]
	mov    DWORD PTR [rbx+0x10],ecx
	mov    rcx,rbx
	sub    rcx,rax
	mov    rax,rcx
	movabs rcx,0xaaaaaaaaaaaaaaab
	sar    rax,0x4
	imul   rax,rcx
	shl    rax,0x4
	# set handler
        mov rcx, qword PTR [rdx+rax+8]
        mov        qword PTR [rbx], rcx
	#call   QWORD PTR [rdx+rax*1+0x8]
	#mov    DWORD PTR [rbx+0x10],ebp
	add    rsp,0x8
	pop    rbx
	pop    rbp
	ret

fix_catch:
	mov        rdx, QWORD PTR [rsi]                 # set rdx to point to some structure containing other pointers
	push   rbp
	push   rbx
	sub    rsp,0x8
	
	mov    rbx,QWORD PTR [rdi]
	mov    rax,QWORD PTR [rdi+0x28]
	movsxd rdx,DWORD PTR [rdx]
	mov    ebp,DWORD PTR [rbx+0x20]
	mov    rdx,QWORD PTR [rax+rdx*8+0xd0]
	mov    rcx,rbp
	mov    rax,QWORD PTR [rax+0x40]
	shl    rcx,0x4
	mov    rdx,QWORD PTR [rdx]
	mov    ecx,DWORD PTR [rdx+rcx*1]
	mov    QWORD PTR [rbx+0x20],rcx
	mov    rcx,rbx
	sub    rcx,rax
	mov    rax,rcx
	movabs rcx,0xaaaaaaaaaaaaaaab
	sar    rax,0x4
	imul   rax,rcx
	shl    rax,0x4

	mov rcx, qword PTR [rdx+rax+8]
        mov        qword PTR [rbx], rcx
	#call   QWORD PTR [rdx+rax*1+0x8]
	#mov    QWORD PTR [rbx+0x20],rbp
	add    rsp,0x8
	pop    rbx
	pop    rbp
	ret    
