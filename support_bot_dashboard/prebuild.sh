#!/usr/bin/env bash
touch lib/l10n/intl_en.arb
flutter gen-l10n --template-arb-file=intl_en.arb
dart run intl_utils:generate
