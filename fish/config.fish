set -x GOROOT /usr/local/go
set -x GOBIN $GOROOT/bin
set -x GOPATH $HOME/gopath
set -x PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /home/laodouya/bin $GOBIN $GOPATH $GOPATH/bin

function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_command $history[1]
    thefuck $fucked_up_command > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_command
    end
end
