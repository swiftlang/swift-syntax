#!/usr/bin/env python

import os
import re
import glob
import shutil
import datetime
import sys
import getopt
import pipes
import subprocess

SOURCE_DIR = os.path.realpath(os.path.dirname(os.path.realpath(__file__)) + '/..')
BUILD_SCRIPT = SOURCE_DIR + '/build-script.py'
GYB_GEN_SOURCE_DIR = SOURCE_DIR + '/Sources/SwiftSyntax/gyb_generated/'

def escapeCmdArg(arg):
    if '"' in arg or ' ' in arg:
        return '"%s"' % arg.replace('"', '\\"')
    else:
        return arg

# Git Utils
def git(git_command, cwd):
    '''Run a git command.'''
    command = ['git'] + git_command
    check_call(command, cwd=cwd, verbose=True)

def git_tag(tag,src_path):
  '''Tag git repo'''
  git(['tag','-a',tag,'-m','Tag build ' + tag],src_path)

def git_push_tag(tag,src_path):
  '''Push git tag'''
  git(['push', 'origin', tag], src_path)

def git_clone(repo_url,src_path):
  '''Push git tag'''
  git(['clone', repo_url], src_path)

def check_call(cmd, cwd=None, env=os.environ, verbose=False):
    if verbose:
        print(' '.join([escapeCmdArg(arg) for arg in cmd]))
    return subprocess.check_call(cmd, cwd=cwd, env=env, stderr=subprocess.STDOUT)

def degyb():
    check_call([BUILD_SCRIPT, '--degyb-only'])

def main(argv):
	# Generate gyb files
	degyb()
	# Force commit gyb files
	git(git_command=['add', '-f', GYB_GEN_SOURCE_DIR + '/*.swift'], cwd=SOURCE_DIR)
	git(git_command=['commit', '-m', 'Auto-commit: add degybed files'], cwd=SOURCE_DIR)

if __name__ == "__main__":
  main(sys.argv[1:])
