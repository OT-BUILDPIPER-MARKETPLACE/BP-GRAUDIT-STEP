#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

CODE="$WORKSPACE/$CODEBASE_DIR"

logInfoMessage "I'll scan the CODEbase $CODE for vulnerabilities using Graudit to ensure the application's security."
sleep $SLEEP_DURATION

if [ -d "reports" ]; then
   true
else
   mkdir reports
fi

if [ -d $CODE ]; then
    logInfoMessage "Executing command"
    logInfoMessage "graudit -A -d /usr/share/graudit/$LANGUAGE.db $CODE"
    graudit -A -d /usr/share/graudit/$LANGUAGE.db $CODE  > reports/$OUTPUT_ARG

    if [ $(wc -l < reports/$OUTPUT_ARG) -gt 10 ]; then
        if [ "$VALIDATION_FAILURE_ACTION" == "FAILURE" ]
        then
            logErrorMessage "Graudit scan found potential security vulnerabilities."
            generateOutput $ACTIVITY_SUB_TASK_CODE false "Graudit scan found potential security vulnerabilities."
            logErrorMessage "Please review the Graudit scan report for more information."
            logErrorMessage "Please check the Git repository Graudit vulnerabilities scan failed.!!!"
            cat "reports/$OUTPUT_ARG"
            exit 1
        else
            logErrorMessage "Graudit scan found potential security vulnerabilities."
            generateOutput $ACTIVITY_SUB_TASK_CODE false "Graudit scan found potential security vulnerabilities."
            logWarningMessage "Please review the Graudit scan report for more information."
            logWarningMessage "Please check the Git repository Graudit vulnerabilities scan failed.!!!"
            cat "reports/$OUTPUT_ARG"
        fi
    else
        logInfoMessage "Congratulations Graudit scan succeeded with no vulnerabilities found."
        generateOutput $ACTIVITY_SUB_TASK_CODE true "Congratulations Graudit scan succeeded with no vulnerabilities found."
    fi
else
    logErrorMessage "$CODE: CODEbase directory is not found"
    generateOutput $ACTIVITY_SUB_TASK_CODE false "$CODE CODEbase directory is not found."
    logErrorMessage "Please check the Git repository Graudit vulnerabilities scan failed.!!!"
fi

