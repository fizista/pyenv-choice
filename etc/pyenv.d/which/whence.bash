if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ -n "${versions}" ]; then
    if [ "${#versions[@]}" -ge 1 ]; then
      main_version=$(pyenv-cmd-local "${PYENV_COMMAND}" 2>/dev/null || true)
      if [ -n "$main_version" ]; then
        echo -e "############################### \e[1mpyenv-choice\e[0m #################################" 1>&2
        echo -e "Found multiple \e[1m${PYENV_COMMAND}\e[0m versions. The command was launched from a manually" 1>&2
        echo -e "selected version of the python \e[1m'${main_version}'\e[0m." 1>&2
        echo "You can change it with the commands: " 1>&2
        echo "  > pyenv cmd-global ${PYENV_COMMAND} <version>" 1>&2
        echo "  > pyenv cmd-local ${PYENV_COMMAND} <version>" 1>&2
        echo "##############################################################################" 1>&2
        echo "" 1>&2
        PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${main_version}/bin/${PYENV_COMMAND}"
        if [ ! -f "$PYENV_COMMAND_PATH" ]; then
          echo "The '${PYENV_COMMAND}' command does not exist for the '${main_version}' version." 1>&2
          exit 1
        fi
      else
        function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }
        available_versions=$(join_by '$|^' $(pyenv whence "${PYENV_COMMAND}" 2>/dev/null | grep -v '/'))
        if [ -z "$available_versions" ]; then
          echo "The '${PYENV_COMMAND}' command does not exist in any installed python version." 1>&2
          exit 1
        fi
        last_version=$(ls -t ${PYENV_ROOT}/versions/ | awk "\$1 ~ /^${available_versions}/" | head -n1)
        PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${last_version}/bin/${PYENV_COMMAND}"
        if [ ! -f "$PYENV_COMMAND_PATH" ]; then
          echo "The '${PYENV_COMMAND}' command does not exist for the '${main_version}' version." 1>&2
          exit 1
        fi
        echo -e "############################### \e[1mpyenv-choice\e[0m #################################" 1>&2
        echo -e "Found multiple \e[1m${PYENV_COMMAND}\e[0m versions. The command was launched from" 1>&2
        echo -e "the last installed version of the python \e[1m'${last_version}'\e[0m." 1>&2
        echo "You can change it with the commands: " 1>&2
        echo "  > pyenv cmd-global ${PYENV_COMMAND} <version>" 1>&2
        echo "  > pyenv cmd-local ${PYENV_COMMAND} <version>" 1>&2
        echo "##############################################################################" 1>&2
        echo "" 1>&2
      fi
    fi
  fi
fi

