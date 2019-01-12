#!/bin/python

import yaml
from collections import OrderedDict

def read_yaml_file(dependencies_file):
    with open(dependencies_file, 'r') as f:
        return yaml.load(f)

class Dependencies:
    def __init__(self, yaml_dependency_file, current_distro, environment):
        self.yaml = read_yaml_file(yaml_dependency_file)
        deps = self.yaml['dependencies']
        print "deps type: ", type(deps)
        self.config = GlobalConfig(deps['config'])
        self.env = EnvironmentDependencies(deps[environment], current_distro)

class GlobalConfig:
    def __init__(self, deps_config):
        self.dotfiles = deps_config['dotfiles']
        self.expected = deps_config['expected']
        self.actual = deps_config['actual']

class EnvironmentDependencies:
    def __init__(self, env, current_distro):
        self.distro_methods = {}
        self.config_dirs = {}
        for dep in env:
            for dm in dep['distro_method']:
                if dm['distro'] == current_distro:
                    self.distro_methods.update({ dep['name'] :  dm })
                    if 'config' in dep:
                        self.config_dirs.update({ dep['name'] : dep['config'] })


def command_exists(command):
    exists = local('command -v ' + command + ' >/dev/null 2>&1 || { echo "False"; }', capture=True)
    return exists != 'False'

def dir_exists(dir):
    exists = local('if [ -d ' + dir + ' ]; then echo "true"; else echo "false"; fi;', capture=True)
    return exists == "true"
