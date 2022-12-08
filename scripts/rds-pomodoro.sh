#!/usr/bin/env bash

# BREAK_TIME=5
# WORK_TIME=25
BREAK_TIME=$((60 * 5))
WORK_TIME=25
CURRENT_TIME=0
CURRENT_LOOP=0

# 1. Start the task (given its id)
# 2. Notify when WORK_TIME is done
# 3. Stop the task
# 4. Notify when BREAK_TIME is done
# 5. Repeat step 1. Keep repeating as many times as given in its args

task_id=$1

task $task_id start

while [ $CURRENT_LOOP -lt "3" ]; do
    sleep 60
    ((CURRENT_TIME++))

    if [ $CURRENT_TIME -eq $WORK_TIME ]; then
        CURRENT_TIME=0
        ((CURRENT_LOOP++))
 
        echo $CURRENT_LOOP

        terminal-notifier \
            -title "Pomodoro - BREAK TIME" \
            -message "Take a break now!"

        sleep $BREAK_TIME

        terminal-notifier \
            -title "Pomodoro - WORK TIME" \
            -message "Get back to work!"

        task $task_id start
    fi
done

task $task_id stop
