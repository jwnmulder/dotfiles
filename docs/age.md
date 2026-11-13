# age

Age identities in combination with fnox profiles / providers.

| Identity               | Local profile | Local PQ profile | Personal / team profile | Personal / team PQ profile | Daily use            | Provisioned via                   |
| ---------------------- | ------------- | ---------------- | ----------------------- | -------------------------- | -------------------- | --------------------------------- |
| Device keys            | Yes (default) | Yes (default)    | No                      | No                         | Keychain             | Uniquely generated locally     |
| Personal keys          | No            | No               | Yes (default)           | Yes (default)              | Keychain / 1password | Provisioned from password manager |
| Recovery keys          | Yes           | Yes              | No                      | No                         | N/A                  |                                   |
| YubiKey                | Optional      | No               | Optional                | No                         |                      |                                   |
| ***Profile specific*** |               |                  |                         |                            |                      |                                   |
| Shared across devices  | No            | No               | Yes                     | Yes                        |                      |                                   |

Notes:

* fnox does not support age pq keys yet

## reencrypting fnox passwords

```bash
FNOX_AGE_IDENTITY=recovery fnox reencrypt
# or
FNOX_AGE_IDENTITY=recovery fnox reencrypt --provider local-age
```
