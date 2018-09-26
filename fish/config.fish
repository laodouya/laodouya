set -x GOPATH /Users/laodouya/gopath
set -x PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin $GOPATH $GOPATH/bin

set -x PIPENV_PYPI_MIRROR http://mirrors.aliyun.com/pypi/simple/

if status --is-interactive
    keychain --eval --quiet -Q id_rsa | source
end
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
