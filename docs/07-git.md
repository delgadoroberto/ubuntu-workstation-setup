# Git

Git is a distributed version control system used to track changes to files and collaborate on software projects.

This guide covers the installation and basic configuration of Git on Ubuntu 26.04.

---

## 1. Install Git

Update the package index:

```bash
sudo apt update
```

Install Git:

```bash
sudo apt install -y git
```

---

## 2. Verify the Installation

Check the installed Git version:

```bash
git --version
```

Example:

```text
git version 2.x.x
```

The exact version depends on the Git package available in the Ubuntu 26.04 repositories.

You can also check which executable is being used:

```bash
which git
```

---

## 3. Configure Your Git Identity

Git uses a name and email address to identify the author of commits.

Set your global name:

```bash
git config --global user.name "Your Name"
```

Set your global email address:

```bash
git config --global user.email "your-email@example.com"
```

Replace the example values with the name and email address you want to associate with your Git commits.

> If you use GitHub, the email address should normally correspond to an email address associated with your GitHub account, or to the GitHub-provided noreply address you choose to use for privacy.

---

## 4. Set the Default Branch Name

Configure `main` as the default branch name for newly initialized repositories:

```bash
git config --global init.defaultBranch main
```

Verify the configuration:

```bash
git config --global init.defaultBranch
```

Expected result:

```text
main
```

This setting affects repositories created with:

```bash
git init
```

It does not rename branches in repositories that already exist.

---

## 5. Configure Git's Default Editor

Git may open a text editor when an operation requires you to enter or edit a message.

To use Neovim:

```bash
git config --global core.editor "nvim"
```

Verify:

```bash
git config --global core.editor
```

Expected:

```text
nvim
```

> This configuration is optional. If Neovim has not been installed yet, configure the editor after completing [Neovim](09-neovim.md).

Alternatively, you can configure another editor, such as Vim:

```bash
git config --global core.editor "vim"
```

---

## 6. Configure Useful Git Defaults

Enable colored Git output:

```bash
git config --global color.ui auto
```

Enable automatic setup of remote tracking branches when pushing a new local branch:

```bash
git config --global push.autoSetupRemote true
```

This allows Git to automatically configure the upstream branch the first time a new local branch is pushed.

Verify both settings:

```bash
git config --global color.ui
```

```bash
git config --global push.autoSetupRemote
```

---

## 7. Configure Pull Behavior

Git supports different strategies when integrating remote changes during `git pull`.

A common and predictable default is to use merge behavior:

```bash
git config --global pull.rebase false
```

Verify:

```bash
git config --global pull.rebase
```

Expected:

```text
false
```

> This is a workflow preference, not a requirement. Teams may use rebase-based workflows instead. Follow the workflow established by the project you are contributing to.

If your project requires rebase-based pulls, configure:

```bash
git config --global pull.rebase true
```

Do not configure both values. The last command executed determines the current setting.

---

## 8. Review the Git Configuration

Display all global Git configuration values:

```bash
git config --global --list
```

For a more readable output:

```bash
git config --global --list --show-origin
```

This also shows which configuration file provides each setting.

The global Git configuration is normally stored in:

```text
~/.gitconfig
```

Inspect it directly with:

```bash
cat ~/.gitconfig
```

---

## 9. Generate an SSH Key for GitHub

SSH authentication allows Git to communicate with GitHub without entering your GitHub password for every operation.

First, check whether an SSH key already exists:

```bash
ls -la ~/.ssh
```

Look for files such as:

```text
id_ed25519
id_ed25519.pub
```

If you already have a suitable key, you do not necessarily need to create another one.

If you do not have an SSH key, generate an Ed25519 key:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

When prompted for the file location, pressing `Enter` accepts the default:

```text
~/.ssh/id_ed25519
```

Using a passphrase is recommended.

---

## 10. Start the SSH Agent

Start the SSH authentication agent:

```bash
eval "$(ssh-agent -s)"
```

The command should return an agent process identifier.

---

## 11. Add the SSH Key to the Agent

Add your private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Verify that the key has been added:

```bash
ssh-add -l
```

The output should contain the fingerprint of the loaded key.

> Never share your private key. The private key is the file without the `.pub` extension.

---

## 12. Display the Public SSH Key

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

The output should look similar to:

```text
ssh-ed25519 AAAA... your-email@example.com
```

Copy the complete public key.

Only the `.pub` file should be shared with Git hosting services.

Never share:

