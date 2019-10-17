require 'action_view'
require 'yaml'
require 'singleton'
require 'forwardable'
require 'logger'
require 'colorize'

# To prevent errors with classes that rely on these Helpers
require_relative 'helpers/all'

require_relative 'enemy'
require_relative 'logger'
require_relative 'room'
require_relative 'screen'
require_relative 'version'

require_relative 'classes/all'
require_relative 'combat/all'
require_relative 'core_ext/all'
require_relative 'movement/all'
