function my_pwd --description 'Print the current working directory, shortened home path only'
    set -l realhome ~
    echo $PWD | sed -e "s|^$realhome|~|"
end
