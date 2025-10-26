$env.EDITOR = "vim"

mkdir ~/.cache/carapace
$env.CARAPACE_BRIDGES = "zsh,bash"
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# custom config
const custom_config = ($nu.default-config-dir | path join custom.nu)
if not ($custom_config | path exists) {
    touch $custom_config
}

# command not found handler
const command_not_found_handler = ($nu.default-config-dir | path join command_not_found_handler.nu)
if not ($command_not_found_handler | path exists) {
    touch $command_not_found_handler
}
