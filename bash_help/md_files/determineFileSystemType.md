* A file system is divided in two segments called: 
  * User Data 
  * Metadata

* file name, time it was created, modified time, size, location in the directory hierarchy etc...

## How to identify Linux file system type:

```bash
$ df -Th			OR	
$ df -Th | grep "^/dev"
$ fsck -N /dev/sda3
$ lsblk -f
$ mount | grep "^/dev"
$ blkid /dev/sda3
$ sudo file -sL /dev/sda3
$ cat /etc/fstab"
```
