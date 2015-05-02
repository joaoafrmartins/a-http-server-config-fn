{ sep } = require 'path'

merge = require 'lodash.merge'

camelize = (str) ->

  first = true

  str.replace /(?:^|[-_])(\w)/g, (_, c) ->

    if first

      first = false

      return c

    if c then return c.toUpperCase() else return ''

module.exports = (config={}, options={}) ->

  type = undefined

  if typeof options is "string"

    file = options

  else

    { file, alias } = options

  name = file.split(sep)

  name = name[name.length-3]

  if file then file = require "#{file}"

  if name.match(/^a-http-server-plugin-/ )isnt null

    type = "plugins"

  else if name.match(/^a-http-server-component-/) isnt null

    type = "components"

  alias ?= camelize name.replace(

    /^a-http-server-[plugin|component]+-/, ''

  )

  c = merge config[alias] or {}, file or {}

  if type and config[type][name]

    c = merge c, config[type][name]

    delete config[type][name]

    config[type][alias] = c

  config
