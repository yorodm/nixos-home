# credits: @LightDiscord who helped me to update to picom
{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    # settings = {
    #   corner-radius = 12.0;
    #   blur-background = true;
    #   blur-background-frame = true;
    #   blur-background-fixed = true;
    #   blur-kern = "3x3box";
    #   #blur-method = "kawase";
    #   blur-strength = 16;
    #   blur-background-exclude = [
    #     "class_g = 'slop'"
    #     "class_g = 'XAVA'"
    #   ];
    #   shadow = true;
    #   shadow-radius = 12;
    #   shadow-opacity = 0.25;
    #   shadow-offset-x = -7;
    #   shadow-offset-y = -7;
    #   shadow-exclude = [
    #       "class_g = 'XAVA'"
    #   ];
    #   fading = true;
    #   fade-in-step = 0.1;
    #   fade-out-step = 0.1;
    #   fade-exclude = [ ];
    #   use-damage = false;
    # };
  };
}
