# bats is Bash Automated Testing System

# run a setup before any tests
setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# as expected via other test frameworks, teardown() 
# will always run at the end, even if there are 
# failed tests
teardown() {
    # since our first run writes to a temp file, we need to clean this up
    # rm -f /tmp/bats-tutorial-project-ran
    rm -f "$NON_EXISTANT_FIRST_RUN_FILE"
    rm -f "$EXISTING_FIRST_RUN_FILE"
    echo "done"
}

@test "can run our script" {
    # TDD style, we write the test first, show this 
    # file doesn't exist or can't be run, then updated.
    # RED to GREEN

    # we can skip tests, so as to not 
    if [[ -e /tmp/bats-tutorial-project-ran ]]; then
        skip 'The FIRST_RUN_FILE already exists'
    fi

    # notice `run`! 
    # run will collect the stdout, stderr and stores as $OUTPUT
    # run will also collect the exit code as $STATUS
    run project.sh

    # interesting we can now make assertions
    # --partial flag can be used for partial matching
    assert_output --partial 'Welcome to our project!'

    # we only want the welcome message to show on first run,
    # so this is a second run, to test the second output
    run project.sh
    refute_output --partial 'Welcome to our project!'
}
