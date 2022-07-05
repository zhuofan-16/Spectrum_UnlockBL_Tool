# Signature.bin file creator for spectuam device's bootloader unlock


## Instruction:
- Open cmd/terminal and navigate to the folder
- execute 'fastboot oem get_identifier_token' first to get identifier token 
- './unlockbl.sh <identifier token >  sign.pem signature.bin' to create the unlock file
- 'fastboot flashing unlock_bootloader signature.bin' to unlock the bootloader

