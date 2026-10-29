# pipeferry

Setup

```bash
pipeferry service install --name ssh-agent --socket-name ssh-agent.sock \
  -- pipeferry.exe npipe-connect --pipe openssh-ssh-agent
```

Debugging

```bash
pipeferry service status --name ssh-agent
systemctl --user restart pipeferry-ssh-agent.service
journalctl --user --unit pipeferry-ssh-agent.service --follow
pipeferry doctor --ssh-agent -- pipeferry.exe npipe-connect --pipe openssh-ssh-agent
```
