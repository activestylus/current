module Current

  def controller_is?(*attrs)
    attrs.collect{|attr| attr.to_s}.include?(controller_name)
  end

  def action_is?(*attrs)
    attrs.map{|attr| attr.to_s}.include?(action_name)
  end

  def partial_is?(param)
    param == params[:partial]
  end

  def controller_action_is?(c,a)
    controller_is(c) && action_is(a)
  end

  def active_if?(condition)
    condition ? "active" : "inactive"
  end                         

  def nav_link_to(text,path,condition, options={})
    klass = active_if(condition) + " #{options[:class]}"
    linktext = condition ? "#{text}" : text
    link_to(raw(linktext), path, options.merge(:class => klass.strip))
  end

end


ActionView::Base.send :include, Current