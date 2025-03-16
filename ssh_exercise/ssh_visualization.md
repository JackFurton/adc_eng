# SSH Key Authentication Visualization

## How SSH Key Authentication Works

```
┌──────────────────┐                            ┌──────────────────┐
│                  │                            │                  │
│   Your Computer  │                            │   Remote Server  │
│                  │                            │                  │
└──────────────────┘                            └──────────────────┘
         │                                               │
         │                                               │
         │                                               │
┌──────────────────┐                            ┌──────────────────┐
│                  │                            │                  │
│   Private Key    │                            │   Public Key     │
│  (Keep Secret)   │                            │ (authorized_keys)│
│                  │                            │                  │
└──────────────────┘                            └──────────────────┘

```

## SSH Authentication Flow

1. **Connection Initiation**
   ```
   ┌──────────┐                                     ┌──────────┐
   │  Client  │───────── SSH Connection ────────────▶  Server  │
   └──────────┘                                     └──────────┘
   ```

2. **Server Sends Challenge**
   ```
   ┌──────────┐                                     ┌──────────┐
   │  Client  │◀────── Random Challenge ────────────│  Server  │
   └──────────┘                                     └──────────┘
   ```

3. **Client Signs Challenge with Private Key**
   ```
   ┌──────────┐  ┌───────────┐
   │  Client  │──│ Challenge │──┐
   └──────────┘  └───────────┘  │
                                │
                   Private Key  │
                                │
                                ▼
                        ┌─────────────┐
                        │   Signed    │
                        │  Response   │
                        └─────────────┘
   ```

4. **Client Sends Signed Response**
   ```
   ┌──────────┐   ┌─────────────┐                   ┌──────────┐
   │  Client  │───│   Signed    │──────────────────▶│  Server  │
   └──────────┘   │  Response   │                   └──────────┘
                  └─────────────┘
   ```

5. **Server Verifies Signature with Public Key**
   ```
                                                    ┌──────────┐
                                                    │  Server  │
                                                    └──────────┘
                                                         │
                                                         │
                                                         ▼
   ┌───────────┐  ┌─────────────┐              ┌──────────────┐
   │ Challenge │  │   Signed    │              │  Public Key  │
   └───────────┘  │  Response   │──────────────│ Verification │
                  └─────────────┘              └──────────────┘
                                                         │
                                                         │
                                                         ▼
                                                  ┌─────────────┐
                                                  │  Identity   │
                                                  │  Confirmed  │
                                                  └─────────────┘
   ```

6. **Authentication Complete**
   ```
   ┌──────────┐                                     ┌──────────┐
   │  Client  │◀────── Access Granted ──────────────│  Server  │
   └──────────┘                                     └──────────┘
   ```

## Key Concepts

1. **Asymmetric Cryptography**: SSH uses key pairs where:
   - The private key can decrypt what the public key encrypts
   - The public key can verify what the private key signs

2. **Security Model**:
   - Your private key never leaves your computer
   - The server only knows your public key
   - Only someone with your private key can authenticate as you

3. **No Password Transmission**:
   - Your password is never sent over the network
   - The challenge-response mechanism proves identity without revealing secrets