module RSpec
  module Todo
    def todo(reason = nil, &block)
      if block_given?
        begin
          yield
        rescue => e
          if reason
            pending(reason)
          else
            pending(e.inspect)
          end
        end
      else
        pending(reason)
      end
    end

    def not_todo(reason = nil, *errors_expected, &block)
      if block_given?
        begin
          yield
        rescue RSpec::Expectations::ExpectationNotMetError, *errors_expected => e
          # do nothing
        else
          if reason
            raise(reason)
          else
            raise "not todo but passed"
          end
        end
      else
        pending(reason)
      end
    end
  end
end
