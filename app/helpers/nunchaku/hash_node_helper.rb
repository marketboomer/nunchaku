module Nunchaku
  module HashNodeHelper

    def leaf_or_branch(k, v)
      v.kind_of?(Hash) || v.kind_of?(Array) ? branch(k, v) : leaf(k, v)
    end

    def leaf(k, v)
      content_tag(:div, :class => 'tree-item') do
        content_tag(:div, :class => 'tree-item-name') do
          "#{k}: #{v}"
        end
      end
    end

    def branch(k, v)
      content_tag(:div, :class => 'tree-folder') do
        [
          content_tag(:div, :class => 'tree-folder-header') do
            content_tag(:div, :class => 'tree-folder-name') do
              [ k, ('*' if v.kind_of?(Array)) ].compact.join(' ')
            end
          end,

          content_tag(:div,:class => 'tree-folder-content') do
            content_tag(:div, :class => 'tree-folder-name') do
              if v.kind_of?(Hash)
                render :partial => 'hash_node', :object => v
              else
                render :partial => 'hash_node', :collection => v
              end
            end
          end
        ].join.html_safe
      end
    end
  end
end
