.data
    	filein: .asciiz "dethi.txt"
		entersign:.asciiz "\n"
		#So luong tu xuat hien trong de thi
		n:.word 0
	    buffer:.space 1000
    	username:.space 50
        word: .space 100
		#Mang so nguyen chua index cac tu da radom
		TuDaRandom:.space 100
 

.text

  

						
		la $a0,filein
		la $a1,buffer		
		jal _DocFile		
		
		la $a0,buffer
		jal _SoLuongTuTrongDeThi		
		
		move $t0,$v0
		
		#Khoi tao mang
		move $a1,$v0
		la $a0,TuDaRandom
		jal _KhoiTaoMang
		
		#
		
		la $a0,buffer
		la $a1,TuDaRandom
		la $a2,word
		jal _ChonMotTuDeDocTuBuffer

		li $v0,4
		la $a0,word
		syscall
		
		move $a0,$v0
		li $v0,1
		syscall
		
		
	
		
		
		
    		

	


ExitProgram:
	    li $v0,10
	    syscall


	


#Dang nhap game

#Main Loop Game



#Che do doan 1 ki tu

#Che do doan 1 ki tu

#Che do doan 1 chu


#Cap nhat trang thai nguoi choi

    #Cap nhat man hinh o che do 1 ki tu

    #Cap nhat man hinh o che do 1 chu

#Ve man hinh doan sai theo so luot choi

#Cap nhat data nguoi choi khi nguoi choi chien thang (Diem = Diem + So luong ki tu)

#Ham Dem so luong ki tu trong 1 chuoi
    #Nhan vao a0 la dia chi cua chuoi
	
	#Tested
_DemSoLuongKiTu:
        addi $sp,$sp,-32
        sw $ra,($sp)
		sw $s0,4($sp)
		sw $t1,8($sp)
		sw $t0,12($sp)
		
		move $s0,$a0
		
		li $t1,0
		
		_DemSoLuongKiTu.Loop:
			
			lb $t0,($s0)		
			beq $t0,$0,_DemSoLuongKiTu.ExitLoop			
			
				addi $t1,$t1,1
				addi $s0,$s0,1
		
		j _DemSoLuongKiTu.Loop
		
		_DemSoLuongKiTu.ExitLoop:
		
		move $v0,$t1
		
		lw $ra,($sp)
		lw $s0,4($sp)
		lw $t1,8($sp)
		lw $t0,12($sp)
		addi $sp,$sp,32
		jr $ra
		
			
    
#->> NEED fixa
#Ham Chon de tu 1 chuoi de doc tu buffer
	#Nhan vao dia chi buffer -> $a0
	#Nhan vao dia chi cua mang TuDaRandom -> $a1
	#Nhan vao dia chi cua word -> $a2
	
