$env.command_not_found_handler = { |cmd_name| 
    let r = (pkgfile -bv $cmd_name | complete | get stdout)
    if ($r | is-empty) {
        return $"command not found ($cmd_name | style $env.config.color_config.shape_external)"
    } else {
        let pkgs = $r | lines | parse --regex '(?P<package>\S*)\s*(?P<version>\S*)\s*(?P<binarie>[\S\s]*)' | table
        # let pkgs = $r
        return $"($cmd_name | style $env.config.color_config.shape_external) may be found in the following packages\n($pkgs)"
    }
}