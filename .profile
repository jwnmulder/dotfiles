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

# source files from ~/.profile.d
if [ -d $HOME/.profile.d ]; then
  for i in $HOME/.profile.d/*; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# # docker-for-desktop binary unlink
# if [ -f /usr/bin/kubectl ]; then
#   # ignore the docker-for-desktop provided /usr/local/bin/kubectl as it is way to old
#   ln -f -s /usr/bin/kubectl $(systemd-path user-binaries)/.
# fi

# If running inside WSL
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then

    # Fix Windows/WSL2 interoperability issue that sometimes occurs
    # See https://www.blogbyben.com/2022/02/gotcha-when-windows-and-wsl2-stop.html
    # and https://github.com/microsoft/WSL/issues/6420
    #export WSL_INTEROP=/var/run/WSL/$(ps auxwwww|grep init | \
    #  grep -v grep | tail -1 | awk '{print $2}')_interop

    # See https://github.com/microsoft/WSL/issues/7174#issuecomment-940163080
    parentof() {
        pid=$(ps -p ${1:-$$} -o ppid=;)
        echo ${pid// /}
    }

    interop_pid=$$

    while true ; do
        [[ -e /run/WSL/${interop_pid}_interop ]] && break
        interop_pid=$(parentof ${interop_pid})
        [[ ${interop_pid} == 1 ]] && break
    done

    if [[ ${interop_pid} == 1 ]] ; then
        echo "Failed to find a parent process with a working interop socket.  Interop is broken."
    else
        export WSL_INTEROP=/run/WSL/${interop_pid}_interop
    fi

    # WSL SSH & GPG relay
    if [ -f $HOME/.ssh/ssh-gpg-wsl2-proxy ]; then
        echo "sourcing .ssh/ssh-gpg-wsl2-proxy"
        source $HOME/.ssh/ssh-gpg-wsl2-proxy
    fi
fi
