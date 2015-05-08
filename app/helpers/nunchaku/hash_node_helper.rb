module Nunchaku
  module HashNodeHelper

    def leaf_or_branch(node, key)
      node[key].kind_of?(Hash) || node[key].kind_of?(Array) ? branch(node, key) : leaf(node, key)
    end

    protected

    def leaf(node, key)
      content_tag(:div, :class => 'tree-item') do
        content_tag(:div, :class => 'tree-item-name') do
          "#{leaf_tip(node, key)}: #{node[key]}".html_safe
        end
      end
    end

    def branch(node, key)
      v = node[key]

      content_tag(:div, :class => 'tree-folder') do
        [
          content_tag(:div, :class => 'tree-folder-header') do
            content_tag(:div, :class => 'tree-folder-name') do
              key.to_s
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

    def leaf_tip(node, key)
      tooltip(:title => leaf_title(node, key)) do
        "#{[key.to_s, ('*' if resource.api_required_attributes.include?(key.to_s))].compact.join}".html_safe
      end
    end

    def leaf_title(node, key)
      [
        leaf_title_type(node, key),
        leaf_title_description(node, key)
      ].compact.join(', ')
    end

    def leaf_title_type(node, key)
      t = node[key].class.name.underscore.humanize
      if t == 'Nil class'
        ch = node[:type].safe_constantize.columns_hash if node[:type]
        t = ch[key].try(:type) if ch.present?
        t ||= node[key]
      elsif t == 'Big decimal'
        t = 'Big decimal 19,4'
      end
      t ||= 'string'
    end

    def big_decimal
      leaf_title_type(node, key) == 'Big decimal'
    end

    def leaf_title_description(node, key)
      ltd = t("tooltip.#{node[:type].underscore if node[:type]}.#{key}.description", :default => '')
      ltd unless ltd.empty?
    end
  end
end
