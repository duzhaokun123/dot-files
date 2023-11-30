$env.command_not_found_handler = { |cmd_name|
    print $"command not found ($cmd_name | style $env.config.color_config.shape_external)"
    let s = (input "Search by scoop? (it may work slow) (y/N)")
    if $s == "y" or $s == "Y" {
        let r = (scoop search $cmd_name | lines)
        if ($r | length) == 1 {
            return $"and scoop has no matches for ($cmd_name | style $env.config.color_config.shape_external)"
        } else {
            let pkgs = $r | split row "\n" | skip 4 | drop 1 | parse --regex '(?P<name>\S*)\s*(?P<version>\S*)\s*(?P<source>\S*)\s*(?P<binaries>[\s\S]*)' | table
            # let pkgs = $r | split row "\n" | skip 2 | drop 1 | str join "\n"
            return $"($cmd_name | style $env.config.color_config.shape_external) may be found in the following packages\n($pkgs)"
        }
    } else {
        return $"but skip scoop search for ($cmd_name | style $env.config.color_config.shape_external)"
    }
}