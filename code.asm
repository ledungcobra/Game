.data
	menu0: .asciiz "\n========MENU========\n"
	tb1: .asciiz "\nNhap vao so luong phan tu cua mang: "
	tb2: .asciiz "\nNhap vao phan tu arr["
	tb3: .asciiz "]: "
	tb4: .asciiz "\nMang vua nhap la: "
	tb5: .asciiz "\nPhan tu arr["
	tb6: .asciiz "] = "
	tb7: .asciiz "\nNhan enter den tiep tuc "
	tb8: .asciiz "\nTong cac phan tu trong mang la: "
	tb9: .asciiz "\nMax cua mang vua nhap la: "
	tb10: .asciiz "\nDanh sach nhung so nguyen to la: "
	tb11:.asciiz "    "
	menu1: .asciiz "\n1.Nhap mang"
	menu2: .asciiz "\n2.Xuat mang"
	menu3: .asciiz "\n3.Tinh tong mang"
	menu4: .asciiz "\n4.Tim max"
	menu5: .asciiz "\n5.Liet ke so nguyen to trong mang"
	menu6: .asciiz "\n6.Sap xep mang tang dan"
	menu8: .asciiz "\nMoi ban nhap vao lua chon: "
	menu7: .asciiz "\n7.Ket thuc chuong trinh"
	  
	#So luong ki tu
	n:.word 0
	.align 4
	arr: .space 100

.text
	#Xuat thong bao menu chuong trinh

Menu: 
	
	li $v0,4
	la $a0,menu0
	syscall	

	#Xuat tung menu
	li $v0,4
	la $a0,menu1
	syscall	

	li $v0,4
	la $a0,menu2
	syscall	

	li $v0,4
	la $a0,menu3
	syscall	

	li $v0,4
	la $a0,menu4
	syscall	

	li $v0,4
	la $a0,menu5
	syscall	

	li $v0,4
	la $a0,menu6
	syscall 

	li $v0,4
	la $a0,menu7
	syscall	

	#Nhap vao mot ki tu
	li $v0,4
	la $a0,menu8
	syscall	

	li $v0,5
	syscall	
	move $t0,$v0

	beq $t0,1,NhapMang
	beq $t0,2,XuatMang
	beq $t0,3,TinhTongMang
	beq $t0,4,TimMax
	beq $t0,5,LietKeNguyenTo
	#beq $t0,6,SapXepMangTangDan
	beq $t0,7,KetThucChuongTrinh
NhapMang:
	
	la $a0,arr
	la $a1,n

	jal _NhapMang
	syscall		
	j Menu

XuatMang:

	la $a0,arr
	lw $a1,n
	jal _XuatMang
	
	#Xuat thong bao nhan enter de tiep tuc menu
	
	li $v0,4
	la $a0,tb7
	syscall
	
	XuatMang.PresskeyLoop:
	li $v0,12
	syscall	
	bne $v0,'\n',XuatMang.PresskeyLoop	

	j Menu

TinhTongMang:
	
	li $v0,4
	la $a0, tb8
	syscall
	
	la $a0,arr
	lw $a1,n
	jal _TinhTongMang
	
	move $t0,$v0
	
	
	
	move $a0,$t0
	li $v0,1
	syscall

TimMax:
	
	
	#Xuat thong bao
	
	li $v0,4
	la $a0,tb9
	syscall
	
	la $a0,arr
	lw $a1,n
	jal _TimMax
	
	
	move $a0,$v0
	li $v0,1
	syscall
	
	#
	
	TimMax.PresskeyLoop:
	li $v0,12
	syscall	
	bne $v0,'\n',TimMax.PresskeyLoop	

	j Menu

LietKeNguyenTo:
	
	#Xuat thong bao
	
	li $v0,4
	la $a0,tb10
	syscall
	
	la $a0,arr
	lw $a1,n
	jal _LietKeSoNguyenTo
	
	
	
	
	
	
	
	

