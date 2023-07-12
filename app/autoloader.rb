# frozen_string_literal: true

require 'active_support/all'
require 'yaml'
require 'singleton'
require 'forwardable'
require 'logger'
require 'colorize'
require 'ostruct'

# To prevent errors with classes that rely on these Helpers
require_relative 'helpers'

require_relative 'armor'
require_relative 'enemy'
require_relative 'key'
require_relative 'logger'
require_relative 'potion'
require_relative 'room'
require_relative 'screen'
require_relative 'shop'
require_relative 'version'
require_relative 'weapon'

require_relative 'actions'
require_relative 'classes'
require_relative 'combat'
require_relative 'presenters'
