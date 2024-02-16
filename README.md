# gvr700
A open-source Petya clone. There are a few features that Petya has that GVR-700 does not have, the most notable
being that there is no code to spread the malware.

# Backstory
Petya is a family of malware first discovered in 2016. It works by:
1. Infecting MBR, executing the actual dangerous payload, which is
2. Encrypts the master file table and demands a BTC payment.

# How does GVR-700 work?

## Step 1: Overwriting the Bootsector
GVR-700 uses the `CreateFile` Win32API function to write 512 bytes to the beginning of `\\.\PhysicalDrive0`,
which happens to be where the boot sector is. Conveniently, the MFT's (master file table) location is defined
in the bootsector (bytes `0x30` and `0x38`), meaning it gets overwritten aswell.

## Step 2: Encrypting partitions
Since it is extremely hard to make encryption systems like AES work in 16-bit mode, a simple `XOR` encryption
was done. We jump to `0x01be` which is [where the MBR stores the partition data](https://wiki.osdev.org/Partition_Table).
Now, this is different than the MFT which is already encrypted in step 1.

# Additional Features to be Added to GVR-700
GVR-700 attempts to be as hidden as possible. Below is a VirusTotal scan of the Petya.A virus.

![image](https://github.com/mxtlrr/gvr700/assets/117592709/29493042-94a7-4e6e-a95e-3c0bcb10db51)

# Disclaimer
THIS IS REAL, LIVE MALWARE! DO NOT RUN ON UNAUTHORIZED SYSTEMS. THIS REPOSITORY IS FOR PURELY EDUCATIONAL PURPOSES! I, [MXTLRR](https://github.com/mxtlrr)
AM NOT RESPONSIBLE FOR ANY DAMAGES DONE BY THIS RANSOMWARE. YOU HAVE BEEN WARNED.