KetThucChuongTrinh:
	#Thuc hien ket thuc chuong trinh
	li $v0,10
	syscall	
#Ket thuc chuong trinh
_NhapMang:
	#Backup
	addi $sp,$sp,-40
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	sw $v0,20($sp)
	sw $a0,24($sp)
	sw $a1,28($sp)
	
	#Backup a1-> dia chi n, a0 dia chi arr
	move $s1,$a1
	move $s0,$a0
	
	
	
	li $v0,4
	la $a0,tb1
	syscall	

	#Nhapp vao n
	li $v0,5
	syscall
	#Luu xuong vung nho n

	sw $v0,($s1)
	#Lay ra so luong phan tu
	
	lw $t0,($s1)
	
	li $t1,0


_NhapMang.Loop:
	
	bge $t1,$t0,_NhapMang.ExitLoop
	#Xuat thong bao nhap vao phan tu arr[
	li $v0,4
	la $a0,tb2
	syscall

	#Xuat ra index
	
	move $a0,$t1
	li $v0,1
	syscall
	#xuat ra thong bao ]: 
	
	li $v0,4
	la $a0,tb3
	syscall
	
	#Nhap vao so nguyen tu ban phim
	
	li $v0,5
	syscall
	
	sw $v0,($s0)
	#Thuc hien dich vung nho len 4 don vi dong thoi tang index len 1
	addi $t1,$t1,1
	addi $s0,$s0,4

	j  _NhapMang.Loop
	
	#Xuat ra phan tu hien tai
_NhapMang.ExitLoop:		
	

	
	#Tra backup
	lw $ra,($sp)
	lw $s0, 4($sp)
	lw $s1,8($sp)
	lw $t0, 12($sp)
	lw $t1,16($sp)
	lw $v0,20($sp)
	lw $a0,24($sp)
	lw $a1,28($sp)
	addi $sp,$sp,40
	#Chay dong lenh tiep theo
	jr $ra

_XuatMang:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t1,12($sp)
	sw $t0,16($sp)
	sw $a0,20($sp)
	
	
	
	#Backup dia chi cua arr 
	#a0<- arr, a1<- n
	
	move $t0,$a1
	move $s0,$a0
	
	move $a0,$t0
	li $v0,1
	syscall	
	
	
	
	#Xuat thong bao Mang vua nhap la: 
	li $v0,4
	la $a0,tb4
	syscall
	
	#Khoi tao index = 0
	li $t1,0
	
_XuatMang.Loop:
	#Dieu kien vong lap
	bge $t1,$t0,_XuatMang.ExitLoop

	#Xuat thong bao
	li $v0,4
	la $a0,tb5
	syscall
	
	#Xuat ra index
	
	move $a0,$t1
	li $v0,1
 	syscall	
	
	#Xuat ra thong bao ] = 
	
	li $v0,4
	la $a0,tb6
	syscall

	#s1<- phan tu hien tai
	
	lw $a0,($s0)
	li $v0,1
	syscall
	
	
	addi $t1,$t1,1
	addi $s0,$s0,4

	j _XuatMang.Loop
	
_XuatMang.ExitLoop:
	
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t1,12($sp)
	lw $t0,16($sp)
	lw $a0,20($sp)
	addi $sp,$sp,32
	#nhay den address
	jr $ra

_TinhTongMang:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1, 8($sp)
	sw $t1, 12($sp)
	sw $t0, 16($sp)
	sw $s2, 20($sp)
	
		
	#a0 -> arr address, a1-> n value
	move $s0,$a0
	move $s1,$a1

	#Ket qua $s2	
	li $s2,0
    
	#t1, index
	
	li $t1,0

_TinhTongMang.Loop:
	bge $t1,$s1,_TinhTongMang.ExitLoop
		
	lw $t0,($s0)
	add $s2,$s2,$t0
	addi $t1,$t1,1
	addi $s0,$s0,4	
	j _TinhTongMang.Loop
	
