
# Setting up dev stack in Windows Subsystem for Linux 2

So now the May 2020 update for Windows 10 is out, and that means that we can begin using WSL2.

That's pretty nice, but what if you already have WSL1 set up on your machine, perhaps with a lot of customizations, and you don't want to lose all that work, but at the same time, you want to be able to use the latest and greatest, if at all possible.  So here's some tips I have learned as I've gone through the set up.

## You can use WSL1 and WSl2 side by side.

For the remainder of this document, I'm going to assume that you already have WSL1 set up and working correctly.

First thing to realize is that WSL2 is going to be like an additional OS, installed side-by-side with Windows and whatever linux version you're using with WSL1. So you're going to have to re-configure any server software that you're using in your shiny WSL2 OS, even if you already have it configured in WSL1.

The second thing to realize is that WSL2 sets up a section of your hard drive to use for its filesystem.  This is different from WSL1, which created a virtual filesystem for you inside of Windows, along with all the overhead that entails.

## Performing the upgrade

- Enable the Virtual Machine Platform component.
  - Open Powershell as an admin, and run `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
  - Restart your machine.

- Update your kernel.
  - You have to manually download and update the linux kernel. (this is a good thing)
  - Visit `aka.ms/wsl2kernel` in your browser to get the new kernel as a `.msi` package, and install it.

- Set the default version to WSL2
  - Open powershell as an administrator
  - run `wsl --set-default-version 2`

- Install a new linux distro into your fresh WSL2 installation.
  - I suggest Ubuntu 20.04 LTS, which is the newest Ubuntu as of this writing.
  - You can get it here: https://www.microsoft.com/store/apps/9n6svws3rx71

- Set up the distro.
  - You'll be prompted to set up a new user and password.  Remember, this is like a fresh OS, so this is a separate account.  For the sake of convenience, I used my same username and pasword from WSL1, but you can use a different one if you like.

- You can find out which versions of what are available by running `wsl --list --verbose` in Powershell.  That'll confirm you have installed what you expected, where you expected.

- You can run the `setup_stack.sh` script to get PHP, Apache, MySQL, NPM, Node.js, Composer, and the rest of the stuff you'll need.


## Presumably, you want your WSL2 to behave more or less like your WSL1 install

What I have done on my system is I've set up many of my important customization scripts to live in my Windows home directory, and then I symlink them into my Linux home directories.  I made a directory called `.config` in `C://Users/{username}` to hold them.  That way, I can use the same bash files, the same SSH keys, the same github config and so forth, between WSL1, WSL2, and anywhere in Windows land.

#### But, shouldn't I store my linux files in my linux partition?

Yes, however, things like your `.bashrc` file only need to be read once per bash session, so you're not going to get much of a performance hit from the file system on those.

Files you may want to share between installs:

- `.bash_aliases`
- `.bash_rc`
- `.gitconfig`
- `.ssh/`
- `.nano/`
- `.acquia/`

## How can you tell which WSL system you're in?

I configure my bash prompt for this purpose, and I use an environment variable to keep track of which is which.

- In WSL1, create a file `~/.bash_wsl`
- In that file, put in something like:
```
export WSL_VERSION=1
export UBUNTU_VERSION=20.04
```
Obviously, adjust that for whatever is correct for you.
- In WSL2, create the same file, and put in values that represent the correct information for your WSL2 environment.
- In your `.bashrc` (which you're now sharing between environments, see above), add the following lines:
```
# Load any environment stuff which is specific to this WSL version.
if [ -f ~/.bash_wsl ]; then
    . ~/.bash_wsl
fi
```
That will load your environment-specific variables each time you load bash.
- In the same file, add or adjust the settings for your prompt.  You can tell which ones they are because they set a variable called `PS1`.
```
PS1=u@local-wsl$WSL_VERSION-ubuntu-$UBUNTU_VERSION
```
That will set your prompt to look something like:
```
ian@local-wsl1-ubuntu-18.04
```

That should help you to know at a glance which WSL you're using for what.

