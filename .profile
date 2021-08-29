# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set PATH to include ~/.krew/bin if it exists
if [ -d "${KREW_ROOT:-$HOME/.krew}"/bin ]; then
    PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# #user-binaries path
# if [ ! -f $(systemd-path user-binaries) ]; then
#   mkdir -p $(systemd-path user-binaries)
# fi
# PATH="$(systemd-path user-binaries):$PATH"

# # docker-for-desktop binary unlink
# if [ -f /usr/bin/kubectl ]; then
#   # ignore the docker-for-desktop provided /usr/local/bin/kubectl as it is way to old
#   ln -f -s /usr/bin/kubectl $(systemd-path user-binaries)/.
# fi

# If running inside WSL
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then

    # WSL SSH & GPG relay
    if [ -f $HOME/.ssh/ssh-gpg-wsl2-proxy ]; then
        source $HOME/.ssh/ssh-gpg-wsl2-proxy
    fi
fi
