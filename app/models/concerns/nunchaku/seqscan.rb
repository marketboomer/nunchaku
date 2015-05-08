module Nunchaku
  module Seqscan
    def seqscan_enabled?(connection = ::ActiveRecord::Base.connection)
      !!(connection.execute('SHOW enable_seqscan') \
                   .first \
                   .fetch('enable_seqscan') =~ /on/i)
    end

    def disable_seqscan!(connection = ::ActiveRecord::Base.connection)
      connection.execute('SET enable_seqscan = OFF')
    end

    def enable_seqscan!(connection = ::ActiveRecord::Base.connection)
      connection.execute('SET enable_seqscan = ON')
    end

    def without_seqscan(connection = ::ActiveRecord::Base.connection)
      return yield unless seqscan_enabled?

      begin
        disable_seqscan!
        yield
      ensure
        enable_seqscan!
      end
    end

    def with_seqscan(connection = ::ActiveRecord::Base.connection)
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
