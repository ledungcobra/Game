.data
	#File de thi
    file_in: .asciiz "dethi.txt"
	#File ke qua sau khi nguoi choi ket thuc game
	file_out:.asciiz "nguoichoi.txt"
	#*****Khu vuc khai bao thong bao
	#Thong bao het tu trong de thi
	tb1:.asciiz "\nHet tu roi"
	tb2:.asciiz "\nMoi ban nhap vao ten: "
	tb_het_tu:.asciiz "\nHet tu trong de thi roi\n "
	tb_nhap_sai:.asciiz "\nBan da nhap sai vui long nhap lai \n"
	tb_nhap_ki_tu:.asciiz "\nMoi ban nhap vao mot ki tu: "
	#*****Ket thuc khu vuc khai bao thong bao
	#*****String ung voi so lan nguoi choi doan sai
	doan_sai_lan_1:.asciiz "\n_____________\n|/         | \n|\n|\n|\n|\n|\n|\n|\n|\n|"
	doan_sai_lan_2:.asciiz "\n_____________\n|/         | \n|          O\n|\n|\n|\n|\n|\n|\n|\n|"
	doan_sai_lan_4:.asciiz "\n_____________\n|/         | \n|          O\n|         /|\n|\n|\n|\n|\n|\n|\n|"
	doan_sai_lan_5:.asciiz "\n_____________\n|/         | \n|          O\n|         /|\\\n|\n|\n|\n|\n|\n|\n|"
	doan_sai_lan_6:.asciiz "\n_____________\n|/         | \n|          O\n|         /|\\\n|         /\n|\n|\n|\n|\n|\n|"
	doan_sai_lan_7:.asciiz "\n_____________\n|/         | \n|          O\n|         /|\\\n|         / \\\n|\n|\n|\n|\n|\n|"
	#***** KetThuc 	
	#Khu vuc khai bao string cho **DEBUG**
	usernamed1: .asciiz "abc"
	usernamed2:.asciiz "xyz"
	usernamed3: .asciiz "abc"
	usernamed4:.asciiz "xyz"
	
	diemd1:.asciiz "100"
	diemd2:.asciiz "300"
	diemd3:.asciiz "100"
	diemd4:.asciiz "300"
	
	sotud1:.asciiz "10"
	sotud2:.asciiz "20"
	sotud3:.asciiz "10"
	sotud4:.asciiz "20"

	#Ket thuc
	asterisk_sign:.asciiz "*"
	dash_sign:.asciiz "-"
	enter_sign:.asciiz "\n"
	#Che do nguoi choi
		#1 -> che do 1 ki tu
		#2 -> che do 1 word
	che_do:.byte 0
	#Ki tu nguoi choi nhap vao khi choi che do 1 ki tu
	ki_tu_nhap_vao:.byte 0
	#Bien dem so lan nguoi choi doan sai
	dem_so_lan_doan_sai:.word 0	
	#Luu lai sao diem cua nguoi choi
	diem: .word 0
	#Luu lai so tu nguoi choi doan duoc
	so_tu_da_doan:.word 0
	
	#******Khu vuc khai bao mang va string
	#Mang luu du lieu khi doc file dethi.txt
	buffer_fin:.space 1000
	#Mang luu du lieu nguoi choi doc tu file nguoichoi.txt
	buffer_fout:.space 5000
	#Bien tam thuc hien noi chuoi
	buffer_concate_string1:.space 1000
	buffer_concate_string2:.space 1000
	encoded_answer:.space 100
	username:.space 50    
	word: .space 100
	dap_an_nguoi_choi:.space 100	
	#Mang so nguyen chua index cac tu da radom
	.align 4
	ARRTu_Da_Random:.space 400
	.align 4 
	ARRDiem_Nguoi_Choi: .space 400
	.align 4 
	ARRIndex_Nguoi_Choi: .space 400


 

.text
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#Main:

	#Ham ghi ket qua xuong file
	#a0-> dia chi username
	#a1-> diem nguoi choi 
	#a2-> so luong tu da doan duoc
	
	
#
	
	la $a0,file_out
	la $a1,buffer_fout
	jal _DocFile
	
	la $a0,buffer_fout
	jal _DemSoLuongNguoiChoi
	
	move $a0,$v0
	li $v0,1
	syscall

	

		

#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
ExitProgram:
	    li $v0,10
	    syscall


	

_InitGame:

	addi $sp,$sp,-32
	sw $ra,($sp)
	#Init
