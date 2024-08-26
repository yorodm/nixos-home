{config, pkgs, lib, ...}:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
    };
    config = ./files/polybar.conf;
    script = lib.mkDefault ''
      # HACK: Cut is unavailable in the path so we do some sad indirection bc i'm
      #       too lazy to figure out which packages i need. excuse the horrible
      #       double shell too.
      export PATH="/var/run/current-system/sw/bin:$PATH"
      MONITORS=$(bash -c "polybar --list-monitors | cut -d ':' -f 1")
      for m in $MONITORS; do
        MONITOR=$m polybar default &
      done
    '';
  };
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Default to monitor 0, but follow mouse focus if possible.
        monitor = 0;
        follow = "mouse";

        geometry = "600x50-25+40";
        indicate_hidden = true;
        shrink = false;
        transparency = 5;
        notification_height = 0;
        seperator_height = 2;
        padding = 10;
        horizontal_padding = 10;
        frame_width = 2;
        frame_color = "#4527A0";
        seperator_color = "frame";

        sort = true;

        font = "Iosevka Nerd Font 10";
        line_height = 5;
        format = "<b>%s</b>\n%b";
        markup = "full";
        plain_text = false;

        ignore_newline = false;
        word_wrap = true;
        alignment = "left";
        show_age_threshold = 60;

        icon_position = "left";
        max_icon_size = 80;

        startup_notification = false;
         dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst -theme glue_pro_blue";
        browser = "${pkgs.firefox} -new-tab";
      };

      urgency_low = {
        background = "#ffc4fa";
        foreground = "#333333";
      };

      urgency_normal = {
        background = "#ffc4fa";
        foreground = "#333333";
      };

      urgency_critical = {
        background = "#ffc4fa";
        foreground = "#333333";
        frame_color = "#bf616a";
      };
    };
  };
}
