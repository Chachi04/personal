function tm
    if count $argv > /dev/null
        if test "$argv[1]" = "a"
            if test $(tmux ls | wc -l) -le 1
                tmux a
            else
                set -l session_name (tmux ls -F '#{session_name}' | fzf --reverse)
                if test "$session_name" != ""
                    tmux a -t $session_name
                end
                # tmux a -t $(tmux ls -F '#{session_name}' | fzf --reverse)
            end
        else if test $argv[1] = "kill"
            if test $(tmux ls | wc -l) -eq 1
                tmux kill-session
            else
                tmux kill-session -t $(tmux ls -F '#{session_name}' | fzf --reverse)
            end
        else
            command tmux $argv
        end
    else
        read -l session -p 'set_color green; echo -n read; set_color normal; echo "> "' && /bin/tmux new-session -s $session
    end
end

# function tmuxe
#     if count $argv > /dev/null
#         if [ $argv[1] = "a" ]
#             if [ $(tmux ls | wc -l) <= 1 ]
#                 tmux a
#             else
#                 tmux a -t $(tmux ls -F '#{session_name}' | fzf --reverse)
#             end
#         else if test $argv[1] = "kill" and test $argv[1] = "k"
#             if [ $(tmux ls | wc -l) = 1 ]
#                 tmux kill-session
#             else
#                 tmux kill-session -t $(tmux ls -F '#{session_name}' | fzf --reverse)
#             end
#         else
#             command tmux $argv
#         end
#     else
#         read -l session -p 'set_color green; echo -n read; set_color normal; echo "> "'
#         /bin/tmux new-session -s $session
#     end
# end
