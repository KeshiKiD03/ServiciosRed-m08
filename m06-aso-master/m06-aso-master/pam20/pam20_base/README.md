# PAM

## @edt ASIX M06 2020-2021

* **chriswar/pam20:base** host pam per practicar *PAM* amb chfn i system-auth. Es tracten els types
  auth i session amb chfn practicant el significat de optional, sufficient, required i requisite i el 
  mòdul pam_unix.so. El type password amb pwquality. El type account amb pam_time.so. 
  El type sessions amb pam_mkhomedir.so i pam_mount.so. Es practica pam_mount.so amb un muntatge tmpfs
  i un de nfs4.

  Atenció, cal usar en el container --privileged per poder fer els muntatges nfs.

  ```$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisx --privileged -it chriswar/pam20:base```

