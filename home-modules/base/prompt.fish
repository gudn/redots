set -l last_pipestatus $pipestatus
set -lx __fish_last_status $status
set -l color_cwd
set -l suffix
if functions -q fish_is_root_user; and fish_is_root_user
    if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
    else
        set color_cwd $fish_color_cwd
    end
    set suffix '!>'
else
    set color_cwd $fish_color_cwd
    set suffix '>'
end
if set -q VIRTUAL_ENV
    echo -n -s (set_color blue) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
end
set_color $color_cwd
echo -n (prompt_pwd)
set_color normal
printf '%s' (fish_vcs_prompt)
set -l pipestatus_string (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
echo -n $pipestatus_string
set_color normal
echo -n "$suffix "
