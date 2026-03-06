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

**Note:** The `iso` directory must exist with the following structure:
```
iso/
├── boot/
│   ├── kernel          (your compiled kernel binary)
│   └── grub/
│       └── grub.cfg    (GRUB menu configuration with kernel entry)
```

The `grub.cfg` must contain a valid menu entry pointing to the kernel path (e.g., `menuentry 'Kernel' { multiboot /boot/kernel }`).

Running `./build.sh` automatically creates and populates this directory structure. If using the manual one-liner, ensure you have:
1. Compiled the kernel (`kernel` binary in project root)
2. Created the `iso/boot/grub/` directory structure
3. Placed `grub.cfg` with proper menu entries in `iso/boot/grub/`

If files are missing, `grub-mkrescue` will fail with "file not found" errors. Use `./build.sh` as the recommended approach instead.

## Build from PowerShell (Windows)

**Prerequisite:** WSL (Windows Subsystem for Linux) must be installed and configured with a Debian or Ubuntu distro.

**Quick setup:** Open PowerShell as **Administrator** and run:

```powershell
wsl --install -d Debian
```

If prompted to restart, do so. Then verify:

```powershell
wsl -l -v
```

If `wsl --install` is not available (older Windows 10 builds), see "Fallback for older Windows" below.

Then run:

```powershell
.\build.ps1
```

This PowerShell wrapper calls WSL to execute the Linux build script (`./build.sh`) in your WSL environment, assembles and links the kernel, and generates `kernel.iso`.

### Fallback for older Windows

If `wsl --install` is unavailable, manually enable WSL:
1. Open **Settings** > **Apps** > **Optional features** (or search "Turn Windows features on or off")
2. Enable **Windows Subsystem for Linux**
3. Restart your computer
4. Then run `wsl --install -d Debian` in PowerShell as Administrator

## Important

Do not paste xorriso output lines back into the shell. Lines like `Drive current:`, `Media status:`, or `Written to medium:` are output text, not commands.
