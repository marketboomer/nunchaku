module Nunchaku
  module Json
    class Base

      class << self
        def whitelist
        end

        def blacklist
        end
      end

      def output(collection_or_root)
        if collection_or_root.kind_of?(::ActiveRecord::Associations::CollectionProxy)
          collection_or_root.map { |r| output_one(r) }
        else
          output_one(collection_or_root)
        end
      end

      protected

      def output_one(root)
        { :type => type(root) }.merge((whitelist(root) - blacklist).inject({}) { |m, w| m[w] = output_for(root, w); m })
      end

      def type(root)
        root.class.name
      end

      def whitelist(root)
        self.class.whitelist || root.attributes.keys
      end

      def blacklist
        self.class.blacklist || []
      end

      def output_for(root, method)
        r = root.class.reflections[method.to_sym]

        if (f = formatter_class_for(r) if r)
          f.new.output(root.send(method))
        else
          root.send(method)
        end
      end

      def formatter_class_for(reflection)
        "#{reflection.try(:class_name).deconstantize}::Json::#{reflection.try(:class_name).demodulize}".safe_constantize
      end
    end
  end
end
