#!/usr/bin/env bash

set -eou pipefail

print_success() {
    lightcyan='\033[1;36m'
    nocolor='\033[0m'
    echo -e "${lightcyan}$1${nocolor}"
}

print_error() {
    lightred='\033[1;31m'
    nocolor='\033[0m'
    echo -e "${lightred}$1${nocolor}" ; exit 1;
}

print_alert() {
    yellow='\033[1;33m'
    nocolor='\033[0m'
    echo -e "${yellow}$1${nocolor}"
}

# Prepare variables with better common names
if [[ -n "${1}" ]]; then
    code_path="${1}" && \
        cd "${code_path}"
else
    print_error "Code path is empty or invalid, check the following tree output and see if it is as you expect - Error - LDO_CD_CODE_PATH" && tree . && exit 1
fi


if [[ -n "${2}" ]]; then
    code_svp_client_id="${2}"
else
    print_error "Variable assignment for service principle has failed or is invalid, ensure it is correct and try again - Error LDO_CD_CLIENT_ID" ; exit 1
fi

if [[ -n "${3}" ]]; then
    code_svp_client_secret="${3}"
else
    print_error "Variable assignment for client secret name failed or is invalid, ensure it is correct and try again - Error LDO_CD_CLIENT_SECRET" ; exit 1
fi

if [[ -n "${4}" ]]; then
    code_svp_tenant_id="${4}"
else
    print_error "Variable assignment for tenant id failed or is invalid, ensure it is correct and try again - Error LDO_CD_TENANT_ID" ; exit 1
fi

if [[ -n "${5}" ]]; then
    code_function_app_name="${5}"
else
    print_error "Variable assignment for function app name has failed or is invalid, ensure it is correct and try again - Error LDO_CD_APP_NAME" ; exit 1
fi

if [[ -n "${6}" ]]; then
    code_function_app_command="${6}"
else
    print_error "Variable assignment for function app command, ensure it is correct and try again - Error LDO_CD_DEPLOY_COMMAND" ; exit 1
fi

az login --service-principal -u "${code_svp_client_id}" -p "${code_svp_client_secret}" --tenant "${code_svp_tenant_id}" &>/dev/null

# shellcheck disable=SC2046
if [ $(az account show) ]; then
    ${code_function_app_command} "${code_function_app_name}"
    print_success "Deployment complete" && exit 0

    else
      print_alert "Something went wrong"
      print_error "Please check any outputs and try again" && exit 1
fi