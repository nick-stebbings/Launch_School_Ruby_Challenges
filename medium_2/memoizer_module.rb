# memoizer_module.rb
# from https://medium.com/@kklimuk/memoization-in-ruby-made-easy-a4b0f6c11846

module RubyMemoized
  class Memoizer
    attr_reader :context, :method

    def initialize(context, method)
      @context = context
      @method = method
    end

    def call(*args, &block)
      return cache[[args, block]] if cache.has_key?([args, block])

      cache[[args, block]] = context.send(method, *args, &block)
    end

    def cache
      @cache ||= {}
    end
  end

  def self.included(klass) # When the module is included..
    klass.extend(ClassMethods) # Extends the ClassMethods making them available to klass
  end

  module ClassMethods
    def memoized
      @memoized = true
    end

    def unmemoized
      @memoized = false
    end

    def method_added(method_name)
      if @memoized
        @memoized = false

        unmemoized_method_name = :"unmemoized_#{method_name}"

        memoizer_name = :"memoizer_for_#{method_name}"
        define_method memoizer_name do
          memoizer = instance_variable_get "@#{memoizer_name}"
          memoizer || instance_variable_set "@#{memoizer_name}", Memoizer.new(self, unmemoized_method_name)
        end
        binding.pry
        alias_method unmemoized_method_name, method_name

        define_method method_name do |*args, &block|
          send(memoizer_name).call(*args, &block)
        end

        @memoized = true
      end
    end
  end
end
