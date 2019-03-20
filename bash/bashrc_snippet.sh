
# Path manipulation functions.

dedup_path() {
    local -a inpath outpath=()
    local -A seen
    local item
    local IFS=:

    inpath=($1)
    for item in "${inpath[@]}"; do
        if [[ -z "${seen[path:${item}]}" ]]; then
            seen["path:${item}"]=1
            outpath+=("${item}")
        fi
    done
    echo "${outpath[*]}"
}

prepend_path() {
    local IFS=:

    if [[ "$#" != 0 ]]; then
        PATH=$*${PATH+:${PATH}}
        PATH=$(dedup_path "${PATH}")
    fi
}


# start ssh-agent if one is not yet running for this session
setup_ssh_agent() {
    local agentfile=~/.ssh/agent.$HOSTNAME
    local started_agent=
    if [[ ! -f "${agentfile}" ]]; then
        ssh-agent >"${agentfile}"
        started_agent=yes
    fi
    . "${agentfile}" >/dev/null
    [[ -n "$SSH_AGENT_PID" ]] && ps "$SSH_AGENT_PID" >/dev/null 2>&1 || {
        rm -f "${agentfile}"
        ssh-agent >"${agentfile}"
        started_agent=yes
        . "${agentfile}" >/dev/null
    }
    if [[ -n "${started_agent}" ]]; then
        # Source github key when a new agent is started.
        ssh-add ~/.ssh/id_rsa_github 2>/dev/null
    fi
}


# Do not break on a single Ctrl+D inside tmux.
[[ "${TMUX+set}" == "set" ]] && ignoreeof=10

# Set PS1 to include information about the git branch.
. /usr/lib/git-core/git-sh-prompt
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
