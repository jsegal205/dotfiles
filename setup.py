import os
import sys
import subprocess
import platform
import shutil

def run_command(command, check=True):
    """Runs a shell command and handles errors."""
    try:
        print(f"Running: {' '.join(command)}")
        result = subprocess.run(command, check=check, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print(result.stdout)
        if result.stderr:
            print(f"Error: {result.stderr}")
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")
        sys.exit(1)

def install_homebrew():
    """Installs Homebrew on macOS."""
    if shutil.which("brew"):
        print("Homebrew already installed.")
    else:
        run_command(["/bin/bash", "-c", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"])

def install_apt_packages():
    """Installs necessary packages on Ubuntu."""
    run_command(["sudo", "apt-get", "update"])
    packages = ["git", "zsh", "vim", "curl"]  # Add more as needed
    run_command(["sudo", "apt-get", "install", "-y"] + packages)

def clone_dotfiles():
    """Clones dotfiles from GitHub and sets them up."""
    repo_url = "https://github.com/jsegal205/dotfiles.git"
    projects_dir = os.path.expanduser("~/projects2")

    # Create the directory if it doesn't exist
    if not os.path.exists(projects_dir):
        print(f"Creating {projects_dir} directory...")
        os.makedirs(projects_dir)

    dotfiles_dir = os.path.join(projects_dir, "dotfiles")

    if os.path.exists(dotfiles_dir):
        print("Dotfiles repo already exists.")
        print("Checking for updates...")
        run_command(["git", "-C", dotfiles_dir, "pull"])
    else:
        run_command(["git", "clone", repo_url, dotfiles_dir])
        run_command(["zsh", os.path.join(dotfiles_dir, "install.sh")])

def main():
    os_type = platform.system()

    if os_type == "Darwin":
        print("Setting up for macOS...")
        install_homebrew()
    elif os_type == "Linux":
        print("Setting up for Ubuntu...")
        install_apt_packages()
    else:
        print(f"Unsupported OS: {os_type}")
        sys.exit(1)

    clone_dotfiles()
    print("Setup complete! 🎉")

if __name__ == "__main__":
    main()
