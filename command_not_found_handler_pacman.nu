$env.command_not_found_handler = { |cmd_name| 
    let r = (pkgfile -bv $cmd_name)
    if ($r | is-empty) {
        return null
    } else {
        # let pkg = $r | lines | parse --regex '(?P<package>\S*)\s*(?P<version>\S*)\s*(?P<binarie>[\S\s]*)'
        let pkgs = $r
        return $"($cmd_name) may be found in the following packages\n($pkgs)"
    }
}