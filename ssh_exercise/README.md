# SSH Key Generation and Management Exercise

This exercise will help you understand:
- How to generate SSH key pairs
- How public and private keys work together
- How to configure SSH clients
- How to manage SSH keys securely

## Exercise 1: Generate an SSH Key Pair

1. Generate an ED25519 SSH key pair:
   ```
   ssh-keygen -t ed25519 -C "your_email@example.com" -f ./id_ed25519
   ```

2. Examine the files created:
   ```
   ls -la
   ```

3. Inspect your public key:
   ```
   cat id_ed25519.pub
   ```

4. Learn about key components:
   - The private key (id_ed25519) should NEVER be shared
   - The public key (id_ed25519.pub) can be shared freely
   - The format of the public key is: [key-type] [key-data] [comment]

## Exercise 2: Set Up a Simple SSH Config File

Create a simple SSH config file to understand how to manage multiple connections:

```
touch ssh_config
```

Edit the file to include:

```
Host example
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    Port 22
```

## Exercise 3: Understand SSH Agent

1. Start the SSH agent:
   ```
   eval "$(ssh-agent -s)"
   ```

2. Add your key to the agent:
   ```
   ssh-add ./id_ed25519
   ```

3. List keys in the agent:
   ```
   ssh-add -l
   ```

## Exercise 4: SSH Security Best Practices

1. Create a key with a passphrase:
   ```
   ssh-keygen -t ed25519 -C "secure_key@example.com" -f ./secure_id_ed25519
   ```
   (Enter a passphrase when prompted)

2. Compare security considerations:
   - Keys with passphrases vs. without
   - Different key types (RSA, ED25519, etc.)
   - Key size considerations

## Exercise 5: Simulate Remote Authentication

We'll create a script to simulate how SSH authentication works:

```
touch simulate_auth.sh
chmod +x simulate_auth.sh
```