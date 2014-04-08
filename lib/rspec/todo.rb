module RSpec
  module Todo
    def rspec_todo_works_for(opts = {})
      if opts[:if].nil? && opts[:unless].nil?
        true
      else
        opts[:if] || (opts[:unless].nil? ? false : !opts[:unless])
      end
    end

    def todo(reason = nil, opts = {}, &block)
      reason, opts = nil, reason if reason.is_a?(Hash)

      if rspec_todo_works_for(opts)
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
      else
        yield
      end
    end

    def not_todo(reason = nil, opts = {}, &block)
      reason, opts = nil, reason if reason.is_a?(Hash)

      if rspec_todo_works_for(opts)
        if block_given?
          begin
            yield
          rescue RSpec::Expectations::ExpectationNotMetError, *opts[:errors] => e
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
      else
        yield
      end
    end
  end
end
