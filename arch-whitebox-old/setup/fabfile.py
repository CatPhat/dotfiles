#!/bin/python

from fabric.api import *
from fabric.contrib import files
from fabric.context_managers import lcd
from utilities import Dependencies as Deps
from collections import OrderedDict

dependencies_file = 'dependencies.yaml'

# Distros
arch = 'Arch'
ubuntu = 'Ubuntu'
Debian = 'Debian'


def loadenv(environment = ''):
    """Load configuration for environment"""
    env.distro = local('lsb_release -si', capture=True)
    return Deps(dependencies_file, env.distro, environment)

def install_openssh():
    local('sudo pacman --noconfirm -S openssh')


def install_environment_deps(Deps, deps_to_install = []):
    install_all_deps = False
    print "deps to install: ", deps_to_install
    if not deps_to_install:
        install_all_deps = True
    for dep,dm in Deps.env.distro_methods.items():
        if install_all_deps == False and dep not in deps_to_install:
            print dep + ' not in deps_to_install, ignoring...'
            continue
        if not command_exists(dep):
            m = dm['method']
            if m == 'package':
                package_name = dm['package_name']
                if env.distro == arch:
                    install_arch_package(package_name)
            if m == 'pkgbuild':
                if env.distro == arch:
                    install_arch_pkgbuild(dm)
            if m == 'aur':
                if env.distro == arch:
                    aur_name = dm['aur_name']
                    install_arch_aurpackage(aur_name)

def install_environment_configuration(Deps, deps_to_configure = []):
    install_all_configurations = False
    if not deps_to_configure:
        install_all_configurations = True
    if Deps.env.config_dirs:
        if not command_exists('stow'):
            install_environment_deps(Deps, 'stow')
    if not local_exists(Deps.config.expected):
        local('mkdir -p ' + Deps.config.expected)
    for dep_name, config in Deps.env.config_dirs.items():
        config_expected = config['expected']
        config_actual = Deps.config.actual + '/' + dep_name
        print 'name: ', dep_name
        print 'expected config: ', config_expected
        print 'actual config: ', config_actual
        if not local_exists(Deps.config.expected + '/' + dep_name):
            local('mkdir ' + Deps.config.expected + '/' + dep_name)
        config_expected_dir = local('dirname ' + config_expected, capture=True)
        config_actual_dir = local('dirname ' + config_actual, capture=True)
        print 'config_expected_dir ', config_expected_dir
        print 'config_actual_dir ', config_actual_dir
        local('stow -S ' + dep_name + ' -d ' + config_actual_dir + ' -t ' + config_expected_dir)

def command_exists(command):
    exists = local('command -v ' + command + ' >/dev/null 2>&1 || { echo "False"; }', capture=True)
    return exists != 'False'

def local_exists(dir):
    exists = local('if [ -d ' + dir + ' ]; then echo "true"; else echo "false"; fi;', capture=True)
    return exists == "true"

def install_arch_package(package_name):
    local('sudo pacman --noconfirm -S ' + package_name)


def install_arch_pkgbuild(arch_distro_method):
    submodule_dir = arch_distro_method['submodule_dir']
    pkgbuild_subdir = arch_distro_method['pkgbuild_dir']
    git_url = arch_distro_method['git_url']

    if local_exists(submodule_dir) == False:
        local('git clone ' + git_url + ' ' + submodule_dir)
    with lcd(pkgbuild_subdir):
        local('makepkg --noconfirm -si')

def install_arch_aurpackage(package_name):
    local('trizen --noconfirm -S ' + package_name)


@task
def install_environment_config(deps_to_configure = []):
    deps = loadenv('desktop')
    install_environment_configuration(deps, deps_to_configure)

@task
def install_environment(deps_to_install = []):
    deps = loadenv('desktop')
    install_environment_deps(deps, deps_to_install)
