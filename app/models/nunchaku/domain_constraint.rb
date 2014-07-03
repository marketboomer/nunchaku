module Nunchaku
  class DomainConstraint
    def initialize(domain)
      @domain = domain
    end

    def matches?(request)
      request.subdomain.include?(@domain)
    end
  end
end