_TinhTongMang.ExitLoop:
	
	move $v0,$s2
	
	#Thu hien restore
	
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1, 8($sp)
	lw $t1, 12($sp)
	lw $t0, 16($sp)
	lw $s2, 20($sp)
	addi $sp,$sp,32
	
	jr $ra
_TimMax:
	addi $sp,$sp,-32
	sw $s0,($sp)
	sw $s1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $ra,20($sp)
	
	#Luu tru lai tham so
	
	move $s0,$a0
	move $s1,$a1
	


	#T0 =  max
	lw $t0,($s0)
	li $t1,0	
	
	_TimMax.Loop:
		bge $t1,$s1,_TimMax.ExitLoop
			#Phan tu hien tai
			lw $t2,($s0)
			
			bgt $t2,$t0,CurrentGreaterThanMax
			j _TimMax.ContinueLoop		
			CurrentGreaterThanMax:
				move $t0,$t2
			
			_TimMax.ContinueLoop:

				addi $t1,$t1,1
				addi $s0,$s0,4	
			
				j _TimMax.Loop

_TimMax.ExitLoop:

		move $v0,$t0
		lw $s0,($sp)
		lw $s1,4($sp)
		lw $t0,8($sp)
		lw $t1,12($sp)
		lw $t2,16($sp)
		lw $ra,20($sp)
		addi $sp,$sp,32
			
		jr $ra
		
_KiemtraNguyenTo:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t1,4($sp)
	sw $s0,8($sp)
	sw $t2,12($sp)
	
	
	move $s0,$a0
	#s0<2
	
	blt $s0,2,_KiemtraNguyenTo.KhongLaSoNguyenTo
	beq $s0,2,_KiemtraNguyenTo.LaSoNguyenTo
	
	#t1 index
	li $t1,2
	
	
	
	
	
	
	
	_KiemtraNguyenTo.Loop:
		bge $t1,$s0,_KiemtraNguyenTo.ExitLoop
		div $s0,$t1
		mfhi $t2
		beq $t2,0,_KiemtraNguyenTo.KhongLaSoNguyenTo
		
		addi $t1,$t1,1
		
		
		
	j _KiemtraNguyenTo.Loop
	
	
	_KiemtraNguyenTo.ExitLoop:	
		beq $t1,$s0,_KiemtraNguyenTo.LaSoNguyenTo
	
	_KiemtraNguyenTo.KhongLaSoNguyenTo:
		li $v0,0
		j _KiemtraNguyenTo.Restore
		
	_KiemtraNguyenTo.LaSoNguyenTo:
		li $v0,1
		j _KiemtraNguyenTo.Restore
	
	_KiemtraNguyenTo.Restore:
	
	
	lw $ra,($sp)
	lw $t1,4($sp)
	lw $s0,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,32
	
	jr $ra
		
_LietKeSoNguyenTo:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t1,12($sp)
	
	
	move $s0,$a0
	move $s1,$a1
	#index t1
	li $t1,0
	
	
	
	_LietKeSoNguyenTo.Loop:
		bge $t1,$s1,_LietKeSoNguyenTo.ExitLoop
		lw $a0,($s0)
		jal _KiemtraNguyenTo
		bne $v0,$0,_LietKeSoNguyenTo.InRaManHinh
		
		_LietKeSoNguyenTo.ContinueLoop:
			addi $s0,$s0,4
			addi $t1,$t1,1
		j _LietKeSoNguyenTo.Loop
			
		
			
			
	_LietKeSoNguyenTo.InRaManHinh:
		
		lw $a0,($s0)
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,tb11
		syscall
		
		j _LietKeSoNguyenTo.ContinueLoop
	
	_LietKeSoNguyenTo.ExitLoop:
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,32
	
	jr $ra
	
_SapXepMangTangDan:
	addi $sp,$sp,-32
	sw 
		
		
		
		
		
		
		
		
		