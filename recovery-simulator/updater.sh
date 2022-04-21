#!/sbin/sh

# SPDX-FileCopyrightText: (c) 2016-2019, 2021 ale5000
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileType: SOURCE

unset OUR_TEMP_DIR
unset BB_GLOBBING
unset FUNCNAME
unset HOSTNAME
unset LINENO
unset OPTIND
unset OLDPWD

IFS=' 	
'
PS1='\w \$ '
PS2='> '
PS4='+ '

override_applet()
{
  if test "$(uname -o)" != 'MS/Windows'; then
    full_path="$(busybox which "${1}")" || { echo "Failed to override ${1}"; return 1; }
    # shellcheck disable=SC2139
    alias "${1}"="${full_path}"  # This expands when defined, not when used (it is intended)
    unset full_path
  else
    # shellcheck disable=SC2139
    alias "${1}"="${1}."  # This expands when defined, not when used (it is intended)
  fi
}

# Ensure that the overridden commands are preferred over BusyBox applets
override_applet mount || return 1
override_applet umount || return 1
override_applet chown || return 1

unset -f override_applet

# shellcheck source=SCRIPTDIR/../zip-content/META-INF/com/google/android/update-binary.sh
. "${TMPDIR}/update-binary" || return 1
