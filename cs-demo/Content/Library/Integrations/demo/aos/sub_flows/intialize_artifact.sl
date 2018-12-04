namespace: Integrations.demo.aos.sub_flows
flow:
  name: intialize_artifact
  inputs:
    - host
    - username:
        required: true
    - password
    - artifiact_url:
        required: false
    - script_url
    - parameters:
        required: false
    - copy_artifact
  workflow:
    - is_artifact_given:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${artifiact_url}'
        navigate:
          - SUCCESS: copy_script
          - FAILURE: copy_artifact
    - copy_script:
        do:
          Integrations.demo.aos.sub_flows.remote_copy: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: execute_script
    - copy_artifact:
        do:
          Integrations.demo.aos.sub_flows.remote_copy:
            - script_location: "${get_sp('script_location')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: copy_script
    - execute_script:
        do:
          io.cloudslang.base.ssh.ssh_command: []
        navigate:
          - FAILURE: on_failure
    - delete_file:
        do:
          Integrations.demo.aos.tools.delete_file: []
        navigate:
          - FAILURE: on_failure
  outputs:
    - artifact_name
  results:
    - FAILURE
extensions:
  graph:
    steps:
      is_artifact_given:
        x: 388
        y: 28
      copy_script:
        x: 522
        y: 225
      copy_artifact:
        x: 213
        y: 228
      execute_script:
        x: 194
        y: 404
      delete_file:
        x: 506
        y: 434