_ChonMotTuDeDocTuBuffer:
		
		addi $sp,$sp,-32
		sw $ra,($sp)
		sw $s0,4($sp)
		sw $s1,8($sp)
		sw $t1,12($sp)
		sw $t0,16($sp)
		sw $s2,20($sp)
		sw $s3,24($sp)
		
		
		
		#Luu lai dia chi buffer
		
		move $s0,$a0
		
		#Luu dia chi cua mang TuDaRandom
		
		move $s2,$a1
		
		#Luu lai dia chi cua word
		
		move $s3,$a2
		
		#Lay ra ki tu dau tien
		lb $s1,($s0)
		#Chuyen ve so nguyen
		#$s1 -> So luong de trong dethi.txt
		addi $s1,$s1,-48
		
		
		
		
		
		
		
		_ChonMotTuDeDocTuBuffer.DoWhileLoop:
			#Goi ham random -> 0<=[int]<upper bound		
			
			move $a1,$s1
			li $v0,42
			syscall
			#Ket qua random tu thu i = $t0		
			
			move $t0,$a0
			
			
			move $a0,$s0
			move $a1,$s1
			move $a2,$t0
			jal _KiemTraTinhHopLeCuaTuMoi
			
			move $t1,$v0
			#Neu tu chua duoc chon -> $v0 = 1 -> 
			#thuc hien danh dau
			
			
			beq $t1,1,_ChonMotTuDeDocTuBuffer.ThucHienDanhDau
		
			
			#Neu mang da danh dau het -> $v0 = -1 -> 
			#tra ve -1 ket thuc ham
			beq $t1,-1,_ChonMotTuDeDocTuBuffer.HetTuTrongDeThi			
			
			#Neu tu duoc chon va mang chua duoc danh dau het->
			#Tiep tuc random			
	
		j _ChonMotTuDeDocTuBuffer.DoWhileLoop
			
		
		_ChonMotTuDeDocTuBuffer.ExitLoop:
			
		_ChonMotTuDeDocTuBuffer.ThucHienDanhDau:
			
			#Doc ki tu vao word
			move $a0,$s0
			move $a1,$t0
			move $a2,$s3			
			jal _DocMotTuVaoWord
			
				
			add $s2,$s2,$t0			
			li $t1,1
			sb $t1,($s2)			
			li $v0,1							
			j _ChonMotTuDeDocTuBuffer.Restore
		
		_ChonMotTuDeDocTuBuffer.HetTuTrongDeThi:
			li $v0,0
		j _ChonMotTuDeDocTuBuffer.Restore
		
		_ChonMotTuDeDocTuBuffer.Restore:
		
		
		lw $ra,($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $t1,12($sp)
		lw $t0,16($sp)
		lw $s2,20($sp)
		lw $s3,24($sp)
		addi $sp,$sp,32
		
		
		jr $ra
		
#Ham kiem tra tu tai vi tri n da duoc chon hay chua
	#Neu da duoc chon thi tra ve 0, chua duoc chon tra ve 1
	#, mang da ghi het -1 
	#Nhan vao $a0 ->dia chi mang TuDaRandom,
	#$a1-> So luong tu trong dethi.txt
	#$a2-> Vi tri cua tu can kiem tra 		
		
_KiemTraTinhHopLeCuaTuMoi:

	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t1,16($sp)
	sw $t0,20($sp)
	sw $t2,24($sp)
	


	#Luu tru cac tham so
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	
	
	
	
	add $t0,$s0,$s2
	
	lb $t1,($t0)
	
	beq $t1,$0,_KiemTraTinhHopLeCuaTuMoi.HopLe
	j _KiemTraTinhHopLeCuaTuMoi.KhongHopLe
	
	_KiemTraTinhHopLeCuaTuMoi.HopLe:
		li $v0,1
		j _KiemTraTinhHopLeCuaTuMoi.Restore
	
	_KiemTraTinhHopLeCuaTuMoi.KhongHopLe:		
		move $t0,$s0
		li $t1,0
	
		_KiemTraTinhHopLeCuaTuMoi.KiemTraMangDaDuocGhiHet:
			bge $t1,$s1,_KiemTraTinhHopLeCuaTuMoi.ExitLoop			
			lb $t2,($t0)			
			beq $t2,$0,_KiemTraTinhHopLeCuaTuMoi.PreRestore
			addi $t1,$t1,1
			addi $t0,$t0,1
		
		j _KiemTraTinhHopLeCuaTuMoi.KiemTraMangDaDuocGhiHet
	
		_KiemTraTinhHopLeCuaTuMoi.ExitLoop:			
			li $v0,-1
		j _KiemTraTinhHopLeCuaTuMoi.Restore
		
		_KiemTraTinhHopLeCuaTuMoi.PreRestore:
			li $v0,0
	
	_KiemTraTinhHopLeCuaTuMoi.Restore:
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t1,16($sp)
	lw $t0,20($sp)
	lw $t2,24($sp)
	addi $sp,$sp,32
	
	jr $ra
	
	
		
#Lay ra so luong tu trong de thi
#a0-> dia chi buffer
	#Tested
_SoLuongTuTrongDeThi:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	#Luu dia chi buffer
	move $s0,$a0
	
	lb $t0,($s0)
	addi $t0,$t0,-48
	move $v0,$t0
	
	
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	addi $sp,$sp,32
	jr $ra
	




#Khoi tao gia tri mang TuDaRandom
	#Nhan vao $a0 dia chi mang TuDaRandom
	#Nhan vao $a1 so luong tu trong dethi.txt

_KhoiTaoMang:
		
		addi $sp,$sp,-32
		sw $ra,($sp)
		sw $s0,4($sp)
		sw $s1,8($sp)
		sw $t1,12($sp)
		
		
		#Luu lai dia chi mang va so luong
		
		move $s0,$a0
		move $s1,$a1
		
		
		#index = 0
		li $t1,0
		
		_KhoiTaoMang.Loop:
			bge $t1,$s1,_KhoiTaoMang.ExitLoop
			
			sb $0,($s0)
			
			addi $t1,$t1,1
			addi $s0,$s0,1
			
			
		j _KhoiTaoMang.Loop
		
		_KhoiTaoMang.ExitLoop:
		
			
			
		lw $ra,($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $t1,12($sp)
		addi $sp,$sp,32
		jr $ra
		
		

#Ham doc file
	#a0-> dia chi ten file , a1-> dia chi buffer
_DocFile:
        addi $sp,$sp,-32
        sw $ra,($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)
    	sw $t0,12($sp)
	
	    #s0: dia chi file s1 - dia chi buffer
        move $s0,$a0
        move $s1,$a1
	
    	#Goi lenh mo file
    	li $v0,13
    
        move $a0,$s0
        li $a1,0
        li $a2,0	
        syscall

   	    move $t0,$v0

        #Goi lenh doc file
        li $v0,14

    	move $a0,$t0
        move $a1,$s1
        li $a2,1000   
    	syscall

        lw $ra,($sp)
        lw $s0,4($sp)
        lw $s1,8($sp)
        lw $t0,12($sp)
        addi $sp,$sp,32
        jr $ra

#Doc mot tu vao word 
	#a0 -> dia chi buffer
	#a1 -> Tu tai vi tri 
	#a2 -> Dia chi word
_DocMotTuVaoWord:
	addi $sp,$sp,-32
	
	sw $s0,($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $ra,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)
	
	#Luu tham so dau vao
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	
	#Dia chi buffer
	move $t0,$s0
	
	#count '-' -> 45 ascii code		
	li $t1,-1
	
	_DocMotTuVaoWord.Loop:
		beq $t1,$s1,_DocMotTuVaoWord.ExitLoop
		lb $t2,($t0)
		beq $t2,45,_DocMotTuVaoWord.TangDem
		j _DocMotTuVaoWord.ContinueLoop
		_DocMotTuVaoWord.TangDem:
			addi $t1,$t1,1		
			
		_DocMotTuVaoWord.ContinueLoop:
			addi $t0,$t0,1
	j _DocMotTuVaoWord.Loop
	#Dich sang phai 1 ki tu 
	addi $t0,$t0,1
	_DocMotTuVaoWord.ExitLoop:
	
	_DocMotTuVaoWord.Loop2:
		lb $t2,($t0)
		beq $t2,$0,_DocMotTuVaoWord.ExitLoop2 
		beq $t2,45,_DocMotTuVaoWord.ExitLoop2
		
		sb $t2,($s2)
		
		_DocMotTuVaoWord.ContinueLoop2:
			addi $t0,$t0,1
			addi $s2,$s2,1
			
		j _DocMotTuVaoWord.Loop2
			
	_DocMotTuVaoWord.ExitLoop2:

	lw $s0,($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $ra,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)	
	addi $sp,$sp,32				
	jr $ra

	 
	
#Ham ghi ket qua xuong file


#Ham xu li khi het luot choi -> Ket thuc khi nguoi cho chon choi tiep thi khong can nhap lai ten

#Khu vuc test chuc nang