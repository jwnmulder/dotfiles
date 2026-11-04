# bitwarden

Pretty format password-health

```bash
bw login
export BW_SESSION="$(bw unlock --raw)"

bw report password-health --pretty |
jq -r '
  [.[]? | objects] as $entries |
  def row($type):
    [
      $type,
      .name,
      (.passwordStrength | tostring),
      (.reuseCount // "-" | tostring),
      (if .exposed then (.exposedCount | tostring) else "-" end)
    ] | @tsv;

  (["TYPE", "NAME", "STRENGTH", "REUSED", "BREACH COUNT"] | @tsv),
  ($entries[] | select(.exposed == true) | row("EXPOSED")),
  ($entries[] | select(.passwordStrength < 3 and .exposed != true) | row("WEAK"))
' | column -t -s $'\t'
```
