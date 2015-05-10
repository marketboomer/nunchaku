module Nunchaku
  class DomainConstraint
    def initialize(domain)
      @domain = domain
    end

    def matches?(request)
      @domain.match(request.host)
    end
  end
end