#Doc file de thi vao buffer_fin
						
		la $a0,file_in
		la $a1,buffer_fin		
		jal _DocFile		
#Preconfigure:

		la $a0,buffer_fin
		jal _SoLuongTuTrongDeThi

		move $a1,$v0
		li $a2,4
		la $a0,ARRTu_Da_Random		
		jal _KhoiTaoMang

		la $a0,username
		li $a1,50
		li $a2,1
		jal _KhoiTaoMang

		la $a0,word
		li $a1,100
		li $a2,1
		jal _KhoiTaoMang

		la $a0,encoded_answer
		li $a1,100
		li $a2,1
		jal _KhoiTaoMang

		

		
	lw $ra,($sp)
	addi $sp,$sp,32
	jr $ra

#

#Dang nhap game
	#a0-> dia chi username
_DangNhapGame:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)

	#luu lai tham so
	move $s0,$a0

	la $a0,tb2
	li $v0,4
	syscall

	li $v0,8
	move $a0,$s0
	li $a1,50
	syscall

	#TODO:
	#Kiem tra xem nguoi choi nhap hop le hay khong
	#username hop le bao gom 0-9 A-Z a-z
	#Neu nguoi choi nhap khong hop le xuat thong bao yeu cau nguoi choi nhap lai




	lw $ra,($sp)
	lw $s0,4($sp)
	addi $sp,$sp,32

	jr $ra



#Main Loop Game

_GameLoop:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	#TODO:
	#Thong bao chao mung den game

	_GameLoop.Loop:
		jal _InitGame
	
		#Kiem tra xem nguoi choi da dang nhap chua neu chua dang nhap thi tien hanh dang nhap
		la $a0,username
		jal _DemSoLuongKiTu
		#t0-> so luong ki tu cua username
		move $t0,$v0
		#Kiem tra xem nguoi choi dang nhap chua
		beq $t0,$0,_GameLoop.DangNhap
			#Neu khong tiep tuc vong lap game			
			j _GameLoop.ContinueLoop0

			_GameLoop.DangNhap:			
			la $a0,username
			jal _DangNhapGame	
			#

			
			_GameLoop.ContinueLoop0:

			#May tien hanh cho mot tu trong dethi.txt

			#Ham Chon de tu 1 chuoi de doc tu buffer_fin
			#Nhan vao dia chi buffer_fin -> $a0
			#Nhan vao dia chi cua mang ARRTu_Da_Random -> $a1
			#Nhan vao dia chi cua word -> $a2

			#Tra ve 1-> Tim duoc tu trong de thi
			#Tra ve 0 -> Het tu trong de thi 
			la $a0,buffer_fin
			la $a1,ARRTu_Da_Random
			la $a2,word
			jal _ChonMotTuDeDocTuBuffer

			#Tien hanh kiem tra neu het tu trong de thi thi xuat thong bao het tu trong de thi
			#Neu khong tiep tuc vong lap
			beq $v0,$0,_GameLoop.HetTuTrongDeThi
			j _GameLoop.ContinueLoop1 #Con tu trong dethi

				_GameLoop.HetTuTrongDeThi:
					la $a0,tb_het_tu
					li $v0,4
					syscall
					#TODO:
						#Ghi ket qua nguoi choi ra file nguoichoi.txt
					jal _GhiKetQuaRaFile
					#TODO:
					jal _XuatKetQuaTop10
					_GameLoop.KiemSoatNhap:
					#TODO
					jal _YeuCauNguoiChoiLuaChonChoiTiepHayThoat
					#neu nguoi choi chon 1 thi nguoi choi se duoc choi moi
					beq $v0,1,_GameLoop.Loop
					#Neu nguoi choi nhap 2
					beq $v0,2,_GameLoop.ThoatChuongTrinh				
					#Neu nguoi choi nhap sai
					j _GameLoop.XuatThongBaoNhapSaiYeuCauNhapLai
					_GameLoop.ThoatChuongTrinh:
						j ExitProgram
					_GameLoop.XuatThongBaoNhapSaiYeuCauNhapLai:
						la $a0,tb_nhap_sai
						li $v0,4
						syscall
						j _GameLoop.KiemSoatNhap
					
					


			#Neu con tu trong de thi				
			_GameLoop.ContinueLoop1:
			jal _YeuCauNguoiChoiChonCheDoChoi


	j _GameLoop.Loop

	addi $sp,$sp,32
	jr $ra

