merge = require 'lodash.merge'

camelize = (str) ->

  str.replace /(?:^|[-_])(\w)/g, (_, c) ->

    if c then return c.toUpperCase() else return ''

module.exports = (config={}, options={}) ->

  { file, alias, cwd } = options

  cwd ?= process.env.PWD

  if file then file = require "#{file}"

  alias ?= camelize require("#{cwd}/package").name

    .replace(/^a-http-server-plugin-/, '')

  config[alias] = merge config[alias] or {}, file or {}
