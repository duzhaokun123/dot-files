$env.command_not_found_handler = { |cmd_name|
    let r = (do {/data/data/com.termux/files/usr/libexec/termux/command-not-found $cmd_name} | complete | get stderr | lines)
    if ($r.0 | str starts-with "The") {
        let pkgs = $r | skip 1 | append '' | str join ", after running pkg install ," | split row "or, after running pkg install ," | str trim | parse --regex 'pkg install (?P<package>\S*), after running pkg install (?P<repo>\S*),' | table
        # let pkgs = $r | skip 1 | split row " or " | str trim | str join "\n"
        return $"($cmd_name | style $env.config.color_config.shape_external) may be found in the following packages\n($pkgs)"
    } else if ($r.0 | str starts-with "No") {
        let pkgs = $r | skip 1 | append '' | str join ' from the  r;' | split row ';' | str trim | parse --regex 'Command (?P<command>\S*) in package (?P<package>\S*) from the (?P<repo>\S*) r' | table
        # let pkgs = $r | skip 1 | str trim | str join "\n"
        return $"($cmd_name | style $env.config.color_config.shape_external) not found, did you mean\n($pkgs)"
    } else {
        return $"command not found ($cmd_name | style $env.config.color_config.shape_external)"
    }
}