#TODO:
#Xuat thong bao yeu cau nguoi choi nhap vao lua chon
#Chon 1-> Choi che do 1 tu
#Chon 2-> Choi che do doan dap an (whole word)
#Neu nguoi choi nhap sai xuat thong bao nguoi choi nhap sai yeu cau nguoi choi 
#nhap lai

	#Tra ra lua chon cua nguoi choi -> v0
_YeuCauNguoiChoiChonCheDoChoi:

#TODO:
#Che do doan 1 ki tu
_CheDoDoanMotKiTu:

#TODO:
#Che do doan 1 chu
_CheDoDoanMotWord:
#TODO:
#Ket thuc tro choi:
_XuatKetQuaTop10:

#TODO:
#Yeu cau nguoi choi chon choi tiep hay thoat tro choi 
#Xuat thong bao hoi nguoi choi co muon tiep tuc choi tiep hay khong
#1.Choi tiep tuc 
#2.Ket thuc tro choi

	#Tra ve lua chon cua nguoi choi -> $v0
_YeuCauNguoiChoiLuaChonChoiTiepHayThoat:


#TODO:
	#Cap nhat trang thai nguoi choi
	#Diem hien tai la bao nhieu 
	#So tu da doan duoc	
	#So lan sai con lai doi voi che do 1 ki tu
_CapNhatTrangThaiNguoiChoi:

#TODO:
    #Cap nhat man hinh o che do 1 ki tu
_CapNhatManHinhOCheDoMotKiTu:

#TODO:
	#Cap nhat man hinh o che do 1 word
_CapNhatManHinhOCheDoMotWord:

#TODO:
#Ve man hinh theo so lan doan sai
	#a0-> dem_so_lan_doan_sai
_VeManRaManHinhUngVoSoLanSaiCuaNguoiChoi:

#TODO
#Cap nhat data nguoi choi khi nguoi choi chien thang (Diem = Diem + So luong ki tu)
_CapNhatDuLieuNguoiChoi: 

#Ham Dem so luong ki tu trong 1 chuoi
    #Nhan vao a0 la dia chi cua chuoi
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
		
			
    
#Ham Chon de tu 1 chuoi de doc tu buffer_fin
	#Nhan vao dia chi buffer_fin -> $a0
	#Nhan vao dia chi cua mang ARRTu_Da_Random -> $a1
	#Nhan vao dia chi cua word -> $a2

	#Tra ve 1-> Tim duoc tu trong de thi
	#Tra ve 0 -> Het tu trong de thi 
	
_ChonMotTuDeDocTuBuffer:
		
		addi $sp,$sp,-32
		sw $ra,($sp)
		sw $s0,4($sp)
		sw $s1,8($sp)
		sw $t1,12($sp)
		sw $t0,16($sp)
		sw $s2,20($sp)
		sw $s3,24($sp)
		
		
		
		#Luu lai dia chi buffer_fin
		
		move $s0,$a0
		
		#Luu dia chi cua mang ARRTu_Da_Random
		
		move $s1,$a1
		
		#Luu lai dia chi cua word
		
		move $s2,$a2
		
		#s3 so luong tu trong de thi

		la $a0,buffer_fin
		jal _SoLuongTuTrongDeThi
		move $s3,$v0		
		
		
		_ChonMotTuDeDocTuBuffer.DoWhileLoop:
			#Goi ham random -> 0<=[int]<upper bound					
			move $a1,$s3
			li $v0,42
			syscall
			
			#Luu lai 
			move $t0,$a0
			#Ket qua random tu thu i = $a0					
			move $a1,$a0				
			move $a0,$s1
			#Nhan vao $a0 ->dia chi mang ARRTu_Da_Random,
			#$a1-> Vi tri cua tu can kiem tra
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
			move $a2,$s2			
			jal _DocMotTuVaoWord
			
			#Thuc hien danh dau
			move $a0,$s1
			move $a1,$t0
			li $a2,1
			jal _SetGiatriTaiIndex


									
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
		
#Ham kiem tra tu tai vi tri n da duoc chon hay chua dong thoi kiem tra xem mang da duoc danh dau het chua
	#Neu da duoc chon thi tra ve 0, chua duoc chon tra ve 1
	#, mang da ghi het -1 
	
	#Nhan vao $a0 ->dia chi mang ARRTu_Da_Random,
	#$a1-> Vi tri cua tu can kiem tra		
