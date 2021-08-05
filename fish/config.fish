set -x GOPATH /Users/laodouya/go
set -x PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin $GOPATH $GOPATH/bin

set -x PIPENV_PYPI_MIRROR http://mirrors.aliyun.com/pypi/simple/

# set -x C_INCLUDE_PATH /usr/local/opt/python/Frameworks/Python.framework/Versions/3.7/Headers

if status --is-interactive
    keychain --eval --quiet -Q id_rsa | source
end
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
