#!/bin/bash -
#
#
# ,tn
cleanup() {
    # Clean up file before exit, we will use this function with the trap command
    if [ -e "$msg_file" ]; then
        mv "$msg_file" dead.letter
    fi
    exit
}
#
trap cleanup INT TERM       # Cleanup if we get CTRL-C or TERM signals
msg_file="/tmp/msg$$"         # Constructing name of the temporary file.
cat > $msg_file
cat $msg_file
# Send the contents of $msg_file to the specified mail address
rm $msg_file
