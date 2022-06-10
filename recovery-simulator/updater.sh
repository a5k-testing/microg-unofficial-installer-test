#!/sbin/sh
# SPDX-FileCopyrightText: (c) 2022 ale5000
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileType: SOURCE

function_exists()
{
  LC_ALL=C type "${1:?}" 2>/dev/null | grep -Fq -- 'is a function'
}

override_command_fallback()
{
  # shellcheck disable=SC2139
  alias "${1:?}='${OVERRIDE_DIR:?}/${1:?}'" || return "${?}"  # This expands when defined, not when used
}

unset OUR_TEMP_DIR
unset FUNCNAME
unset HOSTNAME
unset LINENO
unset OPTIND

IFS=' 	
'
PS1='\w \$ '
PS2='> '
if test "${COVERAGE:-false}" = 'false'; then
  PS4='+ '
fi

# Ensure that the overridden commands are preferred over BusyBox applets (and that unsafe commands aren't accessible)
export BB_OVERRIDE_APPLETS='su sudo mount umount chown' || exit 125
override_command_fallback mount || exit 124
override_command_fallback umount || exit 124
override_command_fallback chown || exit 124
override_command_fallback su || exit 124
override_command_fallback sudo || exit 124

unset -f function_exists
unset -f override_command_fallback
unset OVERRIDE_DIR

# shellcheck source=SCRIPTDIR/../zip-content/META-INF/com/google/android/update-binary.sh
. "${TMPDIR:?}/update-binary" || exit "${?}"