```text
~/.ssh/id_ed25519
```

---

## 13. Add the SSH Key to GitHub

Open your GitHub account settings and add the public key under the SSH keys section.

Use the key generated in the previous steps.

When adding the key, give it a descriptive title, such as:

```text
Ubuntu Workstation
```

or:

```text
Ubuntu 26.04
```

The exact title is up to you.

---

## 14. Test GitHub SSH Authentication

Test the SSH connection:

```bash
ssh -T git@github.com
```

The first connection may display a message asking whether you trust GitHub's host key.

Verify the host and confirm only if it matches the expected GitHub SSH host information.

After successful authentication, GitHub should indicate that authentication succeeded.

> GitHub does not provide an interactive shell over SSH. A message indicating that shell access is not provided is expected after successful authentication.

---

## 15. Configure the GitHub Remote

When cloning a repository, use the SSH URL:

```bash
git clone git@github.com:USERNAME/REPOSITORY.git
```

Replace:

```text
USERNAME
```

with your GitHub username and:

```text
REPOSITORY
```

with the repository name.

For an existing repository, check the configured remote:

```bash
git remote -v
```

If the repository currently uses HTTPS and you want to switch to SSH:

```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

Verify:

```bash
git remote -v
```

---

## 16. Test Git with a Repository

Create a temporary test directory:

```bash
mkdir -p "$HOME/git-test"
```

Enter the directory:

```bash
cd "$HOME/git-test"
```

Initialize a repository:

```bash
git init
```

Check the repository status:

```bash
git status
```

Create a test file:

```bash
printf '# Git Test\n' > README.md
```

Stage the file:

```bash
git add README.md
```

Create the first commit:

```bash
git commit -m "Initial commit"
```

Check the commit history:

```bash
git log --oneline
```

When finished, leave the test directory:

```bash
cd "$HOME"
```

You can remove it if it is no longer needed:

```bash
rm -rf "$HOME/git-test"
```

> Only remove this directory if you created it specifically for this test and it does not contain any files you need.

---

## 17. Useful Git Commands

The following commands are useful for daily Git operations.

### Check repository status

```bash
git status
```

### View configured remotes

```bash
git remote -v
```

### View commit history

```bash
git log --oneline
```

### Create a new branch

```bash
git switch -c feature-name
```

### Switch branches

```bash
git switch branch-name
```

### Stage changes

```bash
git add filename
```

Stage all changes:

```bash
git add .
```

### Commit changes

```bash
git commit -m "Describe the change"
```

### Pull changes

```bash
git pull
```

### Push changes

```bash
git push
```

---

## 18. Verify the Complete Configuration

Check the Git version:

```bash
git --version
```

Check the configured identity:

```bash
git config --global user.name
```

```bash
git config --global user.email
```

Check the default branch:

```bash
git config --global init.defaultBranch
```

Check the configured editor:

```bash
git config --global core.editor
```

Check the pull behavior:

```bash
git config --global pull.rebase
```

Check the SSH key:

```bash
ssh-add -l
```

Test GitHub authentication:

```bash
ssh -T git@github.com
```

---

## Git Configuration Summary

A basic workstation configuration may include:

```text
Git
├── Installed
├── User identity configured
├── Default branch: main
├── Editor configured
├── Automatic remote tracking enabled
├── Pull behavior configured
└── SSH authentication with GitHub configured
```

The global configuration can be reviewed with:

```bash
git config --global --list --show-origin
```

The configuration file is normally:

```text
~/.gitconfig
```

---

## Security Considerations

Git and SSH configuration should be handled carefully.

### Protect Private Keys

Never share or commit your private SSH key:

```text
~/.ssh/id_ed25519
```

Only the public key may be uploaded to GitHub:

```text
~/.ssh/id_ed25519.pub
```

### Use SSH Key Passphrases

Protect SSH private keys with a strong passphrase whenever possible.

### Do Not Commit Secrets

Never commit:

- Passwords
- API keys
- Access tokens
- Private SSH keys
- Cloud credentials
- `.env` files containing secrets
- Certificates or private keys

Use appropriate secret-management mechanisms instead.

### Review Changes Before Committing

Before committing changes, review the working tree:

```bash
git status
```

Review the diff:

```bash
git diff
```

Review staged changes:

```bash
git diff --cached
```

This can help prevent accidentally committing sensitive information.

---

Once Git is installed and configured, continue with [WezTerm](08-wezterm.md).
