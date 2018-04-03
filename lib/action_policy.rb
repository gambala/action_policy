# frozen_string_literal: true

# ActionPolicy is an authorization framework for Ruby/Rails applications.
#
# It provides a way to write access policies and helpers to check these policies
# in your application.
module ActionPolicy
  class Error < StandardError; end

  # Raised when Action Policy fails to find a policy class for a record.
  class NotFound < Error
    attr_reader :target, :message

    def initialize(target)
      @target = target
      @message = "Couldn't find policy class for #{target.inspect}"
    end
  end

  require "action_policy/version"
  require "action_policy/base"
  require "action_policy/lookup_chain"
  require "action_policy/authorizer"
  require "action_policy/behaviour"

  class << self
    # Find a policy class for a target
    def lookup(target, **options)
      LookupChain.call(target, **options) ||
        raise(NotFound, target)
    end
  end
end