_KiemTraTinhHopLeCuaTuMoi:

	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)	
	sw $t0,12($sp)
	
	


	#Luu tru cac tham so
	move $s0,$a0
	move $s1,$a1

	move $a0,$s0
	move $a1,$s1
	jal _LayRaPhanTuTaiIndex

	move $t0,$v0

	beq $t0,$0,_KiemTraTinhHopLeCuaTuMoi.HopLe
	
	#Kiem tra xem mang da danh dau het hay chua
	move $a0,$s0
	jal _KiemTraMangTuDaRandomDaDanhDauHetChua	
	move $t0,$v0

	beq $t0,1,_KiemTraTinhHopLeCuaTuMoi.MangDaDanhDauHet

	_KiemTraTinhHopLeCuaTuMoi.HopLe:
		li $v0,1
		j _KiemTraTinhHopLeCuaTuMoi.Restore


	_KiemTraTinhHopLeCuaTuMoi.MangDaDanhDauHet:
		li $v0,-1
		j _KiemTraTinhHopLeCuaTuMoi.Restore

	li $v0,0
	
	_KiemTraTinhHopLeCuaTuMoi.Restore:
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)	
	lw $t0,12($sp)
	
	
	addi $sp,$sp,32
	
	jr $ra
#Lay ra gia tri phan tu tai vi tri index
	#a0-> Dia chi mang so nguyen
	#a1 -> Index
_LayRaPhanTuTaiIndex:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)

	move $s0,$a0
	move $s1,$a1

	li $t1,4
	mult $s1,$t1
	mflo $s1
	add $a0,$a0,$s1

	lw $v0,($a0)
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	addi $sp,$sp,32

	jr $ra

#SetGiaTriMangTaiIndex
	#a0-> Dia chi mang so nguyen
	#a1 -> index
	#a2 -> gia tri
_SetGiatriTaiIndex:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)

	#Luu lai tham so
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	li $t0,4
	mult $s1,$t0
	mflo $s1
	add $s1,$s0,$s1

	sw $s2,($s1)

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t0,16($sp)
	addi $sp,$sp,32


	jr $ra




#Kiem tra xem mang danh da da danh dau het chua
	#Nhan vao $a0-> dia chi cua mang ARRTu_Da_Random
	#Tra ve 0 khi mang chua danh dau he
	#Tra ve 1 khi mang da duoc danh dau het

	#IsFulllyMasked
_KiemTraMangTuDaRandomDaDanhDauHetChua:
	addi $sp,$sp,-32
	sw $s0,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $ra,16($sp)

	#Luu lai dia chi tham so
	move $s0,$a0

	#So luong tu trong de thi

	la $a0,buffer_fin
	jal _SoLuongTuTrongDeThi
	#t0 -> So luong tu trong de thi tuong ung voi so luong phan tu trong mang ARRTu_Da_Random
	move $t0,$v0
	#$t0-> index
	li $t1,0
	_KiemTraMangTuDaRandomDaDanhDauHetChua.Loop:
		bge $t1,$t0,_KiemTraMangTuDaRandomDaDanhDauHetChua.ExitLoop
		lw $t2,($s0)
		beq $t2,$0,_KiemTraMangTuDaRandomDaDanhDauHetChua.MangChuaGhiHet

		addi $t1,$t1,1
		addi $s0, $s0, 4			# $s0 = $s0 + 4
		
		

	j _KiemTraMangTuDaRandomDaDanhDauHetChua.Loop

	_KiemTraMangTuDaRandomDaDanhDauHetChua.ExitLoop:
		li $v0,1
		j _KiemTraMangTuDaRandomDaDanhDauHetChua.Restore

	_KiemTraMangTuDaRandomDaDanhDauHetChua.MangChuaGhiHet:
		li $v0,0
		j _KiemTraMangTuDaRandomDaDanhDauHetChua.Restore

	_KiemTraMangTuDaRandomDaDanhDauHetChua.Restore:

	lw $s0,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $ra,16($sp)
	addi $sp,$sp,32
	

	jr $ra


#Lay ra so luong tu trong de thi
#a0-> dia chi buffer_fin
	#Tested
_SoLuongTuTrongDeThi:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	
	#Luu dia chi buffer_fin
	move $s0,$a0
	
	#lb $t0,($s0)
	#addi $t0,$t0,-48
	#move $v0,$t0
	#$t1 -> count
	li $t1,0
	_SoLuongTuTrongDeThi.Loop:
		#Lay tam gia tri vao $t0
		lb $t0,($s0)
		beq $t0,42,_SoLuongTuTrongDeThi.ExitLoop

		addi $t0,$t0,-48
		
		li $t2,10
		mult $t1,$t2
		mflo $t1

		add $t1,$t1,$t0


	
		addi $s0,$s0,1
		j _SoLuongTuTrongDeThi.Loop

	_SoLuongTuTrongDeThi.ExitLoop:
		
	move $v0,$t1
	
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	addi $sp,$sp,32
	jr $ra
	




