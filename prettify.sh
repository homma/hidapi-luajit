#!/bin/sh

# @author Daisuke Homma

stylua -v ${PWD}/*.lua --config-path $(dirname $0)/.stylua.toml
