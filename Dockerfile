FROM reijaff/graudit
RUN apt-get install jq -y
COPY build.sh .
COPY BP-BASE-SHELL-STEPS .
RUN chmod +x build.sh
ENV ACTIVITY_SUB_TASK_CODE BP-BANDIT-TASK
ENV SLEEP_DURATION 5s
ENV VALIDATION_FAILURE_ACTION WARNING
ENV LANGUAGE "python"
ENV OUTPUT_ARG "graudit-report.txt"
ENTRYPOINT [ "./build.sh" ]