#Khoi tao gia tri mang ARRTu_Da_Random
	#Nhan vao $a0 dia chi mang ARRTu_Da_Random
	#a1->soluong luong phan tu 
	#a2-> step
_KhoiTaoMang:
		
		addi $sp,$sp,-32
		sw $ra,($sp)
		sw $s0,4($sp)
		sw $s1,8($sp)
		sw $t1,12($sp)
		sw $s2,16($sp)
		
		
		#Luu lai dia chi mang va so luong		
		move $s0,$a0
		#Lay ra so luong tu trong de thi
		move $s1,$a1
		move $s2,$a2
		
		
		#index = 0
		li $t1,0
		
		_KhoiTaoMang.Loop:
			bge $t1,$s1,_KhoiTaoMang.ExitLoop

			beq $s2,1,_KhoiTaoMang.LuuByte
			beq $s2,4,_KhoiTaoMang.LuuWord
			
			_KhoiTaoMang.LuuByte:
			j _KhoiTaoMang.ContinueLoop
				sb $0,($s0)	
			_KhoiTaoMang.LuuWord:
				sw $0,($s0)	
			j _KhoiTaoMang.ContinueLoop			
			
			_KhoiTaoMang.ContinueLoop:	
			addi $t1,$t1,1
			add $s0,$s0,$s2			
			
		j _KhoiTaoMang.Loop
		
		_KhoiTaoMang.ExitLoop:
		
			
			
		lw $ra,($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $t1,12($sp)
		lw $s2,16($sp)
		addi $sp,$sp,32
		jr $ra
		
		

#Ham doc file
	#a0-> dia chi ten file , a1-> dia chi buffer_fin
_DocFile:
        addi $sp,$sp,-32
        sw $ra,($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)
    	sw $t0,12($sp)
	
	    #s0: dia chi file s1 - dia chi buffer_fin
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

		#Dong file
		move $a0,$t0
		li $v0,16
		syscall

        lw $ra,($sp)
        lw $s0,4($sp)
        lw $s1,8($sp)
        lw $t0,12($sp)
        addi $sp,$sp,32
        jr $ra

#Doc mot tu vao word 
	#a0 -> dia chi buffer_fin
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
	
	#Dia chi buffer_fin
	move $t0,$s0
	
	#count '*' -> 42 ascii code		
	li $t1,-1
	
	_DocMotTuVaoWord.Loop:
		beq $t1,$s1,_DocMotTuVaoWord.ExitLoop
		lb $t2,($t0)
		beq $t2,42,_DocMotTuVaoWord.TangDem
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
		beq $t2,42,_DocMotTuVaoWord.ExitLoop2
		
		sb $t2,($s2)
		
		_DocMotTuVaoWord.ContinueLoop2:
			addi $t0,$t0,1
			addi $s2,$s2,1			
		j _DocMotTuVaoWord.Loop2
		
		
			
	_DocMotTuVaoWord.ExitLoop2:
	sb $0,($s2)

	lw $s0,($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $ra,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)	
	addi $sp,$sp,32				
	jr $ra

	 
#DONE
#Ham ghi ket qua xuong file
	#a0-> dia chi username
	#a1-> diem nguoi choi 
	#a2-> so luong tu da doan duoc
_GhiKetQuaRaFile:

	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $s1,16($sp)
	sw $s2,20($sp)
	sw $s3,24($sp)

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	#Thuc hien noi tu 
	#result -> username-
	la $a0,buffer_concate_string1
	move $a1,$s0
	la $a2,dash_sign
	jal _NoiChuoi
	#D
	la $a0,buffer_concate_string1
	li $v0,4
	syscall
	
	la $a0,enter_sign
	li $v0,4
	syscall

	#result -> username-diem
	la $a0,buffer_concate_string2
	la $a1,buffer_concate_string1
	move $a2,$s1
	jal _NoiChuoi
	#D
	la $a0,buffer_concate_string2
	li $v0,4
	syscall
	
	la $a0,enter_sign
	li $v0,4
	syscall

	#result-> username-diem-
	la $a0,buffer_concate_string1
	la $a1,buffer_concate_string2
	la $a2,dash_sign
	jal _NoiChuoi

	#D
	la $a0,buffer_concate_string1
	li $v0,4
	syscall
	
	la $a0,enter_sign
	li $v0,4
	syscall
	#result-> username-diem-so_tu_da_doan
	la $a0,buffer_concate_string2
	la $a1,buffer_concate_string1
	move $a2,$s2
	jal _NoiChuoi

	#D
	la $a0,buffer_concate_string2
	li $v0,4
	syscall
	
	la $a0,enter_sign
	li $v0,4
	syscall
	#result-> username-diem-so_tu_da_doan*
	la $a0,buffer_concate_string1
	la $a1,buffer_concate_string2
	la $a2,asterisk_sign
	jal _NoiChuoi

	#D
	la $a0,buffer_concate_string1
	li $v0,4
	syscall
	
	la $a0,enter_sign
	li $v0,4
	syscall


	


	li   $v0, 13       # system call for open file
  	la   $a0, file_out     # output file name
  	li   $a1, 9        # Open for writing (flags are 0: read, 1: write 9:write and append to existed file)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
	#Mo file

	move $t0,$v0
	la $a0,buffer_concate_string1
	jal _DemSoLuongKiTu
	move $t1,$v0
	
	li $v0,1
	move $a0,$t1
	syscall

	la $a0,enter_sign
	li $v0,4
	syscall
	
	move $a0,$t0
	li $v0,15
	la $a1,buffer_concate_string1
	move $a2,$t1
	syscall


	#close file
	li $v0,16
	move $a0,$t0
	syscall

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $s1,16($sp)
	lw $s2,20($sp)
	lw $s3,24($sp)
	addi $sp,$sp,32
	jr $ra

#Ham xu li khi het luot choi -> Ket thuc khi nguoi cho chon choi tiep thi khong can nhap lai ten
#Ham xuat mang
	#a0-> dia chi mang
	#a1 -> so luong phan tu cua mang

_XuatMang:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t1,12($sp)
	


	move $s0,$a0
	move $s1,$a1

	li $v0,4
	la $a0,tb2
	syscall

	li $t1,0


	_XuatMang.Loop:
		bge $t1,$s1,_XuatMang.ExitLoop
		
		lw $a0,($s0)
		li $v0,1
		syscall

		la $a0,enter_sign
		li $v0,4
		syscall		

		addi $t1,$t1,1
		addi $s0,$s0,4
	j _XuatMang.Loop

	_XuatMang.ExitLoop:

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,32

	jr $ra
#Lay ra so luong nguoi choi tu buffer_fin
#a0 -> dia chi buffer_fin
_DemSoLuongNguoiChoi:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	#Luu lai dia chi
	move $s0,$a0
	li $t1,0

	_DemSoLuongNguoiChoi.Loop:

	lb $t0,($s0)
	beq $t0,$0,_DemSoLuongNguoiChoi.ExitLoop
	beq $t0,42,_DemSoLuongNguoiChoi.TangDem
	_DemSoLuongNguoiChoi.ContinueLoop: 
		addi $s0,$s0,1
	j _DemSoLuongNguoiChoi.Loop


	_DemSoLuongNguoiChoi.TangDem:
		addi $t1,$t1,1
		j _DemSoLuongNguoiChoi.ContinueLoop
	
	_DemSoLuongNguoiChoi.ExitLoop:
	
	_DemSoLuongNguoiChoi.Restore:
	move $v0,$t1

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,32
	jr $ra

#Luu du lieu tu buffer1 vao 2 mang 
#ARRIndex_Nguoi_Choi, ARRDiem_Nguoi_Choi
	#a0 -> dia chi buffer_fin
	#a1 -> Mang diem
	#a2 -> Mang index
_LayDuLieuNguoiChoiLuuVaoMang:
	addi $sp,$sp,-36
	sw $ra,($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)
	sw $t3,28($sp)
	sw $t4,32($sp)




	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	
	




	#Index nguoi choi
	li $t1,0

	

	_LayDuLieuNguoiChoiLuuVaoMang.Loop:
		lb $t2,($s0)
		beq $t2,$0,_LayDuLieuNguoiChoiLuuVaoMang.ExitLoop


		#Tong
		
		beq $t2,45,_LayDuLieuNguoiChoiLuuVaoMang.ThucHienLayDuLieu
		
		_LayDuLieuNguoiChoiLuuVaoMang.ContinueLoop:
		addi $s0,$s0,1
	
	j _LayDuLieuNguoiChoiLuuVaoMang.Loop
	
		_LayDuLieuNguoiChoiLuuVaoMang.ThucHienLayDuLieu:
		li $t0,0
		addi $s0,$s0,1
		_LayDuLieuNguoiChoiLuuVaoMang.InnerLoop:

			lb $t2,($s0)
			beq $t2,45,_LayDuLieuNguoiChoiLuuVaoMang.ThucHienGhiDuLieu		
			beq $t2,42,_LayDuLieuNguoiChoiLuuVaoMang.ContinueLoop
			
			addi $t3,$t2,-48
			li $t4,10
			mult $t4,$t0
			mflo $t0
			add $t0,$t0,$t3	
			addi $s0,$s0,1

		j _LayDuLieuNguoiChoiLuuVaoMang.InnerLoop	
			_LayDuLieuNguoiChoiLuuVaoMang.ThucHienGhiDuLieu:
				
				sw $t0,($s1)
				sw $t1,($s2)

				addi $s1,$s1,4
				addi $s2,$s2,4
				addi $t1,$t1,1

		_LayDuLieuNguoiChoiLuuVaoMang.ExitInnerLoop:


	
	j _LayDuLieuNguoiChoiLuuVaoMang.ContinueLoop

	_LayDuLieuNguoiChoiLuuVaoMang.ExitLoop:
	

	
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)
	lw $t3,28($sp)
	lw $t4,32($sp)
	addi $sp,$sp,36

	jr $ra

