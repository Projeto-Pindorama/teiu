# Teiú
The really tiny² installation system for Copacabana Linux.

## What is the main idea?
This is meant to be an installation system/wizard for Copacabana Linux.  
No, don't confuse it with the UCB `install`(8) utility nor with the `pkgadd`(8)
utility, they're not related at all — `install`(8) is meant for installing
binaries in a more portable and sane way, `pkgadd`(8) is meant to install
packages in an already installed system, transfering contents to the system (or
just plain extracting them in the file system tree), while Teiú is meant for
installing a system, a set of tarballs, in a disk.  
If you're looking for a package manager, you're may looking for [Motoko](https://github.com/Projeto-Pindorama/motoko)...
<sup>Which at this time don't have a single line of code, but already have a plan</sup>.  
This is more like an equivalent to the `void-installer`(1) script present at
Void Linux, for instance; but simpler, *a whole lot simpler <sup>(and
hackable/readable)</sup>* than it.  

Teiú is loosely inspired in SunOS 4.1.4 plain-text mode installer, but
implemented in it's own way. We don't need to plain mint Sun's work nor
ideas here, we think by ourselves. :^)

## Features? (And why not Calamares?)
Made in Shell script (ksh93), documented code, easy to hack-n-read, no frills,
it just works.  

Although Calamares being widespread and well-recognized by the Linux community,
I think it's overkill to build X and have to worry with graphics card compatibility
in a miniroot CD (or USB, it doesn't matter) just meant to install the operating
system. 
Why should I, besides the effort that I already had, compile X, a WM, configure
and strip everything just for running a program that will install Copacabana 
when I can just put a stripped version of Copacabana with ksh93 and some network
utilities and run Teiú without any other concern besides what I already have to
worry about?  

### TODO
#### Basic features

- A concrete way to drop the user to the shell;
- Make it possible to partition and format disks from the installer;
- Make it capable of keeping partitions and formatting others (this is *really*
  important);
- Network support as an option (eg.: if I want, I can choose to download stages
  from a FTP and/or a 9P network instead of using what is in the CD);
- Make it portable — in other words, if any distribution that distributes the
  system in a different way than Copacabana, they can use Teiú with just a little hacking.

#### "Advanced" features

- For now, just keep it simple.

## Chip in!

### Hacking
