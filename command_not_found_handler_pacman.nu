$env.command_not_found_handler = { |cmd_name| 
    let r = (pkgfile -bv $cmd_name)
    if ($r | is-empty) {
        return null
    } else {
        let pkgs = $r | lines | parse --regex '(?P<package>\S*)\s*(?P<version>\S*)\s*(?P<binarie>[\S\s]*)' | table
        # let pkgs = $r
        return $"($cmd_name) may be found in the following packages\n($pkgs)"
    }
}