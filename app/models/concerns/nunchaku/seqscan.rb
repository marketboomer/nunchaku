module Nunchaku
  module Seqscan
    def seqscan_enabled?
      !!(::ActiveRecord::Base.connection.execute('SHOW enable_seqscan') \
                   .first \
                   .fetch('enable_seqscan') =~ /on/i)
    end

    def disable_seqscan!
      ::ActiveRecord::Base.connection.execute('SET enable_seqscan = OFF')
    end

    def enable_seqscan!
      ::ActiveRecord::Base.connection.execute('SET enable_seqscan = ON')
    end

    def without_seqscan
      return yield unless seqscan_enabled?

      begin
        disable_seqscan!
        yield
      ensure
        enable_seqscan!
      end
    end

    def with_seqscan
      return yield if seqscan_enabled?

      begin
        enable_seqscan!
        yield
      ensure
        disable_seqscan!
      end
    end
  end
end
