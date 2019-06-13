srit ()
{
    stringer="$@";
    ssh root@"$1" "${stringer#"$1 "}";
    unset stringer
}

getuserhome ()
{
    x=$(ssh root@nfsroot2 "su - $(echo $1) -c \"ls -la ~\"" 2>&1);
    if [[ $x == *"does not exist" ]]; then
        echo ${x#"su: "} 1>&2;
    else
        if [[ $x == */ ]]; then
            x=$(echo $x | rev | cut -d'/' -f3 | rev);
        else
            x=$(echo $x | rev | cut -d'/' -f2 | rev);
        fi;
        ssh root@nfsroot2 "mount" | grep $x | cut -f1 -d'.';
    fi;
    unset x
}

alias sr='ssh -l root'
