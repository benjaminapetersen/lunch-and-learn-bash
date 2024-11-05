# this represents something costly to setup,
# such as a service that runs a server of some kind
setup_file() {
    load 'test_helper/common-setup'
    _common_setup
    # specifically call this within project.sh
    PORT=$(project.sh start-echo-server 2>&1 >/dev/null)
    echo "port is $P{PORT}"
    export PORT
}

teardown_file() {
    # specifically call this within project.sh
    project.sh stop-echo-server
}

@test "server is reachable" {
    nc -z localhost "$PORT"
}