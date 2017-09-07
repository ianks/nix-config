{ pkgs, ... }:

{
    environment = {
        services.xserver.enable = true;
        services.xserver.layout = "us";

        systemPackages = with pkgs; [
            gnome3.gdm
            numix-gtk-theme
            numix-icon-theme-circle
        ];

	# GTK3 global theme (widget and icon theme)
        etc."xdg/gtk-3.0/settings.ini" = {
            text = ''
                [Settings]
                gtk-icon-theme-name=Numix-circle
                gtk-theme-name=Numix
                gtk-application-prefer-dark-theme = true
            '';
        };
    };
}