#Sap xep ARRDiem_Nguoi_Choi vaf MangIndex
#a0 - Dia chi ARRDiem_Nguoi_Choi
#a1 - Dia chi mang index
#a2 - So luong phan tu trong mang
_SapXepGiamDan:
	addi $sp,$sp,-40
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)
	sw $t3,28($sp)
	sw $t4,32($sp)
	sw $t5,36($sp)

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	#Bien chay vong lap ngoai
	li $t0,0

	


	_SapXepGiamDan.Loop:
		
		bge $t0,$s2,_SapXepGiamDan.ExitLoop
		#max = arr[t0]-> t2
		move $a0,$s0
		move $a1,$t0
		jal _LayRaPhanTuTaiIndex
		move $t2,$v0
		#indexMax-> t3
		move $t3,$t0
			
			addi $t1,$t0,1
			_SapXepGiamDan.InnerLoop:

				bge $t1,$s2,_SapXepGiamDan.ExitInnerLoop

				move $a0,$s0
				move $a1,$t1
				jal _LayRaPhanTuTaiIndex
				move $t4,$v0
				blt $t2,$t4,_SapXepGiamDan.ThayDoiMax
				j _SapXepGiamDan.ContinueInnerLoop
					_SapXepGiamDan.ThayDoiMax:
						move $t2,$t4
						move $t3,$t1
					j _SapXepGiamDan.ContinueInnerLoop
					
					_SapXepGiamDan.ContinueInnerLoop:
					addi $t1,$t1,1
				j _SapXepGiamDan.InnerLoop


							

			_SapXepGiamDan.ExitInnerLoop:

		bne $t0,$t3, _SapXepGiamDan.Swap

		_SapXepGiamDan.ContinueLoop:

		addi $t0,$t0,1
	j _SapXepGiamDan.Loop

	_SapXepGiamDan.Swap:
		#Swap mang diem nguoi choi
		#lay phan dau tai index $t0 
		move $a0,$s0
		move $a1,$t0		
		jal _LayRaPhanTuTaiIndex
		move $t4,$v0


		move $a0,$s0
		move $a1,$t0
		move $a2,$t2
		jal _SetGiatriTaiIndex

		move $a0,$s0
		move $a1,$t3
		move $a2,$t4
		jal _SetGiatriTaiIndex


		#Swap Mang index nguoi choi

		move $a0,$s1
		move $a1,$t0
		jal _LayRaPhanTuTaiIndex
		move $t4,$v0

		move $a0,$s1
		move $a1,$t3
		jal _LayRaPhanTuTaiIndex
		move $t5,$v0

		move $a0,$s1
		move $a1,$t0
		move $a2,$t5
		jal _SetGiatriTaiIndex

		move $a0,$s1
		move $a1,$t3
		move $a2,$t4
		jal _SetGiatriTaiIndex
				
		j _SapXepGiamDan.ContinueLoop

	_SapXepGiamDan.ExitLoop:

		




	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)
	lw $t3,28($sp)
	lw $t4,32($sp)
	lw $t5,36($sp)
	addi $sp,$sp,40
	jr $ra
