{ inputs, pkgs, config, ... }: {
    # Laptop-specific packages (the other ones are installed in `packages.nix`)
    environment.systemPackages = with pkgs; [
        acpi tlp git
    ];
}