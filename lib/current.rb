module Current

  def controller_is(*attrs)
    attrs.collect{|attr| attr.to_s}.include?(controller_name)
    alias_method :controller_is?, :controller_is
  end

  def action_is(*attrs)
    attrs.map{|attr| attr.to_s}.include?(action_name)
    alias_method :action_is?, :action_is
  end

  def partial_is(param)
    param == params[:partial]
    alias_method :partial_is?, :partial_is
  end

  def controller_action_is(c,a)
    controller_is(c) && action_is(a)
    alias_method :controller_action_is?, :controller_action_is
  end

  def active_if(condition)
    condition ? "active" : "inactive"
    alias_method :active_if?, :active_if
  end                         

  def nav_link_to(text,path,condition, options={})
    klass = active_if(condition) + " #{options[:class]}"
    linktext = condition ? "#{text}" : text
    link_to(raw(linktext), path, options.merge(:class => klass.strip))
  end

end


ActionView::Base.send :include, Current