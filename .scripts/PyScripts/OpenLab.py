#!/usr/bin/env python3

import os
import json

def main():
    proj_path = "/home/moises/GNS3/projects"
    projects = os.listdir(proj_path)
    print("ID : Name")
    for index, proj in enumerate(projects, start=1):
        print(f"{index:02} : {proj}")
    proj_id = int(input("Enter project ID: "))
    proj_name = projects[proj_id-1]
    proj_file = f"{proj_path}/{proj_name}/{proj_name}.gns3"

    with open(proj_file) as f:
        data = json.loads(f.read())
        for node in data["topology"]["nodes"]:
            node_type = node["node_type"]
            if node_type == "ethernet_switch": continue # skip unmanaged switches
            node_name, node_port = node['name'], node['console']
            # os.system(f"kitty --title {node_name} telnet localhost {node_port} &")
            os.system(f"kitty @ launch --type=tab --tab-title {node_name} --keep-focus telnet localhost {node_port}")
        os.system(f"kitty +kitten broadcast")


if __name__ == '__main__':
    main()

