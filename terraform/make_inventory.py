import pprint
import json
import sys
import os

PATH = os.path.dirname(os.path.abspath(__file__))
INVENTORY_FILE_PATH = os.path.join(PATH,'..','ansible\\hosts')
inventory_template = '''[masters]
{spot_cdh_master}

[workers]
{spot_cdh_worker}

[all:vars]
ansible_ssh_user=centos
ansible_ssh_private_key_file=~/.ssh/amitthk_jenkinsmaster.pem
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
'''

def parse_file(file_name):
    result = {}
    with open(file_name,'r') as tf_file:
        tf_data = json.loads(tf_file.read())
        buffer = {}
        for element in tf_data['modules']:
            buffer = {}
            buffer = element['outputs']
            resource_info = buffer.copy()
            resource_info.update(buffer)

        for key, value in resource_info.iteritems():
            result[key] = value['value']
    return result

def write_to_file(file_name,f_output):
    with open(file_name,'w') as f:
        f.write(f_output)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print('Usage: make_inventory.py <tfstate file name>')
        sys.exit()
    value_dict = parse_file(sys.argv[1])
    value_dict_normalized = {}
    for key, value in value_dict.iteritems():
        if isinstance(value_dict[key],list):
            value_dict_normalized[key] = '\n'.join(value_dict[key])
        else:
            value_dict_normalized[key] = value_dict[key]
    inventory_value = str(inventory_template.format(**value_dict_normalized))
    write_to_file(INVENTORY_FILE_PATH,inventory_value)