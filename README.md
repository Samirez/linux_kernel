# linux_kernel
Creating a custom linux kernel from scratch

## Build (WSL Debian/Ubuntu)

Install dependencies once:

```bash
sudo apt-get update
sudo apt-get install -y nasm gcc grub-pc-bin xorriso
```

Build and create `kernel.iso`:

```bash
./build.sh
```

Manual one-liner (from project root):

```bash
grub-mkrescue -o "$(pwd)/kernel.iso" "$(pwd)/iso"
```

## Build from PowerShell (Windows)

Run:

```powershell
.\build.ps1
```

This calls WSL and runs the same Linux build script.

## Important

Do not paste xorriso output lines back into the shell. Lines like `Drive current:`, `Media status:`, or `Written to medium:` are output text, not commands.
