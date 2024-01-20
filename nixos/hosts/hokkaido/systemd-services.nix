{ config, pkgs, ... }:

{
  systemd.user.services.ems = {
    description = "EMS Replacement Script Service";
    enable = false;

    path = [ pkgs.jq pkgs.curl pkgs.jq pkgs.bash pkgs.bc ];

    wants = ["ems.timer"];
    # Define the service configuration
    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.users.users.conor.home}/ems/final/generate.sh";
      WorkingDirectory = "${config.users.users.conor.home}/ems/final";
      TimeoutSec = 900;
    };
  };

  systemd.user.timers.ems = {
    description = "Runs EMS script every hour";
    enable = false;
    requiredBy = ["ems.service"];
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*:50";
      Unit = "ems.service";
    };
  };
}
