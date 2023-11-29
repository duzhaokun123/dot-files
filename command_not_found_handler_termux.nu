$env.command_not_found_handler = { |cmd_name|
    let command_not_found_path = "/data/data/com.termux/files/usr/libexec/termux/command-not-found"
    if ($command_not_found_path | path exists) {
        let r = (do {exec $command_not_found_path $cmd_name} | complete | get stderr | lines)
        if ($r.0 | str starts-with "The") {
            # let pkgs = $r | skip 1 | str join " " | split row " or " | str trim
            let pkgs = $r | skip 1 | split row " or "
            return $"($cmd_name) may be found in the following packages\n($pkgs)"
        } else if ($r.0 | str starts-with "") {

        }
    }
    return $"command not found: ($cmd_name)"
}