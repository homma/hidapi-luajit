#!/bin/sh

# @author Daisuke Homma

stylua ${PWD}/$@ --config-path $(dirname $0)/.stylua.toml