#Thuc hien encode word
	#a0,encoded_answer
	#a1,word	
_EncodeAnswer:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t0,20($sp)

	move $s0,$a0
	move $s1,$a1

	
	move $a0,$s1
	jal _DemSoLuongKiTu
	move $t2,$v0
	
	move $a0,$v0
	li $v0,1
	syscall

	#ma ascii *
	li $t0,0
	li $t1,42
	_EncodeAnswer.Loop:		
		bge $t0,$t2,_EncodeAnswer.ExitLoop
		sb $t1,($s0)
		
		addi $s0,$s0,1
		addi $t0,$t0,1
	j _EncodeAnswer.Loop

	_EncodeAnswer.ExitLoop:

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t0,20($sp)
	addi $sp,$sp,32
	
	jr $ra

#Tang dem
	#a0 -> dia chi bien dem
_TangDem:
	addi $sp,$sp,-32	
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)

	move $s0,$a0
	lw $t0,($s0)
	addi $t0,$t0,1
	sw $t0,($sp)

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	addi $sp,$sp,32
	jr $ra

#Kiem tra ki tu nguoi choi nhap vao co tong tai trong dap an 
#va thay doi encoded_answer
	#a0 -> ki tu can kiem tra (byte)
	#a1 -> word
	#a2 -> encoded_answer

	#Tra ve 1 neu nguoi choi nhap dung
	#Tra ve 0 neu nguoi choi nhap sai
