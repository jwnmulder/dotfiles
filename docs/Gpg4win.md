# Gpg4win

Most of the time, gpg socket forwarding from WSL to Windows works perfectly fine. Sometimes however, it doesn't.

Some Linux commands to help debugging

```bash
ssh-add -l
gpg -K

# With a Yubikey present, these should work
gpg --card-status
```

On the Windows host, where gpg is installed via the GnuPG.Gpg4win package, these are useful commands as well

```powershell
# Restart core gpg components
gpgconf --kill gpg-agent
gpgconf --kill scdaemon

# yubikey specific tests
gpg --card-status
certutil.exe -scinfo
```
