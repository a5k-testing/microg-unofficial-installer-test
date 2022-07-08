# SPDX-FileCopyrightText: none
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileType: SOURCE

require 'simplecov'
require 'simplecov-cobertura'

#SimpleCov.enable_for_subprocesses true
SimpleCov.formatter SimpleCov::Formatter::CoberturaFormatter
SimpleCov.add_filter 'gradlew'