_KiemTraDapAnVaThayDoiEncodedAnswer:

	addi $sp,$sp,-36
	sw $ra, ($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)
	sw $t3,28($sp)
	sw $t4,32($sp)
	

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	move $a0,$s1
	jal _DemSoLuongKiTu
	#t0-> so luong ki tu	
	move $t0,$v0
	#t1-> index
	li $t1,0
	#load ki tu nguoi choi nhap vao
	lb $t4,($s0)

	#D
	move $a0,$t4
	li $v0,1
	syscall

	#flag kiem tra xem nguoi choi co nhap dung hay khong
	li $t3,0
	_KiemTraDapAnVaThayDoiEncodedAnswer.Loop:
		bge $t1,$t0,_KiemTraDapAnVaThayDoiEncodedAnswer.ExitLoop

		lb $t2,($s1)

		beq $t2,$t4,_KiemTraDapAnVaThayDoiEncodedAnswer.ThayDoiEncodedAnswer
		j _KiemTraDapAnVaThayDoiEncodedAnswer.ContinueLoop

		_KiemTraDapAnVaThayDoiEncodedAnswer.ThayDoiEncodedAnswer:
			li $t3,1
			sb $t4,($s2)
			#De
			la $a0,tb1
			li $v0,4
			syscall


		_KiemTraDapAnVaThayDoiEncodedAnswer.ContinueLoop:
		
		addi $s1,$s1,1
		addi $s2,$s2,1
		addi $t1,$t1,1


	j _KiemTraDapAnVaThayDoiEncodedAnswer.Loop

	_KiemTraDapAnVaThayDoiEncodedAnswer.ExitLoop:


	move $v0,$t3

	lw $ra, ($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)
	lw $t3,28($sp)
	lw $t4,32($sp)
	
	addi $sp,$sp,36
	jr $ra

#Thuc hien noi 2 chuoi lai voi nhau
	#a0-> buffer_fin (ket qua sau khi noi chuoi)
	#a1-> dia chi chuoi 1
	#a2-> dia chi chuoi 2

	#ket qua buff = a1 + a2 
_NoiChuoi:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)
	sw $t3,28($sp)
	#sw $t4,32($sp)

	

	#Luu lai cac tham so
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	#Khoi tao buffer_fin
	#move $a0,$s0
	#li $a1,1000
	#li $a2,1
	#jal _KhoiTaoMang

	##index chuoi buffer_fin

	_NoiChuoi.Loop1:
		lb $t3,($s1) 
		beqz $t3,_NoiChuoi.ExitLoop1
		lb $t3,($s1)
		sb $t3,($s0)

		addi $s0,$s0,1
		addi $s1,$s1,1

		
	j _NoiChuoi.Loop1
	
	_NoiChuoi.ExitLoop1:

	_NoiChuoi.Loop2:
		lb $t1,($s2)
		beqz $t1,_NoiChuoi.ExitLoop2
		
		sb $t1,($s0)	
	
		addi $s0,$s0,1
		addi $s2,$s2,1

	j _NoiChuoi.Loop2
	
	_NoiChuoi.ExitLoop2:
	sb $0,($s0)
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	lw $t2,24($sp)
	lw $t3,28($sp)
	addi $sp,$sp,32
	jr $ra

