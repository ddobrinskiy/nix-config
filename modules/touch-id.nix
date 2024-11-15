{ ... }:

  ###################################################################################
  #
  #  macOS's Touch ID configuration
  #
  # https://write.rog.gr/writing/using-touchid-with-tmux/#creating-a-etcpamdsudo_local-file-using-nix-darwin
  # 
  ###################################################################################
{
  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

}