Signature.bin file creator for Qin2 Pro infact,for spectuam device's bootloader unlock
============================================
Signature.bin文件制作器 -多亲2 pro
============================================


## excute fastboot oem get_identifier_token first to get identifier token 
## then ./unlockbl.sh <identifier token >  sign.pem signature.bin
  
## lastly fastboot flashing unlock_bootloader signature.bin

