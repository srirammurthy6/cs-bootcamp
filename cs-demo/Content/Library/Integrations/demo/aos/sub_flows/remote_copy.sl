namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host: 10.0.46.54
    - username: root
    - password: admin@123
    - url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/deploy_war.sh'
    - flow_input_0
    - script_location: /tmp
  workflow:
    - extract_filename_1:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: get_file
    - get_file:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - destination_file: '${filename}'
            - method: GET
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_host: null
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: '${script_location}'
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename_1:
        x: 222
        y: 121
      get_file:
        x: 222
        y: 359
      remote_secure_copy:
        x: 420
        y: 362
        navigate:
          2fde26a6-e5fe-e7ff-bd72-a4a3ce52d28d:
            targetId: 6ff55228-8a89-4753-c2e2-3ad2c956c0d9
            port: SUCCESS
    results:
      SUCCESS:
        6ff55228-8a89-4753-c2e2-3ad2c956c0d9:
          x: 415
          y: 128
